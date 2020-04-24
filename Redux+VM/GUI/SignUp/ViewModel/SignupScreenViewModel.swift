//
//  SignupScreenViewModel.swift
//  Redux+VM
//
//  Created by Joy on 06/04/20.
//  Copyright © 2020 joy. All rights reserved.
//

import Foundation

struct SignUpDataModel {
    let username: String
    let password: String
    let confirmPassword: String
}

class SignupScreenViewModel {
    private let store: Store
    private let dataStore: DataStore
    private var currentState: SignupScreenState?
    weak var view: SignupView?
    private var signupData: SignUpDataModel?
    
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
    
    func registerUser() {
        store.dispatch(action: SignupScreenAction.submit)
    }
    
    func reset() {
        store.dispatch(action: SignupScreenAction.reset)
    }
    
    func validate(username: String, password: String, confirmPassword: String) {
        if username.count > 4, password.count > 4, confirmPassword.count > 4, password == confirmPassword { // Any other validation logic
            
            store.dispatch(action: SignupScreenAction.localValidation(isSuccess: true))
        } else {
            store.dispatch(action: SignupScreenAction.localValidation(isSuccess: false))
        }
    }
    
    func callAPIRegister(withState currentState: SignupScreenState) {
        if currentState.signupState == .register {
            DispatchQueue.global().asyncAfter(deadline: DispatchTime.now() + DispatchTimeInterval.seconds(2), execute: { [weak self] in
                self?.store.dispatch(action: SignupScreenAction.didReceivedUserInfo)
            })
        }
    }
    
}

extension SignupScreenViewModel: StoreObserver {
    func update(store: Store) {
        guard currentState != store.state.gui.signupScreen else {
            return
        }
        currentState = store.state.gui.signupScreen
        callAPIRegister(withState: store.state.gui.signupScreen)
        view?.update(state: store.state.gui.signupScreen)
    }
}
    
