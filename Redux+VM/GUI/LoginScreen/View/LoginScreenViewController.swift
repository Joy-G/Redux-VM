

import UIKit
import NVActivityIndicatorView

protocol LoginView: AnyObject {
    func update(state: LoginScreenState)
}

class LoginScreenViewController: UIViewController, NVActivityIndicatorViewable {
    @IBOutlet weak var txtUsername: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var btnSubmit: UIButton!
    private var activeTextField: UITextField?
    
    private let viewModel: LoginScreenViewModel
    // MARK: - Dependencies
    init(viewModel: LoginScreenViewModel) {
        self.viewModel = viewModel
        super.init(nibName: String(describing: LoginScreenViewController.self), bundle: Bundle.main)
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
        self.view.resignFirstResponder()
    }
    // MARK: - Interactions
    @IBAction private func forgotPasswordTapped(_ sender: Any) {
        viewModel.gotoForgotPassword()
    }
    
    @IBAction private func signUpTapped(_ sender: Any) {
        viewModel.gotoSignUp()
    }
    
    @IBAction private func loginTapped(_ sender: Any) {
        activeTextField?.resignFirstResponder()
        viewModel.gotoLogin()
    }
    
    private func setupUI() {
        txtUsername.delegate = self
        txtPassword.delegate = self
    }
    
    private func resetUI() {
        txtUsername.text = ""
        txtPassword.text = ""
        btnSubmit.isEnabled = false
    }
    
    private func updateUI(state: LoginScreenState) {
        switch state.loginState {
        case .empty:
            resetUI()
        case .validateUserCredentials:
            startAnimating(CGSize(width: 40, height: 40), type: .orbit, color: .orange)
        case .success:
            stopAnimating()
            viewModel.gotoDashboard()
        case .failed:
            stopAnimating()
            showAlert()
        case .localValidationSuccess:
            btnSubmit.isEnabled = true
        case .localValidationFailed:
            btnSubmit.isEnabled = false
        }
    }
        
    private func showAlert() {
        let alertController = UIAlertController(title: "Error", message: "Please check your credentials", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Dismiss", style: .cancel) { [weak self] (action) in
            self?.viewModel.reset()
        }
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true)
    }

}

extension LoginScreenViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        activeTextField = textField
        if let text = textField.text, let textRange = Range(range, in: text) {
           let updatedText = text.replacingCharacters(in: textRange, with: string)
            viewModel.validate(username: (textField == txtUsername) ? updatedText : txtUsername.text!,
                               password: (textField == txtPassword) ? updatedText : txtPassword.text!)
        }
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        activeTextField = nil
        textField.resignFirstResponder()
        return true
    }
    
}

extension LoginScreenViewController: LoginView {
    func update(state: LoginScreenState) {
        updateUI(state: state)
    }
}


