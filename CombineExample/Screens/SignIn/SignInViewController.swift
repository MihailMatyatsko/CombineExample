//
//  ViewController.swift
//  CombineExample
//
//  Created by Matyatsko Mihail on 21.07.2022.
//

import UIKit
import Combine

final class SignInViewController: UIViewController {
    
    @IBOutlet private weak var loginInTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
    @IBOutlet private weak var userGreetingsLabel: UILabel!
    @IBOutlet private weak var passswordInfoLabel: UILabel!
    @IBOutlet private weak var signInButton: UIButton!
    @IBOutlet private weak var successInfoLabel: UILabel!
    @IBOutlet private weak var activityView: ActivitySpinnerView!
    
    private var cancelable: Set<AnyCancellable> = []

    var viewModel: ISignInViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = SignInViewModel()
        setupUI()
        setupTextFields()
        setupObservers()
    }
    
    //MARK: - Private
    private func setupUI() {
        [userGreetingsLabel, passswordInfoLabel, successInfoLabel].forEach { label in
            label?.isHidden = true
        }
        
        signInButton.layer.cornerRadius = 6
        signInButton.isEnabled = false
        passswordInfoLabel.isHidden = true
        
        activityView.setupView()
        activityView.isHidden = true
    }
    
    private func setupTextFields() {
        passwordTextField.delegate = self
        loginInTextField.delegate = self
    }
    
    private func setupObservers() {
        viewModel.isCredentialsValidPublisher
            .receive(on: DispatchQueue.main)
            .assign(to: \.isEnabled, on: signInButton)
            .store(in: &cancelable)
        signInButton.publisher(for: \.isEnabled)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] isEnabled in
                self?.signInButton.backgroundColor = isEnabled ? UIColor.green : UIColor.lightGray
            }
            .store(in: &cancelable)
        viewModel.errorWhileLoggigInPublisher
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] error in
                if let error = error {
                    self?.passswordInfoLabel.isHidden = false
                    self?.passswordInfoLabel.textColor = UIColor.red
                    self?.passswordInfoLabel.text = error
                } else {
                    self?.passswordInfoLabel.isHidden = true
                }
            })
            .store(in: &cancelable)
        
        viewModel.isLoggedInPublisher
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] isLoggedIn in
                self?.successInfoLabel.isHidden = !isLoggedIn
                self?.activityView.hideIndicator()
                self?.activityView.isHidden = true
            })
            .store(in: &cancelable)
        
        viewModel.userLoginPubliser
            .receive(on: DispatchQueue.main)
            .sink { [weak self] login in
                if let login = login {
                    self?.userGreetingsLabel.isHidden = false
                    self?.userGreetingsLabel.text = "Hi, \(login)!"
                }  else {
                    self?.userGreetingsLabel.isHidden = true
                    self?.userGreetingsLabel.text = ""
                }
             }
            .store(in: &cancelable)
    }
    
    //MARK: - Actions
    @IBAction private func textInTextFieldsChanged(_ sender: UITextField) {
        viewModel.validateCredentials(login: loginInTextField.text, password: passwordTextField.text)
    }
    
    @IBAction private func signInButtonPressed(_ sender: UIButton) {
        activityView.isHidden = false
        activityView.showIndicator()
        viewModel.tryLogIn(logIn: loginInTextField.text!, password: passwordTextField.text!)
    }

}

extension SignInViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}

