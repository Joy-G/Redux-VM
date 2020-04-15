//
//  SignupScreenBuilder.swift
//  Redux+VM
//
//  Created by Joy on 06/04/20.
//  Copyright © 2020 joy. All rights reserved.
//

import UIKit

struct SignupScreenBuilder {
    func main(dependencies: Dependencies) -> UIViewController {
        let viewModel = SignupScreenViewModel(dependencies: dependencies)
        let signupScreen = SignupScreenViewController(viewModel: viewModel)
        viewModel.view = signupScreen
        return signupScreen
    }
}
