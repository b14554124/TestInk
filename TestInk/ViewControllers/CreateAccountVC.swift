//
//  CreateAccountVC.swift
//  TestInk
//
//  Created by C4Q on 3/14/18.
//  Copyright © 2018 C4Q. All rights reserved.
//
import UIKit
import FirebaseAuth

class CreateAccountVC: UIViewController {
    
    
    var createAccountView = CreateAccountView()
    
    var activeTextField: UITextField = UITextField()
    
    private var authUserService = AuthUserService.manager
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        configViews()
        configureNavigation()
        
        //textfield delegates
        createAccountView.usernameTextField.delegate = self
        createAccountView.emailTextField.delegate = self
        createAccountView.passwordTextField.delegate = self
        //when signup button pressed
        createAccountView.creteButton.addTarget(self, action: #selector(create), for: .touchUpInside)
        
    }
    private func configureNavigation(){
        
        navigationItem.title = "Create an account"
        navigationItem.leftItemsSupplementBackButton = false
        let backButton = UIBarButtonItem()
        backButton.title = "Back"
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
    }
    
    
    private func configViews() {
        view.addSubview(createAccountView)
        
        createAccountView.snp.makeConstraints { (make) in
            make.edges.equalTo(view.safeAreaLayoutGuide.snp.edges)
        }
    }
    //
    //
    @objc private func back(){
        navigationController?.dismiss(animated: true, completion: nil)
    }
    
    
    @objc private func create() {
        guard let userName = createAccountView.usernameTextField.text else {  self.alertForErrors(with: "Please enter a valid user name."); return }
        guard !userName.isEmpty else { self.alertForErrors(with: "Please enter a valid user name."); return }
        guard let email = createAccountView.emailTextField.text else { self.alertForErrors(with: "Please enter an email."); return }
        guard !email.isEmpty else { self.alertForErrors(with: "Please enter a valid email."); return }
        guard let password = createAccountView.passwordTextField.text else { self.alertForErrors(with: "Password is nil "); return }
        guard !password.isEmpty else { self.alertForErrors(with: "Password field is empty"); return }
        
        authUserService.createAccount(withEmail: email, password: password, displayName: userName)
        
    }
    
    public func alertForErrors(with message: String) {
        let ac = UIAlertController(title: "Problem Logging In", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        ac.addAction(okAction)
        self.present(ac, animated: true, completion: nil)
    }
}

extension CreateAccountVC: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.activeTextField = textField
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

