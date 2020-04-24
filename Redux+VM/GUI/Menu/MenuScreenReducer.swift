//
//  SignupScreenReducer.swift
//  Redux+VM
//
//  Created by Joy on 08/04/20.
//  Copyright © 2020 joy. All rights reserved.
//

import Foundation
import os.log

struct MenuScreenReducer {
    static func reduce(state: MenuScreenState?, action: Action) -> MenuScreenState {
        let state = state ?? MenuScreenState.newState
        guard let action = action as? MenuScreenAction else { return state }
        os_log(.info, log: .login, "MenuScreenReducer, recieved action %{public}@",
               String(reflecting: action))
        var menuState = state.menuState
        
        switch action {
        case .menuTapped(let menuItem):
            menuState = .selectedMenu(menuItem: menuItem)
        }
        return MenuScreenState(menuState: menuState)
    }
}
