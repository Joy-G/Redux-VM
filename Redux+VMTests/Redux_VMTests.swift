//
//  Redux_VMTests.swift
//  Redux+VMTests
//
//  Created by Joy on 06/04/20.
//  Copyright © 2020 joy. All rights reserved.
//

import XCTest
@testable import Redux_VM

class Redux_VMTests: XCTestCase {
    let timeOut: TimeInterval = 10
    let app = AppBuilder()
    var viewModel: LoginScreenViewModel?

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        viewModel = LoginScreenViewModel(dependencies: app.dependencies)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func test_validate_Success() {
        let exp = expectation(description: "localValidationSuccess")
        viewModel?.validate(username: "aaaaa", password: "21323")
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            XCTAssertTrue(self.app.dependencies.store.state.gui
                .loginScreen.loginState == .localValidationSuccess)
            exp.fulfill()
        }
        waitForExpectations(timeout: timeOut, handler: nil)
    }

    func test_validate_Failure() {
        let exp = expectation(description: "localValidationFailed")
        viewModel?.validate(username: "aaa", password: "21323")
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            XCTAssertTrue(self.app.dependencies.store.state.gui
                .loginScreen.loginState == .localValidationFailed)
            exp.fulfill()
        }
        waitForExpectations(timeout: timeOut, handler: nil)
    }

    func test_gotoLogin() {
        let exp = expectation(description: "validateUserCredentials")
        viewModel?.gotoLogin()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            XCTAssertTrue(self.app.dependencies.store.state.gui
                .loginScreen.loginState == .validateUserCredentials)
            exp.fulfill()
        }
        waitForExpectations(timeout: timeOut, handler: nil)
    }
    
    func test_checkLogin() {
        let exp = expectation(description: "success")
        viewModel?.checkLogin(withState: .init(loginState: .validateUserCredentials))
        DispatchQueue.main.asyncAfter(deadline: .now() + 7) {
            XCTAssertTrue(self.app.dependencies.store.state.gui
                .loginScreen.loginState == .success)
            exp.fulfill()
        }
        waitForExpectations(timeout: timeOut, handler: nil)
    }
    
    func test_reset() {
        let exp = expectation(description: "empty")
        viewModel?.reset()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            XCTAssertTrue(self.app.dependencies.store.state.gui
                .loginScreen.loginState == .empty)
        exp.fulfill()
        }
        waitForExpectations(timeout: timeOut, handler: nil)
    }
    
    // MARK: Navigation Test Cases
    func test_gotoForgotPassword() {
        let exp = expectation(description: "forgotpasswordScreen")
        viewModel?.gotoForgotPassword()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            XCTAssertTrue(self.app.dependencies.store.state.gui.navigationScreen.currentScreen == .forgotpasswordScreen)
        exp.fulfill()
        }
        waitForExpectations(timeout: timeOut, handler: nil)
    }
    
    func test_gotoSignUp() {
        let exp = expectation(description: "signupScreen")
        viewModel?.gotoSignUp()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            XCTAssertTrue(self.app.dependencies.store.state.gui.navigationScreen.currentScreen == .signupScreen)
        exp.fulfill()
        }
        waitForExpectations(timeout: timeOut, handler: nil)
    }
    
    func test_gotoDashboard() {
        let exp = expectation(description: "dashboardScreen")
        viewModel?.gotoDashboard()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            XCTAssertTrue(self.app.dependencies.store.state.gui.navigationScreen.currentScreen == .dashboardScreen)
        exp.fulfill()
        }
        waitForExpectations(timeout: timeOut, handler: nil)
    }
    
}

