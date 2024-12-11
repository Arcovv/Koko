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

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testIsFriendsEmpty() throws {
        let appDependency = AppDependency(apiClient: .apiClientLocal, apiClientStrategy: .emptyFriends)
        AppDependency.current = appDependency

        let viewModel = FriendsViewModel(appDependency: appDependency)
        let disposeBag = DisposeBag()

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
}
