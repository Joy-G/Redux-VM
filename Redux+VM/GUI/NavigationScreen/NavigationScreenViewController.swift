//
//  NavigationScreenViewController.swift
//  Redux+VM
//
//  Created by Joy on 06/04/20.
//  Copyright © 2020 joy. All rights reserved.
//

import UIKit

class NavigationScreenViewController: DLHamburguerViewController, StoreObserver {

    private let dependencies: Dependencies
    private var currentSubviewController: UIViewController?
    private var currentSubScreen: Screen?
    private var arrNavigationScreens = [Screen]()


    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    init(dependencies: Dependencies) {
        self.dependencies = dependencies
        super.init(nibName: String(describing: NavigationScreenViewController.self), bundle: Bundle.main)
        self.contentViewController = UIViewController()
        self.menuViewController = MenuScreenBuilder().main(dependencies: dependencies)
        
    }
    override func viewDidLoad() {
        self.dependencies.store.subscribe(observer: self)
        self.update(store: self.dependencies.store)
    }
    func update(store: Store) {
        let navigationState = store.state.gui.navigationScreen
        if navigationState.isPop {
           handlePop(store: store)
        } else if currentSubScreen == nil || currentSubScreen != navigationState.currentScreen {
            handlePresentation(state: navigationState)
        }
    }

    private func handlePresentation(state: NavigationScreenState) {
        let navigationPresentation: NavigationPresentation = state.presentation
                
        switch navigationPresentation {
        case .push(let animate):
           let controller = getController(forNavigationState: state)
           self.navigationController?.pushViewController(controller, animated: animate, completion: { [weak self] in
                self?.arrNavigationScreens.append(state.currentScreen)
                self?.currentSubScreen = state.currentScreen
            })
        case .present(let animate):
            self.navigationController?.present(getController(forNavigationState: state), animated: animate)
        case .replace:
            replace(navigationState: state)
        }
    }
    
    private func replace(navigationState: NavigationScreenState) {
        if currentSubScreen == nil || currentSubScreen != navigationState.currentScreen {
            self.navigationController?.popToRootViewController(animated: false)
            if let currentSubviewController = currentSubviewController {
                currentSubviewController.willMove(toParent: nil)
                currentSubviewController.view.removeFromSuperview()
                currentSubviewController.removeFromParent()
            }
            let newViewController = getController(forNavigationState: navigationState)
            self.contentViewController = newViewController
            arrNavigationScreens.removeAll()
            arrNavigationScreens.append(navigationState.currentScreen)
            currentSubviewController = newViewController
            currentSubScreen = navigationState.currentScreen
        }
    }
    
    private func handlePop(store: Store) {
        if self.arrNavigationScreens.count > 1 {
            if let viewControllers = self.navigationController?.viewControllers {
               let index = (viewControllers.count - 1 - 1) > 0 ? (viewControllers.count - 1 - 1) : 0
               let controller = viewControllers[index]
               let currentScreen = self.arrNavigationScreens[index]
               self.arrNavigationScreens.removeLast()
               self.navigationController?.popToViewController(controller, animated: true, completion: { [weak self] in
                    self?.currentSubScreen = currentScreen
                    store.dispatch(action: NavigationScreenAction.switchScreen(screen: currentScreen, presentation: .replace))
               })
           }
       }
    }
    
    private func getController(forNavigationState navigationState: NavigationScreenState) -> UIViewController {
        let newViewController = {
        switch navigationState.currentScreen {
        case .loginScreen:
            return LoginScreenBuilder().main(dependencies: self.dependencies)
        case .signupScreen:
            return SignupScreenBuilder().main(dependencies: self.dependencies)
        case .forgotpasswordScreen:
            return ForgotPasswordScreenBuilder().main(dependencies: self.dependencies)
        case .dashboardScreen:
            return DashboardScreenBuilder().main(dependencies: self.dependencies)
        case .receipts:
            return ReceiptScreenBuilder().main(dependencies: dependencies)
        case .newsDetails:
            return NewsDetailsBuilder().main(dependencies: dependencies)
        }

        }() as UIViewController
        
        return newViewController
    }
}

extension NavigationScreenViewController {
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    open override var childForStatusBarHidden: UIViewController? {
        return currentSubviewController
    }
}

extension UINavigationController {
    open override var childForStatusBarStyle: UIViewController? {
        return self.topViewController
    }
}
