

import UIKit

struct LoginData {
    let username: String
    let password: String
}

class LoginScreenViewModel {
    private let store: Store
    private var currentState: LoginScreenState?
    private var loginData: LoginData?
    weak var view: LoginView?
    
    init(dependencies: Dependencies) {
        store = dependencies.store
        store.subscribe(observer: self)
    }
    // MARK: - View functions
    /// Connection view is loaded.
    func viewDidLoad() {
        update(store: store)
    }
    
    func gotoForgotPassword() {
        store.dispatch(action: NavigationScreenAction.switchScreen(screen: .forgotpasswordScreen, presentation: .replace))
    }
    
    func gotoLogin() {
        store.dispatch(action: LoginScreenAction.submit)
    }
    
    func gotoSignUp() {
        store.dispatch(action: NavigationScreenAction.switchScreen(screen: .signupScreen, presentation: .push(animate: true)))
    }
    
    func gotoDashboard() {
        store.dispatch(action: NavigationScreenAction.switchScreen(screen: .dashboardScreen, presentation: .replace))
    }
    
    func reset() {
        store.dispatch(action: LoginScreenAction.reset)
    }
    
    func validate(username: String, password: String) {
        if username.count > 4, password.count > 4 { // Any other validation logic
            loginData = LoginData(username: username, password: password)
            store.dispatch(action: LoginScreenAction.localValidation(isSuccess: true))
        } else {
            store.dispatch(action: LoginScreenAction.localValidation(isSuccess: false))
        }
    }
    
    func checkLogin(withState currentState: LoginScreenState) {
        if currentState.loginState == .validateUserCredentials {
            print(loginData as Any)
            DispatchQueue.global().asyncAfter(deadline: DispatchTime.now() + DispatchTimeInterval.seconds(5), execute: { [weak self] in
                self?.store.dispatch(action: LoginScreenAction.didReceivedUserInfo)
            })
            // Call an API
            // if success
            //store.dispatch(action: LoginScreenAction.didReceivedUserInfo)
            // else failure
            //store.dispatch(action: LoginScreenAction.didFailedToReceiveUserInfo)
        }
    }
    
}

extension LoginScreenViewModel: StoreObserver {
    func update(store: Store) {
        guard currentState != store.state.gui.loginScreen else {
            return
        }
        currentState = store.state.gui.loginScreen
        checkLogin(withState: store.state.gui.loginScreen)
        view?.update(state: store.state.gui.loginScreen)
    }
    
}
