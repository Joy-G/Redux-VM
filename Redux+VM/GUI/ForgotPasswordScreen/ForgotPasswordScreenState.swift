//
//  SignupScreenState.swift
//  Redux+VM
//
//  Created by Joy on 08/04/20.
//  Copyright © 2020 joy. All rights reserved.
//

import Foundation

struct ForgotPasswordScreenState: Equatable {
    let forgotPasswordState: ForgotPasswordState
}

enum ForgotPasswordState: Equatable {
    case empty
    case isReadyForServiceCall(isReady: Bool)
    case initiatingServiceCall
    case success
    case failed
}

extension ForgotPasswordScreenState {
    static var newState: ForgotPasswordScreenState {
        return ForgotPasswordScreenState(forgotPasswordState: .empty)
    }
}
