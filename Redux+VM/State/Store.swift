//
//  Store.swift
//  Redux+VM
//
//  Created by Joy on 06/04/20.
//  Copyright © 2020 joy. All rights reserved.
//

import Foundation
import os.log

protocol StoreObserver: AnyObject {
    /// Notifies the observer that the state of the store has changed.
    ///
    /// - Parameter store: Store that was changed.
    func update(store: Store)
}

class Store {
    private struct WeakStoreObserverHolder {
        weak var observer: StoreObserver?
        let observerDescription: String
    }
    private var observers: [WeakStoreObserverHolder] = []

    private(set) var state: RootState

    init() {
        self.state = RootReducer.reduce(state: nil, action: ApplicationAction.start)
    }

    func dispatch(action: Action) {
        log(action: action)
        DispatchQueue.main.async {
            self.state = RootReducer.reduce(state: self.state, action: action)
            self.notify()
        }

    }

    /// Adds an observer to the store's dispatch table. The observer will be called on each state change.
    /// The Observer is hold weak and will be automatically removed on dellocation
    /// MUST BE CALLED ON MAIN THREAD
    /// - Parameter observer: Object subscribing as an observer.
    func subscribe(observer: StoreObserver) {
        assert(Thread.isMainThread, "subscribe must be called on main thread")
        let holder = WeakStoreObserverHolder(observer: observer, observerDescription: String(describing: observer.self))
        observers.append(holder)
        os_log(.debug, log: .store, "subscribe %@", holder.observerDescription)
    }

    /// Removes an observer to the store's dispatch table.
    /// MUST BE CALLED ON MAIN THREAD
    /// - Parameter observer: Object subscribing as an observer.
    func unsubscribe(observer: StoreObserver) {
        assert(Thread.isMainThread, "unsubscribe must be called on main thread")
        os_log(.debug, log: .store, "unsubscribe %@", String(describing: observer.self))
        observers = observers.filter {$0.observer !== observer}
    }

    private func notify() {
        /// Modification of the observers array and the calling to update have to be in two iterations.
        /// The update function in observers may call subscribe and this will modify the observers array.
        observers = observers.filter {
            if $0.observer == nil {
                os_log(.info, log: .store, "unsubscribe %@, has been deallocated", $0.observerDescription)
                return false
            }
            return true
        }
        observers.forEach {$0.observer?.update(store: self)}
    }

    private func log(action: Action) {
        os_log(.info, log: .store, "dispatching Action: %@", "\(action)")
    }
}
