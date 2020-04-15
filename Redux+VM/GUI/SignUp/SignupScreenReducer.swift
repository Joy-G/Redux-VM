//
//  SignupScreenReducer.swift
//  Redux+VM
//
//  Created by Joy on 08/04/20.
//  Copyright © 2020 joy. All rights reserved.
//

import Foundation
import os.log

struct SignupScreenReducer {
    static func reduce(state: SignupScreenState?, action: Action) -> SignupScreenState {
        let state = state ?? SignupScreenState.newState
        guard let action = action as? SignupScreenAction else { return state }
        os_log(.info, log: .login, "SignupScreenReducer, recieved action %{public}@",
               String(reflecting: action))
        var signupState = state.signupState
        
        switch action {
        case .submit:
            signupState = .register
        case .reset:
            return SignupScreenState.newState
        case .didReceivedUserInfo:
            signupState = .success
        case .didFailedToReceiveUserInfo:
            signupState = .failed
        case .localValidation(let isSuccess):
            signupState = isSuccess ? .localValidationSuccess : .localValidationFailed
        }
        return SignupScreenState(signupState: signupState)
    }
}
