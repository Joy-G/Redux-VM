//
//  ForgotPasswordScreenViewModel.swift
//  Redux+VM
//
//  Created by Joy on 13/04/20.
//  Copyright © 2020 joy. All rights reserved.
//

import Foundation
struct ForgotPasswordDataModel {
    let username: String
}
class ForgotPasswordScreenViewModel {
    private let store: Store
    private let dataStore: DataStore
    private var currentState: ForgotPasswordScreenState?
    weak var view: ForgotPasswordView?
    
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
    
    func gotoLogin() {
        store.dispatch(action: LoginScreenAction.reset)
        store.dispatch(action: NavigationScreenAction.switchScreen(screen: .loginScreen, presentation: .replace))
    }
    
    func submitTapped() {
        store.dispatch(action: ForgotPasswordScreenAction.submit)
    }
    
    func reset() {
        store.dispatch(action: ForgotPasswordScreenAction.reset)
    }
    
    func validate(username: String) {
        dataStore.forgotPasswordData = ForgotPasswordDataModel(username: username)
        // if local validation is passed
        store.dispatch(action: ForgotPasswordScreenAction.localValidation(isSuccess: true)) // else false
    }
    
    func callAPIForgotPassword(withState currentState: ForgotPasswordScreenState) {
        if currentState.forgotPasswordState == .initiatingServiceCall {
            DispatchQueue.global().asyncAfter(deadline: DispatchTime.now() + DispatchTimeInterval.seconds(2), execute: { [weak self] in
                self?.store.dispatch(action: ForgotPasswordScreenAction.success)
            })
        }
    }
    
   
    
}

extension ForgotPasswordScreenViewModel: StoreObserver {
    func update(store: Store) {
        guard currentState != store.state.gui.forgotpasswordScreen else {
            return
        }
        currentState = store.state.gui.forgotpasswordScreen
        callAPIForgotPassword(withState: store.state.gui.forgotpasswordScreen)
        view?.update(state: store.state.gui.forgotpasswordScreen)
    }
}
