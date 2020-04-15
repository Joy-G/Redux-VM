//
//  ForgotPasswordViewController.swift
//  Redux+VM
//
//  Created by Joy on 13/04/20.
//  Copyright © 2020 joy. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

protocol ForgotPasswordView: AnyObject {
    func update(state: ForgotPasswordScreenState)
}
class ForgotPasswordViewController: UIViewController, NVActivityIndicatorViewable {
    
    @IBOutlet weak var txtUsername: UITextField?
    @IBOutlet weak var btnSubmit: UIButton?

    private let viewModel: ForgotPasswordScreenViewModel
    // MARK: - Dependencies
    init(viewModel: ForgotPasswordScreenViewModel) {
        self.viewModel = viewModel
        super.init(nibName: String(describing: ForgotPasswordViewController.self), bundle: Bundle.main)
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
    
    @IBAction private func submitTapped(_ sender: Any) {
        viewModel.submitTapped()
    }
    
    @IBAction private func backButtonTapped(_ sender: Any) {
        viewModel.gotoLogin()
    }
    
    private func setupUI() {
        txtUsername?.delegate = self
    }
    
    private func resetUI() {
        txtUsername?.text = ""
        btnSubmit?.isEnabled = false
    }


    private func updateUI(state: ForgotPasswordScreenState) {
        switch state.forgotPasswordState {
        case .empty:
            resetUI()
        case .isReadyForServiceCall(let isReady):
            btnSubmit?.isEnabled = isReady ? true : false
        case .initiatingServiceCall:
            startAnimating(CGSize(width: 40, height: 40), type: .orbit, color: .orange)
        case .success:
            stopAnimating()
            showAlert(isSuccess: true)
        case .failed:
            stopAnimating()
            showAlert(isSuccess: false)
        }
    }

    private func showAlert(isSuccess: Bool) {
        let alertController = UIAlertController(title: "Redux+VM", message: isSuccess ? "Password successfully sent" : "Unable to reset password", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Dismiss", style: .cancel) { [weak self] (action) in
            _ = isSuccess ? self?.viewModel.gotoLogin() : self?.viewModel.reset()
        }
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true)
    }
}

extension ForgotPasswordViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        if let text = textField.text, let textRange = Range(range, in: text) {
           let updatedText = text.replacingCharacters(in: textRange, with: string)
            viewModel.validate(username: updatedText)
        }
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}

extension ForgotPasswordViewController: ForgotPasswordView {
    func update(state: ForgotPasswordScreenState) {
        updateUI(state: state)
    }
}
