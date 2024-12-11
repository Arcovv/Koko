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
}
