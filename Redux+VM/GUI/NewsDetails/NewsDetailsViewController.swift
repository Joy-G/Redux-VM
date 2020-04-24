//
//  NewsDetailsViewController.swift
//  Redux+VM
//
//  Created by Joy on 24/04/20.
//  Copyright © 2020 joy. All rights reserved.
//

import UIKit

class NewsDetailsViewController: UIViewController {

    private var viewModel: NewsDetailsViewModel?
    // MARK: - Dependencies
    func inject(viewModel: NewsDetailsViewModel) {
        self.viewModel = viewModel
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel?.viewDidLoad()
    }
    
    @IBAction func backButtonTapped(_ sender: Any) {
        viewModel?.goBack()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
