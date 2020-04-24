//
//  MenuViewController.swift
//  Redux+VM
//
//  Created by Joy on 24/04/20.
//  Copyright © 2020 joy. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {
    
    // outlets
    @IBOutlet weak var tableView: UITableView!

    private var viewModel: MenuScreenViewModel?
    // MARK: - Dependencies
    func inject(viewModel: MenuScreenViewModel) {
        self.viewModel = viewModel
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel?.viewDidLoad()
    }

}

extension MenuViewController: UITableViewDelegate, UITableViewDataSource {
    // MARK: UITableViewDelegate&DataSource methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.menuItems().count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuCell", for: indexPath)
        cell.textLabel?.text = viewModel?.menuItems()[(indexPath as NSIndexPath).row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let hamburguerViewController = self.findHamburguerViewController() {
            hamburguerViewController.hideMenuViewControllerWithCompletion({ [weak self] in
                self?.viewModel?.cellTapped(indexPath: indexPath)
            })
        }
    }
}
