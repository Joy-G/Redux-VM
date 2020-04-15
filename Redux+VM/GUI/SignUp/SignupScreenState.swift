//
//  SignupScreenState.swift
//  Redux+VM
//
//  Created by Joy on 08/04/20.
//  Copyright © 2020 joy. All rights reserved.
//

import Foundation

struct SignupScreenState: Equatable {
    let signupState: SignupState
}

enum SignupState: Equatable {
    case empty
    case localValidationSuccess
    case localValidationFailed
    case register
    case success
    case failed
}

extension SignupScreenState {
    static var newState: SignupScreenState {
        return SignupScreenState(signupState: .empty)
    }
}
