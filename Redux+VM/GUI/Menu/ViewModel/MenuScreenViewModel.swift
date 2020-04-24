//
//  MenuScreenViewModel.swift
//  Redux+VM
//
//  Created by Joy on 24/04/20.
//  Copyright © 2020 joy. All rights reserved.
//

import Foundation

class MenuScreenViewModel {
    private let store: Store
    private let dataStore: DataStore
    private var currentState: MenuScreenState?
    
    init(dependencies: Dependencies) {
        store = dependencies.store
        dataStore = dependencies.dataStore
        store.subscribe(observer: self)
    }
    // MARK: - View functions
    /// Connection view is loaded.
    func viewDidLoad() {
        update(store: store)
    }
    
    func menuItems() -> [String] {
        return ["Dashboard", "Receipts"]
    }
    
    func cellTapped(indexPath: IndexPath) {
        let menuItem: MenuItem = (indexPath.row == 0) ? .dashboard : .receipts
        store.dispatch(action: MenuScreenAction.menuTapped(item: menuItem))
        var screen: Screen = .dashboardScreen
        switch menuItem {
        case .dashboard:
            screen = .dashboardScreen
        case .receipts:
            screen = .receipts
        case .activity:
            screen = .receipts
        case .payments:
            screen = .receipts
        }
        store.dispatch(action: NavigationScreenAction.switchScreen(screen: screen, presentation: .replace))
    }
}

extension MenuScreenViewModel: StoreObserver {
    func update(store: Store) {
        guard currentState != store.state.gui.menuScreen else {
            return
        }
        currentState = store.state.gui.menuScreen
    }
}
