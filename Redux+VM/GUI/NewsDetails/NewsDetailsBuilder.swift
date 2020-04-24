//
//  NewsDetailsBuilder.swift
//  Redux+VM
//
//  Created by Joy on 24/04/20.
//  Copyright © 2020 joy. All rights reserved.
//

import Foundation
import UIKit

struct NewsDetailsBuilder {
    func main(dependencies: Dependencies) -> UIViewController {
        let viewModel = NewsDetailsViewModel(dependencies: dependencies)
        let controller = NewsDetailsViewController.instantiate(fromAppStoryboard: .Main)
        controller.inject(viewModel: viewModel)
        return controller
    }
}
