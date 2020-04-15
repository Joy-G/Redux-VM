//
//  SignupScreenBuilder.swift
//  Redux+VM
//
//  Created by Joy on 06/04/20.
//  Copyright © 2020 joy. All rights reserved.
//

import UIKit

struct ForgotPasswordScreenBuilder {
    func main(dependencies: Dependencies) -> UIViewController {
        let viewModel = ForgotPasswordScreenViewModel(dependencies: dependencies)
        let signupScreen = ForgotPasswordViewController(viewModel: viewModel)
        viewModel.view = signupScreen
        return signupScreen
    }
}
