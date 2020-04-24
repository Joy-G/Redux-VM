//
//  DashboardViewController.swift
//  Redux+VM
//
//  Created by Joy on 07/04/20.
//  Copyright © 2020 joy. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

protocol DashboardView: AnyObject {
    func update(state: DashboardScreenState)
}

class DashboardViewController: UIViewController, NVActivityIndicatorViewable {
    
    @IBOutlet weak var tableView: UITableView?
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
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func willMove(toParent parent: UIViewController?) {
       
    }
    // MARK: - Interactions
    
    @IBAction private func signOut(_ sender: Any) {
        viewModel.gotoLogin()
    }
    
    @IBAction private func gotoDetails(_ sender: Any) {
        self.findHamburguerViewController()?.showMenuViewController()
    }
    
    private func updateUI(state: DashboardScreenState) {
        switch state.dashboardState {
        case .empty:
            tableView?.reloadData()
            viewModel.fetchNews()
        case .signout:
            break
        case .fetchingDataInProgress:
            startAnimating(CGSize(width: 40, height: 40), type: .orbit, color: .orange)
        case .fetched:
            stopAnimating()
            tableView?.reloadData()
        }
    }

}

extension DashboardViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows
       }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       var cell : UITableViewCell!
       cell = tableView.dequeueReusableCell(withIdentifier: "cellIdentifier")
       if cell == nil {
           cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cellIdentifier")
       }
        let data = viewModel.getCellData(forIndexPath: indexPath)
        cell.textLabel?.text = data?.title
        cell.detailTextLabel?.text = data?.author
       return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.cellTapped(at: indexPath.row)
    }

}

extension DashboardViewController: DashboardView {
    func update(state: DashboardScreenState) {
        updateUI(state: state)
    }
}

