//
//  LoginScreenReducer.swift
//  Redux+VM
//
//  Created by Joy on 07/04/20.
//  Copyright © 2020 joy. All rights reserved.
//

import Foundation
import os.log

struct LoginScreenReducer {
    static func reduce(state: LoginScreenState?, action: Action) -> LoginScreenState {
        let state = state ?? LoginScreenState.newState
        guard let action = action as? LoginScreenAction else { return state }
        os_log(.info, log: .login, "LoginScreenReducer, recieved action %{public}@",
               String(reflecting: action))
        var loginState = state.loginState
        switch action {
        case .submit:
            loginState = .validateUserCredentials
        case .reset:
            return LoginScreenState.newState
        case .didReceivedUserInfo:
            loginState = .success
        case .didFailedToReceiveUserInfo:
            loginState = .failed
        case .localValidation(let isSuccess):
            loginState = isSuccess ? .localValidationSuccess : .localValidationFailed
        }
        return LoginScreenState(loginState: loginState)
    }
}
