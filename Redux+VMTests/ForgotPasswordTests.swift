//
//  ForgotPasswordTests.swift
//  Redux+VMTests
//
//  Created by Joy on 21/04/20.
//  Copyright © 2020 joy. All rights reserved.
//

import XCTest
@testable import Redux_VM

class ForgotPasswordTests: XCTestCase {
    let timeOut: TimeInterval = 10
    let app = AppBuilder()
    var viewModel: ForgotPasswordScreenViewModel?

    override func setUp() {
        viewModel = ForgotPasswordScreenViewModel(dependencies: app.dependencies)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_gotoLogin() {
        let exp = expectation(description: "gotoLogin")
        viewModel?.gotoLogin()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            XCTAssertTrue(self.app.dependencies.store.state.gui.navigationScreen.currentScreen == .loginScreen)
            XCTAssertTrue(self.app.dependencies.store.state.gui.loginScreen.loginState == .empty)
            exp.fulfill()
        }
        waitForExpectations(timeout: timeOut, handler: nil)
    }
    
    func test_submitTapped() {
        let exp = expectation(description: "submitTapped")
        viewModel?.submitTapped()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            XCTAssertTrue(self.app.dependencies.store.state.gui.forgotpasswordScreen.forgotPasswordState == .initiatingServiceCall)
            exp.fulfill()
        }
        waitForExpectations(timeout: timeOut, handler: nil)
    }
    
    func test_reset() {
        let exp = expectation(description: "reset")
        viewModel?.reset()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            XCTAssertTrue(self.app.dependencies.store.state.gui.forgotpasswordScreen.forgotPasswordState == .empty)
            exp.fulfill()
        }
        waitForExpectations(timeout: timeOut, handler: nil)
    }
    
    func test_validate() {
        let exp = expectation(description: "validate")
        viewModel?.validate(username: "aaa")
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            XCTAssertTrue(self.app.dependencies.store.state.gui.forgotpasswordScreen.forgotPasswordState == .isReadyForServiceCall(isReady: true))
            exp.fulfill()
        }
        waitForExpectations(timeout: timeOut, handler: nil)
    }
    
    func test_callAPIForgotPassword() {
        let exp = expectation(description: "callAPIForgotPassword")
        viewModel?.callAPIForgotPassword(withState: .init(forgotPasswordState: .initiatingServiceCall))
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            XCTAssertTrue(self.app.dependencies.store.state.gui.forgotpasswordScreen.forgotPasswordState == .success)
            exp.fulfill()
        }
        waitForExpectations(timeout: timeOut, handler: nil)
    }
}
