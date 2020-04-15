//
//  DashboardViewController.swift
//  Redux+VM
//
//  Created by Joy on 07/04/20.
//  Copyright © 2020 joy. All rights reserved.
//

import UIKit

protocol DashboardView: AnyObject {
    func update(state: DashboardScreenState)
}

class DashboardViewController: UIViewController {
    
    private let viewModel: DashboardScreenViewModel
    // MARK: - Dependencies
    init(viewModel: DashboardScreenViewModel) {
        self.viewModel = viewModel
        super.init(nibName: String(describing: DashboardViewController.self), bundle: Bundle.main)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.viewDidLoad()
    }
    
    override func willMove(toParent parent: UIViewController?) {
       
    }
    // MARK: - Interactions
    @IBAction private func signOut(_ sender: Any) {
        viewModel.gotoLogin()
    }
    
    private func updateUI(state: DashboardScreenState) {
        
    }

}

extension DashboardViewController: DashboardView {
    func update(state: DashboardScreenState) {
        updateUI(state: state)
    }
}

