//
//  SignupTests.swift
//  Redux+VMTests
//
//  Created by Joy on 21/04/20.
//  Copyright © 2020 joy. All rights reserved.
//

import XCTest
@testable import Redux_VM

class SignupTests: XCTestCase {
    let timeOut: TimeInterval = 10
    let app = AppBuilder()
    var viewModel: SignupScreenViewModel?

    override func setUp() {
        viewModel = SignupScreenViewModel(dependencies: app.dependencies)
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
    
    func test_registerUser() {
        let exp = expectation(description: "registerUser")
        viewModel?.registerUser()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            XCTAssertTrue(self.app.dependencies.store.state.gui.signupScreen.signupState == .register)
            exp.fulfill()
        }
        waitForExpectations(timeout: timeOut, handler: nil)
    }
    
    func test_reset() {
        let exp = expectation(description: "reset")
        viewModel?.reset()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            XCTAssertTrue(self.app.dependencies.store.state.gui.signupScreen.signupState == .empty)
            exp.fulfill()
        }
        waitForExpectations(timeout: timeOut, handler: nil)
    }
    
    func test_validate_failure() {
        let exp = expectation(description: "validate")
        viewModel?.validate(username: "aaa", password: "asadasd", confirmPassword: "asdasdas")
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            XCTAssertTrue(self.app.dependencies.store.state.gui.signupScreen.signupState == .localValidationFailed)
            exp.fulfill()
        }
        waitForExpectations(timeout: timeOut, handler: nil)
    }
    
    func test_validate_success() {
        let exp = expectation(description: "validate")
        viewModel?.validate(username: "Jayanta", password: "ganguly", confirmPassword: "ganguly")
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            XCTAssertTrue(self.app.dependencies.store.state.gui.signupScreen.signupState == .localValidationSuccess)
            exp.fulfill()
        }
        waitForExpectations(timeout: timeOut, handler: nil)
    }
    
    func test_callAPIRegister() {
        let exp = expectation(description: "validate")
        viewModel?.callAPIRegister(withState: .init(signupState: .register))
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            XCTAssertTrue(self.app.dependencies.store.state.gui.signupScreen.signupState == .success)
            exp.fulfill()
        }
        waitForExpectations(timeout: timeOut, handler: nil)
    }

    
}
