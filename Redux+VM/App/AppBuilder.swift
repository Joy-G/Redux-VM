//
//  AppBuilder.swift
//  Redux+VM
//
//  Created by Joy on 07/04/20.
//  Copyright © 2020 joy. All rights reserved.
//


import Foundation
import UIKit

class AppBuilder {

    let dependencies: Dependencies!
    private let view: NavigationScreenViewController

    init() {
        let store = Store()
        //        let communication = Communication(store: store, ompApi: ompApi)
        let formatter = Formatter()
        dependencies = DependencyContainer(store: store,
                                           formatter: formatter)
        view = NavigationScreenViewController(dependencies: dependencies)
    }

    func main() -> UIViewController {
        let navigation = UINavigationController(rootViewController: view)
        navigation.navigationBar.isTranslucent = true
        navigation.navigationBar.isHidden = true
        if #available(iOS 11.0, *) {
            navigation.navigationBar.prefersLargeTitles = true
        }
        return navigation
    }
}

struct DependencyContainer: Dependencies {
    let store: Store
    //let communication: Communication
    var formatter: Formatter
}

protocol StoreSupplier {
    var store: Store { get }
}

//protocol CommunicationSupplier {
//    var communication: Communication { get }
//}

protocol FormatterSupplier {
    var formatter: Formatter { get }
}

/// Typealias including all dependencies.
typealias Dependencies = StoreSupplier & FormatterSupplier

