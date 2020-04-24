//
//  SignupScreenState.swift
//  Redux+VM
//
//  Created by Joy on 08/04/20.
//  Copyright © 2020 joy. All rights reserved.
//

import Foundation

struct MenuScreenState: Equatable {
    let menuState: MenuState
}

enum MenuState: Equatable {
    case selectedMenu(menuItem: MenuItem)
}

enum MenuItem: Equatable {
    case dashboard
    case receipts
    case activity
    case payments
}

extension MenuScreenState {
    static var newState: MenuScreenState {
        return MenuScreenState(menuState: .selectedMenu(menuItem: .dashboard))
    }
}
