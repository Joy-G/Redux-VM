//
//  ReceiptScreenBuilder.swift
//  Redux+VM
//
//  Created by Joy on 23/04/20.
//  Copyright © 2020 joy. All rights reserved.
//

import Foundation
import UIKit

struct ReceiptScreenBuilder {
    func main(dependencies: Dependencies) -> UIViewController {
        let controller = ReceiptsScreenViewController.instantiate(fromAppStoryboard: .Main)
        return controller
    }
}
