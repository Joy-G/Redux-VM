//
//  GuiReducer.swift
//  Redux+VM
//
//  Created by Joy on 06/04/20.
//  Copyright © 2020 joy. All rights reserved.
//

import Foundation
struct GuiReducer {
    static func reduce(state: GuiState?, action: Action) -> GuiState {
        return GuiState(navigationScreen: NavigationScreenReducer.reduce(state: state?.navigationScreen, action: action),
                        loginScreen: LoginScreenReducer.reduce(state: state?.loginScreen, action: action),
                        signupScreen: SignupScreenReducer.reduce(state: state?.signupScreen, action: action),
                        forgotpasswordScreen: ForgotPasswordScreenReducer.reduce(state: state?.forgotpasswordScreen, action: action),
                        menuScreen: MenuScreenReducer.reduce(state: state?.menuScreen, action: action),
                        dashboardScreen: DashboardScreenReducer.reduce(state: state?.dashboardScreen, action: action))
    }
}
