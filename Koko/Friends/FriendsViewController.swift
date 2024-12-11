//
//  FriendsViewController.swift
//  Koko
//
//  Created by Arco Hsieh on 2024/12/10.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa
import RxDataSources
import RxSwiftExt

final class FriendsViewController: UIViewController {
    private let stackView = UIStackView()
    private let headerFeatureView = HeaderFeatureView()
    private let searchBarView = SearchBarView()
    private let refreshControl = UIRefreshControl()
    private var friendsCollectionView: UICollectionView!
    private var dataSource: RxCollectionViewSectionedAnimatedDataSource<FriendsSection>!
    private let friendEmptyView = FriendEmptyView()
    
    let disposeBag = DisposeBag()
    private let viewModel: FriendsViewModelType
    private let onViewDidLoad = PublishRelay<Void>()
    private let onPullToRefrsh = PublishRelay<Void>()
    
    // MARK: - Initial
    
    deinit { print("FriendsViewController deinit") }
    
    init(
        viewModel: FriendsViewModelType = FriendsViewModel(appDependency: .current)
    ) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupBinding()
        
        // Send signal
        onViewDidLoad.accept(())
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        view.addSubview(stackView)

        stackView.axis = .vertical
        stackView.spacing = 0
//        stackView.backgroundColor = .yellow
        stackView.addArrangedSubview(headerFeatureView)
        
        // Setup `friendsCollectionView`
        do {
            let flowLayout = UICollectionViewFlowLayout()
            flowLayout.scrollDirection = .vertical
            flowLayout.minimumLineSpacing = 0
            flowLayout.minimumInteritemSpacing = 0
            
            friendsCollectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
            //            friendsCollectionView.backgroundColor = .green
            friendsCollectionView.delegate = self
            friendsCollectionView.register(
                FriendsCollectionViewCell.self,
                forCellWithReuseIdentifier: FriendsCollectionViewCell.identifier
            )
        }
        
        // Setup `refreshControl`
        do {
            friendsCollectionView.refreshControl = refreshControl
        }
        
        // Setup dataSource
        dataSource = RxCollectionViewSectionedAnimatedDataSource<FriendsSection>(
            configureCell: { ds, collectionView, indexPath, friend in
                let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: FriendsCollectionViewCell.identifier,
                    for: indexPath) as! FriendsCollectionViewCell
                cell.setFriend(friend)
                return cell
            }
        )
        
        // layout

        stackView.snp.makeConstraints { make in
            make.top.leading.bottom.trailing.equalToSuperview()
//            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    private func setupBinding() {
        // Output
        
        viewModel.outputs.friendInvitings
            .emit(with: self, onNext: { (_self, invitings) in
                _self.headerFeatureView.setFriendInvitings(invitings)
            })
            .disposed(by: disposeBag)
        
        viewModel.outputs.isFriendsEmpty
            .debug()
            .emit(with: self, onNext: { (_self, isFriendsEmpty) in
                if isFriendsEmpty {
                    _self.showEmptyView()
                } else {
                    _self.showFriendsList()
                }
            })
            .disposed(by: disposeBag)
        
        viewModel.outputs.friendsInList
            .map { [FriendsSection.init(items: $0)] }
            .asObservable()
            .bind(to: friendsCollectionView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
        
        viewModel.outputs.isRefreshing
            .asObservable()
            .bind(to: refreshControl.rx.isRefreshing)
            .disposed(by: disposeBag)
        
        Observable
            .of(
                searchBarView.searchBar.rx.cancelButtonClicked.asObservable(),
                searchBarView.searchBar.rx.searchButtonClicked.asObservable(),
                searchBarView.searchBar.rx.text.unwrap().ignoreWhen { !$0.isEmpty }.mapTo(())
            )
            .merge()
            .observe(on: MainScheduler.instance)
            .subscribe(with: self, onNext: { (_self, _) in
                _self.searchBarView.searchBar.resignFirstResponder()
            })
            .disposed(by: disposeBag)
        
        // Input
        
        onViewDidLoad.asObservable()
            .bind(to: viewModel.inputs.viewDidLoad)
            .disposed(by: disposeBag)
        
        onPullToRefrsh.asObservable()
            .bind(to: viewModel.inputs.pullToRefresh)
            .disposed(by: disposeBag)
        
        refreshControl.rx.controlEvent(.valueChanged)
            .asSignal()
            .emit(to: onPullToRefrsh)
            .disposed(by: disposeBag)
        
        searchBarView.searchBar.rx.text
            .asObservable()
//            .debug("searchBarView.searchBar.rx.text")
            .bind(to: viewModel.inputs.searchingText)
            .disposed(by: disposeBag)
    }
    
    private func showEmptyView() {
        searchBarView.removeFromSuperview()
        friendsCollectionView.removeFromSuperview()
        
        stackView.setCustomSpacing(30, after: headerFeatureView)
        stackView.addArrangedSubview(friendEmptyView)
    }
    
    private func showFriendsList() {
        friendEmptyView.removeFromSuperview()
        
        stackView.setCustomSpacing(0, after: headerFeatureView)
        stackView.addArrangedSubview(searchBarView)
        stackView.addArrangedSubview(friendsCollectionView)
        
        searchBarView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(30)
        }
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension FriendsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        return CGSize(
            width: collectionView.bounds.width - 40,
            height: 60
        )
    }
}
