//
//  NavigationScreenState.swift
//  Redux+VM
//
//  Created by Joy on 06/04/20.
//  Copyright © 2020 joy. All rights reserved.
//

import Foundation

struct NavigationScreenState {
    let currentScreen: Screen
    let presentation: NavigationPresentation
    var isPop: Bool = false
    var popToScreen: Screen? = nil
    static var emptyState: NavigationScreenState {
        return NavigationScreenState(currentScreen: .loginScreen, presentation: .replace)
    }
}
