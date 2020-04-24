//
//  DashboardScreenReducer.swift
//  Redux+VM
//
//  Created by Joy on 07/04/20.
//  Copyright © 2020 joy. All rights reserved.
//

import Foundation
import os.log

struct DashboardScreenReducer {
    static func reduce(state: DashboardScreenState?, action: Action) -> DashboardScreenState {
        let state = state ?? DashboardScreenState.newState
        guard let action = action as? DashboardScreenAction else { return state }
        os_log(.info, log: .dashboard, "DashboardScreenReducer, recieved action %{public}@",
               String(reflecting: action))
        var currentState = state.dashboardState
        switch action {
        case .signout:
            currentState = .signout
        case .fetchingNews:
            currentState = .fetchingDataInProgress
        case .reload:
            currentState = .fetched
        }
        return DashboardScreenState(dashboardState: currentState)
    }
}
