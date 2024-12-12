//
//  FriendsViewModelTests.swift
//  KokoTests
//
//  Created by Arco Hsieh on 2024/12/12.
//

import XCTest
@testable import Koko
import RxSwift
import RxCocoa
import RxBlocking

final class FriendsViewModelTests: XCTestCase {
    var viewModel: FriendsViewModelType!
    var disposeBag: DisposeBag!

    override func setUpWithError() throws {
        disposeBag = DisposeBag()
    }

    override func tearDownWithError() throws {
        viewModel = nil
        disposeBag = nil
    }

    func testIsFriendsEmpty() throws {
        let appDependency = AppDependency(apiClient: .apiClientLocal, apiClientStrategy: .emptyFriends)
        AppDependency.current = appDependency
        viewModel = FriendsViewModel(appDependency: appDependency)

        let expect = expectation(description: #function)
        var result: Bool!
        
        viewModel.outputs.isFriendsEmpty
            .emit(onNext: { isFriendsEmpty in
                result = isFriendsEmpty
                expect.fulfill()
            })
            .disposed(by: disposeBag)
        
        viewModel.inputs.viewDidLoad.accept(())
        
        waitForExpectations(timeout: 1.0) { error in
            guard error == nil else {
                XCTFail(error!.localizedDescription)
                return
            }
            
            XCTAssertTrue(result)
        }
    }
    
    func testIsFriendsNotEmpty() throws {
        let appDependency = AppDependency(apiClient: .apiClientLocal, apiClientStrategy: .mixedFriends)
        AppDependency.current = appDependency
        viewModel = FriendsViewModel(appDependency: appDependency)

        let expect = expectation(description: #function)
        var result: Bool!
        
        viewModel.outputs.isFriendsEmpty
            .emit(onNext: { isFriendsEmpty in
                result = isFriendsEmpty
                expect.fulfill()
            })
            .disposed(by: disposeBag)
        
        viewModel.inputs.viewDidLoad.accept(())
        
        waitForExpectations(timeout: 1.0) { error in
            guard error == nil else {
                XCTFail(error!.localizedDescription)
                return
            }
            
            XCTAssertFalse(result)
        }
    }
    
    func testFrindInvitingCountIsOneInMixedFriendsStrategy() throws {
        let appDependency = AppDependency(apiClient: .apiClientLocal, apiClientStrategy: .mixedFriends)
        AppDependency.current = appDependency
        viewModel = FriendsViewModel(appDependency: appDependency)

        var expect = expectation(description: "frind inviting count should be 1")
        var result = 0
        
        viewModel.outputs.friendInvitings
            .emit(onNext: { friendInvitings in
                result = friendInvitings.count
                expect.fulfill()
            })
            .disposed(by: disposeBag)
        
        viewModel.inputs.viewDidLoad.accept(())
        
        waitForExpectations(timeout: 1.0) { error in
            guard error == nil else {
                XCTFail(error!.localizedDescription)
                return
            }
            
            XCTAssertEqual(result, 1)
        }
    }
    
    func testFriendsInListCountIsFiveInMixedFriendsStrategy() throws {
        let appDependency = AppDependency(apiClient: .apiClientLocal, apiClientStrategy: .mixedFriends)
        AppDependency.current = appDependency
        viewModel = FriendsViewModel(appDependency: appDependency)

        var expect = expectation(description: "frinds in list count should be 5")
        var result = 0
        
        viewModel.outputs.friendsInList
            .emit(onNext: { friendsInList in
                result = friendsInList.count
                expect.fulfill()
            })
            .disposed(by: disposeBag)
        
        viewModel.inputs.viewDidLoad.accept(())
        
        waitForExpectations(timeout: 1.0) { error in
            guard error == nil else {
                XCTFail(error!.localizedDescription)
                return
            }
            
            XCTAssertEqual(result, 5)
        }
    }
    
    func testSearchLinResultsCountIsOneInMixedFriendsStrategy() {
        let appDependency = AppDependency(apiClient: .apiClientLocal, apiClientStrategy: .mixedFriends)
        AppDependency.current = appDependency
        viewModel = FriendsViewModel(appDependency: appDependency)

        var expect = expectation(description: "Only one friend name 林")
        var result = 0
        
        viewModel.outputs.friendsInList
            .skip(1) // Ignore the orignal friends result
            .emit(onNext: { friendsInList in
                result = friendsInList.count
                expect.fulfill()
            })
            .disposed(by: disposeBag)
        
        viewModel.inputs.viewDidLoad.accept(())
        viewModel.inputs.searchingText.accept("林")
        
        waitForExpectations(timeout: 1.0) { error in
            guard error == nil else {
                XCTFail(error!.localizedDescription)
                return
            }
            
            XCTAssertEqual(result, 1)
        }
    }
    
    func testSearchWhiteResultsCountIsZeroInMixedFriendsStrategy() {
        let appDependency = AppDependency(apiClient: .apiClientLocal, apiClientStrategy: .mixedFriends)
        AppDependency.current = appDependency
        viewModel = FriendsViewModel(appDependency: appDependency)

        var expect = expectation(description: "No one friend name 白")
        var result = 0
        
        viewModel.outputs.friendsInList
            .skip(1) // Ignore the orignal friends result
            .emit(onNext: { friendsInList in
                result = friendsInList.count
                expect.fulfill()
            })
            .disposed(by: disposeBag)
        
        viewModel.inputs.viewDidLoad.accept(())
        viewModel.inputs.searchingText.accept("白")
        
        waitForExpectations(timeout: 1.0) { error in
            guard error == nil else {
                XCTFail(error!.localizedDescription)
                return
            }
            
            XCTAssertEqual(result, 0)
        }
    }
    
    func testPullToRefreshShouldGetTheSameResultsCountInMixedFriendsStrategy() {
        let appDependency = AppDependency(apiClient: .apiClientLocal, apiClientStrategy: .mixedFriends)
        AppDependency.current = appDependency
        viewModel = FriendsViewModel(appDependency: appDependency)

        var expect = expectation(description: #function)
        var result = false
        
        viewModel.outputs.friendsInList
            .skip(1) // Ignore the orignal friends result
            .emit(onNext: { friendsInList in
                result = friendsInList.count == 5 // 目前有5筆資料，所以刷新之後也一樣是5筆
                expect.fulfill()
            })
            .disposed(by: disposeBag)
        
        viewModel.inputs.viewDidLoad.accept(())
        viewModel.inputs.pullToRefresh.accept(())
        
        waitForExpectations(timeout: 2.0) { error in
            guard error == nil else {
                XCTFail(error!.localizedDescription)
                return
            }
            
            XCTAssertEqual(result, true)
        }
    }
    
    func testInvitedFriendsCountIsTwoInFriendsWithInviting() {
        let appDependency = AppDependency(apiClient: .apiClientLocal, apiClientStrategy: .friendsWithInviting)
        AppDependency.current = appDependency
        viewModel = FriendsViewModel(appDependency: appDependency)

        var expect = expectation(description: #function)
        var result = false
        
        viewModel.outputs.invitedFriends
            .emit(onNext: { invitedFriends in
                result = invitedFriends.count == 2
                expect.fulfill()
            })
            .disposed(by: disposeBag)
        
        viewModel.inputs.viewDidLoad.accept(())
        
        waitForExpectations(timeout: 1.0) { error in
            guard error == nil else {
                XCTFail(error!.localizedDescription)
                return
            }
            
            XCTAssertEqual(result, true)
        }
    }
}
