//
//  SignupScreenAction.swift
//  Redux+VM
//
//  Created by Joy on 08/04/20.
//  Copyright © 2020 joy. All rights reserved.
//

import Foundation

enum ForgotPasswordScreenAction: Action {
    case localValidation(isSuccess: Bool)
    case submit
    case reset
    case success
    case failed
}
