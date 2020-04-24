//
//  SignupScreenBuilder.swift
//  Redux+VM
//
//  Created by Joy on 06/04/20.
//  Copyright © 2020 joy. All rights reserved.
//

import UIKit

struct MenuScreenBuilder {
    func main(dependencies: Dependencies) -> UIViewController {
        let viewModel = MenuScreenViewModel(dependencies: dependencies)
        let menuController = MenuViewController.instantiate(fromAppStoryboard: .Main)
        menuController.inject(viewModel: viewModel)
        return menuController
    }
}
