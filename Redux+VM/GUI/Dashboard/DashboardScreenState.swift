//
//  DashboardScreenState.swift
//  Redux+VM
//
//  Created by Joy on 07/04/20.
//  Copyright © 2020 joy. All rights reserved.
//

import Foundation

struct DashboardScreenState: Equatable {
    let dashboardState: DashboardState
}

enum DashboardState: Equatable {
    case empty
    case signout
}

extension DashboardScreenState {
    static var newState: DashboardScreenState {
        return DashboardScreenState(dashboardState: .empty)
    }
}
