//
//  SignupScreenAction.swift
//  Redux+VM
//
//  Created by Joy on 08/04/20.
//  Copyright © 2020 joy. All rights reserved.
//

import Foundation

enum SignupScreenAction: Action {
    case localValidation(isSuccess: Bool)
    case didReceivedUserInfo
    case didFailedToReceiveUserInfo
    case submit
    case reset
}
