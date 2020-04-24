//
//  NavigationScreenAction.swift
//  Redux+VM
//
//  Created by Joy on 06/04/20.
//  Copyright © 2020 joy. All rights reserved.
//

import Foundation
enum NavigationScreenAction: Action {
    case switchScreen(screen: Screen, presentation: NavigationPresentation)
    case popScreen(toScreen: Screen?)
}

enum NavigationPresentation {
    case push(animate: Bool)
    case present(animate: Bool)
    case replace
}
