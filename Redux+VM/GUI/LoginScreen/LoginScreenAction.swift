//
//  LoginAction.swift
//  Redux+VM
//
//  Created by Joy on 06/04/20.
//  Copyright © 2020 joy. All rights reserved.
//

import Foundation

enum LoginScreenAction: Action {
    case localValidation(isSuccess: Bool)
    case didReceivedUserInfo
    case didFailedToReceiveUserInfo
    case submit
    case reset
}
