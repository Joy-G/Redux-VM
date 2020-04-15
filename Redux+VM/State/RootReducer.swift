//
//  RootReducer.swift
//  Redux+VM
//
//  Created by Joy on 06/04/20.
//  Copyright © 2020 joy. All rights reserved.
//

import Foundation

struct RootReducer {
    static func reduce(state: RootState?, action: Action) -> RootState {
        return RootState(gui: GuiReducer.reduce(state: state?.gui, action: action)
        )
    }
}
