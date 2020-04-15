//
//  NavigationScreenViewController.swift
//  Redux+VM
//
//  Created by Joy on 06/04/20.
//  Copyright © 2020 joy. All rights reserved.
//

import UIKit

class NavigationScreenViewController: UIViewController, StoreObserver {

    private let dependencies: Dependencies
    private var currentSubviewController: UIViewController?
    private var currentSubScreen: Screen?

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    init(dependencies: Dependencies) {
        self.dependencies = dependencies
        super.init(nibName: String(describing: NavigationScreenViewController.self), bundle: Bundle.main)
    }
    override func viewDidLoad() {
        self.dependencies.store.subscribe(observer: self)
        self.update(store: self.dependencies.store)
    }
    func update(store: Store) {
        let navigationState = store.state.gui.navigationScreen
        if currentSubScreen == nil || currentSubScreen != navigationState.currentScreen {
            handlePresentation(state: navigationState)
            currentSubScreen = navigationState.currentScreen
        }
    }

    private func handlePresentation(state: NavigationScreenState) {
        let navigationPresentation: NavigationPresentation = state.presentation
                
        switch navigationPresentation {
        case .push(let animate):
            self.navigationController?.pushViewController(getController(forNavigationState: state), animated: animate)
        case .present(let animate):
            self.navigationController?.present(getController(forNavigationState: state), animated: animate)
        case .pop(let animate):
            if let viewControllers = self.navigationController?.viewControllers {
                let index = (viewControllers.count - 1 - 1) > 0 ? (viewControllers.count - 1 - 1) : 0
                self.navigationController?.popToViewController(viewControllers[index], animated: animate)
            }
        case .replace:
            replace(navigationState: state)
        }
    }
    
    private func replace(navigationState: NavigationScreenState) {
        if currentSubScreen == nil || currentSubScreen != navigationState.currentScreen {
            
            if let currentSubviewController = currentSubviewController {
                currentSubviewController.willMove(toParent: nil)
                currentSubviewController.view.removeFromSuperview()
                currentSubviewController.removeFromParent()
            }
            let newViewController = getController(forNavigationState: navigationState)
            addChild(newViewController)
            view.addSubview(newViewController.view)
            newViewController.view.translatesAutoresizingMaskIntoConstraints = false
            newViewController.view.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
            newViewController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
            newViewController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
            newViewController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true

            newViewController.didMove(toParent: self)

            currentSubviewController = newViewController
            
            currentSubScreen = navigationState.currentScreen
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
