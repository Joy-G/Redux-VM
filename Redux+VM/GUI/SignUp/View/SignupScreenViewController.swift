//
//  SignupScreenViewController.swift
//  Redux+VM
//
//  Created by Joy on 09/04/20.
//  Copyright © 2020 joy. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

protocol SignupView: AnyObject {
    func update(state: SignupScreenState)
}

class SignupScreenViewController: UIViewController, NVActivityIndicatorViewable {
    @IBOutlet weak var txtUsername: UITextField?
    @IBOutlet weak var txtPassword: UITextField?
    @IBOutlet weak var txtConfirmPassword: UITextField?
    @IBOutlet weak var btnSubmit: UIButton?

    private let viewModel: SignupScreenViewModel
    // MARK: - Dependencies
    init(viewModel: SignupScreenViewModel) {
        self.viewModel = viewModel
        super.init(nibName: String(describing: SignupScreenViewController.self), bundle: Bundle.main)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        viewModel.viewDidLoad()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
//        if (self.isMovingFromParent || self.isBeingDismissed) {
//            viewModel.gotoLogin()
//        }
    }
    // MARK: - Interactions
    
    @IBAction private func submitTapped(_ sender: Any) {
        viewModel.registerUser()
    }
    
    @IBAction private func backButtonTapped(_ sender: Any) {
        viewModel.gotoLogin()
    }
    
    private func setupUI() {
        txtUsername?.delegate = self
        txtPassword?.delegate = self
        txtConfirmPassword?.delegate = self
        resetUI()
    }
    
    private func resetUI() {
        txtUsername?.text = ""
        txtPassword?.text = ""
        txtConfirmPassword?.text = ""
        btnSubmit?.isEnabled = false
    }
    
    private func updateUI(state: SignupScreenState) {
        print("\(state.signupState)")
        switch state.signupState {
        case .empty:
            resetUI()
        case .register:
            startAnimating(CGSize(width: 40, height: 40), type: .orbit, color: .orange)
        case .success:
            stopAnimating()
            showAlert(isSuccess: true)
        case .failed:
            stopAnimating()
            showAlert(isSuccess: false)
        case .localValidationSuccess:
            btnSubmit?.isEnabled = true
        case .localValidationFailed:
            btnSubmit?.isEnabled = false
        }
    }
        
    private func showAlert(isSuccess: Bool) {
        let alertController = UIAlertController(title: "Redux+VM", message: isSuccess ? "Registration Successful" : "Registration Unsuccessful", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Dismiss", style: .cancel) { [weak self] (action) in
            _ = isSuccess ? self?.viewModel.gotoLogin() : self?.viewModel.reset()
        }
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true)
    }

}

extension SignupScreenViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        if let text = textField.text, let textRange = Range(range, in: text) {
           let updatedText = text.replacingCharacters(in: textRange, with: string)
            viewModel.validate(username: (textField == txtUsername) ? updatedText : (txtUsername?.text!)!,
                               password: (textField == txtPassword) ? updatedText : (txtPassword?.text!)!,
                               confirmPassword: (textField == txtConfirmPassword) ? updatedText : (txtConfirmPassword?.text!)!)
        }
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}

extension SignupScreenViewController: SignupView {
    func update(state: SignupScreenState) {
        updateUI(state: state)
    }
}
