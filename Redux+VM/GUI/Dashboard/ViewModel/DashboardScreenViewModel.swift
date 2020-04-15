//
//  DashboardScreenViewModel.swift
//  Redux+VM
//
//  Created by Joy on 07/04/20.
//  Copyright © 2020 joy. All rights reserved.
//

import Foundation

class DashboardScreenViewModel {
    private let store: Store
    private var currentState: DashboardScreenState?
    weak var view: DashboardView?
    init(dependencies: Dependencies) {
        store = dependencies.store
        store.subscribe(observer: self)
    }
    // MARK: - View functions
    /// Connection view is loaded.
    func viewDidLoad() {
        update(store: store)
    }
    
    func gotoLogin() {
        store.dispatch(action: LoginScreenAction.reset)
        store.dispatch(action: NavigationScreenAction.switchScreen(screen: .loginScreen, presentation: .replace))
    }
    
}

extension DashboardScreenViewModel: StoreObserver {
    func update(store: Store) {
    }
}
