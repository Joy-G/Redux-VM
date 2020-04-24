//
//  NewsDetailsViewModel.swift
//  Redux+VM
//
//  Created by Joy on 24/04/20.
//  Copyright © 2020 joy. All rights reserved.
//

import Foundation

class NewsDetailsViewModel {
    private let store: Store
    private let dataStore: DataStore
    
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
    
    func goBack() {
        store.dispatch(action: NavigationScreenAction.popScreen(toScreen: nil))
        print(store.state)
    }
    
   
}

extension NewsDetailsViewModel: StoreObserver {
    func update(store: Store) {
    }
}
