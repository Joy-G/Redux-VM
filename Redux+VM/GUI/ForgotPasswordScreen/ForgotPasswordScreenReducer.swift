//
//  SignupScreenReducer.swift
//  Redux+VM
//
//  Created by Joy on 08/04/20.
//  Copyright © 2020 joy. All rights reserved.
//

import Foundation
import os.log

struct ForgotPasswordScreenReducer {
    static func reduce(state: ForgotPasswordScreenState?, action: Action) -> ForgotPasswordScreenState {
        let state = state ?? ForgotPasswordScreenState.newState
        guard let action = action as? ForgotPasswordScreenAction else { return state }
        os_log(.info, log: .login, "ForgotPasswordScreenReducer, recieved action %{public}@",
               String(reflecting: action))
        var forgotPasswordState = state.forgotPasswordState
        
        switch action {
        case .submit:
            forgotPasswordState = .initiatingServiceCall
        case .reset:
            return ForgotPasswordScreenState.newState
        case .localValidation(let isSuccess):
            forgotPasswordState = isSuccess ? .isReadyForServiceCall(isReady: true) : .isReadyForServiceCall(isReady: false)
        case .success:
            forgotPasswordState = .success
        case .failed:
            forgotPasswordState = .failed
        }
        return ForgotPasswordScreenState(forgotPasswordState: forgotPasswordState)
    }
}
