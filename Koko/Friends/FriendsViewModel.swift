//
//  FriendsViewModel.swift
//  Koko
//
//  Created by Arco Hsieh on 2024/12/10.
//

import Foundation
import RxSwift
import RxCocoa
import RxSwiftExt

protocol FriendsViewModelInputs: AnyObject {
    var viewDidLoad: PublishRelay<Void> { get }
    var searchingText: PublishRelay<String?> { get }
    var pullToRefresh: PublishRelay<Void> { get }
}

protocol FriendsViewModelOutputs: AnyObject {
    var friendInvitings: Signal<[Friend]> { get }
    var friendsInList: Signal<[Friend]> { get }
    var isFriendsEmpty: Signal<Bool> { get }
    var isRefreshing: Driver<Bool> { get }
}

protocol FriendsViewModelType: AnyObject {
    var appDependency: AppDependency { get }
    var inputs: FriendsViewModelInputs { get }
    var outputs: FriendsViewModelOutputs { get }
}

final class FriendsViewModel:
    FriendsViewModelType,
    FriendsViewModelInputs,
    FriendsViewModelOutputs
{
    let appDependency: AppDependency
    var inputs: FriendsViewModelInputs { return self }
    var outputs: FriendsViewModelOutputs { return self }
    
    // MARK: Inputs
    
    let viewDidLoad = PublishRelay<Void>()
    let searchingText = PublishRelay<String?>()
    let pullToRefresh = PublishRelay<Void>()
    
    // MARK: Outputs
    
    let friendInvitings: Signal<[Friend]>
    let friendsInList: Signal<[Friend]>
    let isFriendsEmpty: Signal<Bool>
    let isRefreshing: Driver<Bool>
    
    // MARK: Initial
    
    let disposeBag = DisposeBag()
    
    init(appDependency: AppDependency) {
        let friendsRelay = PublishRelay<[Friend]>()
        let friendInvitingsRelay = PublishRelay<[Friend]>()
        let displayedFriends = PublishRelay<[Friend]>()
        let isFriendsEmptyRelay = PublishRelay<Bool>()
        let isRefreshingRelay = BehaviorRelay(value: false)
        
        let delayedPullToFresh = pullToRefresh.asObservable()
            .do(onNext: { isRefreshingRelay.accept(true) })
            .flatMap { Observable.just(()).delay(.seconds(2), scheduler: MainScheduler.instance) } // 測試用，看起來真實一點
        
        Observable.of(viewDidLoad.asObservable(), delayedPullToFresh)
            .merge()
            .flatMapLatest { appDependency.apiClient.getFriends() }
            .map { $0.deduplicated().sorted(by: >) }
            .do(onNext: { friendsRelay.accept($0) })
            .map { $0.filterInListFriends() }
            .bind(to: displayedFriends)
            .disposed(by: disposeBag)
        
        searchingText.asObservable()
            .unwrap()
            .withLatestFrom(friendsRelay.asObservable()) { ($0, $1) }
            .map { (searchingText, friends) in
                friends.filter { friend in
                    guard !searchingText.isEmpty else { // 清空 SearchBar 就顯示原本所有的資料
                        return true
                    }
                    return friend.name.contains(searchingText)
                }
                .deduplicated()
                .sorted(by: >)
            }
            .map { $0.filterInListFriends() }
            .bind(to: displayedFriends)
            .disposed(by: disposeBag)
        
        friendsRelay.asObservable()
            .map { $0.filterInvitingFriends() }
            .bind(to: friendInvitingsRelay)
            .disposed(by: disposeBag)
        
        friendsRelay.asObservable()
            .map { $0.isEmpty }
            .bind(to: isFriendsEmptyRelay)
            .disposed(by: disposeBag)
        
        friendsRelay.asObservable()
            .mapTo(false)
            .bind(to: isRefreshingRelay)
            .disposed(by: disposeBag)
        
        self.appDependency = appDependency
        self.friendInvitings = friendInvitingsRelay.asSignal()
        self.friendsInList = displayedFriends.asSignal()
        self.isFriendsEmpty = isFriendsEmptyRelay.asSignal()
        self.isRefreshing = isRefreshingRelay.asDriver()
    }
}

extension Array where Element == Friend {
    func deduplicated() -> [Element] {
        var uniqueFriends: [String: Friend] = [:]
        
        for friend in self {
            if let existedFriend = uniqueFriends[friend.fId] {
                if friend.updateDate > existedFriend.updateDate {
                    uniqueFriends[friend.fId] = friend
                }
            } else {
                uniqueFriends[friend.fId] = friend
            }
        }
        
        return Array(uniqueFriends.values)
    }
    
    func filterInvitingFriends() -> [Element] {
        return filter { $0.status == .sendInviting }
    }
    
    func filterInListFriends() -> [Element] {
        return filter { $0.status != .sendInviting }
    }
}
