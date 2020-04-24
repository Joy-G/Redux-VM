//
//  ReceiptsScreenViewController.swift
//  Redux+VM
//
//  Created by Joy on 23/04/20.
//  Copyright © 2020 joy. All rights reserved.
//

import UIKit

class ReceiptsScreenViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func menuTapped(_ sender: Any) {
        findHamburguerViewController()?.showMenuViewController()
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
