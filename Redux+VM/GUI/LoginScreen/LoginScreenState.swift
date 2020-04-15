//
//  LoginScreenState.swift
//  Redux+VM
//
//  Created by Joy on 06/04/20.
//  Copyright © 2020 joy. All rights reserved.
//

import Foundation

struct LoginScreenState: Equatable {
    let loginState: LoginState
}

enum LoginState: Equatable {
    case empty
    case localValidationSuccess
    case localValidationFailed
    case validateUserCredentials
    case success
    case failed
}

extension LoginScreenState {
    static var newState: LoginScreenState {
        return LoginScreenState(loginState: .empty)
    }
}
