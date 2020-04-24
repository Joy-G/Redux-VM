//
//  NavigationScreenReducer.swift
//  Redux+VM
//
//  Created by Joy on 06/04/20.
//  Copyright © 2020 joy. All rights reserved.
//

import Foundation
struct NavigationScreenReducer {
    static func reduce(state: NavigationScreenState?, action: Action) -> NavigationScreenState {
        var state = state ?? NavigationScreenState.emptyState
        guard let action = action as? NavigationScreenAction else { return state }
        switch action {
        case .switchScreen(let screen, let presentation):
            state =  NavigationScreenState(currentScreen: screen, presentation: presentation)
        case .popScreen(let screen):
            state = NavigationScreenState(currentScreen: state.currentScreen, presentation: .replace)
            state.isPop = true
            state.popToScreen = screen
        }
        return state
    }
}
