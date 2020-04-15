//
//  DashboardScreenBuilder.swift
//  Redux+VM
//
//  Created by Joy on 07/04/20.
//  Copyright © 2020 joy. All rights reserved.
//

import Foundation
import UIKit

struct DashboardScreenBuilder {
    func main(dependencies: Dependencies) -> UIViewController {
        let viewModel = DashboardScreenViewModel(dependencies: dependencies)
        let dashboard = DashboardViewController(viewModel: viewModel)
        viewModel.view = dashboard
        return dashboard
    }
}
