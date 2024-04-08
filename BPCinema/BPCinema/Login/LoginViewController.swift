//
//  LoginViewController.swift
//  BPCinema
//
//  Created by Anita Stashevskaya on 22.03.2024.
//

import UIKit
import FirebaseAuth

final class LoginViewController: UIViewController {
    private let presenter: LoginPresentable
    
    private var headerView: UIView = {
        let view = UIView()
        view.backgroundColor = .custom
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var emailTextField = CustomTextField(placeholderText: "Email")
    private var passwordTextField = CustomTextField(placeholderText: "Password", isPassword: true)
    private let loginButton = CustomButton(title: "Login")
    private let goToRegisterButton = GoToButton(title: "Create an account")
    
    init(presenter: LoginPresentable) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        loginButton.addTarget(self, action: #selector(login(_:)), for: .touchUpInside)
        goToRegisterButton.addTarget(self, action: #selector(performRegister(_:)), for: .touchUpInside)
        emailTextField.text = "anita.stashevskayaa@mail.ru"
        passwordTextField.text = "qazwsx"
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
    }
    @objc func hideKeyboard() {
        view.endEditing(true)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)      
        emailTextField.becomeFirstResponder()
//        presenter.isAlreadyLogin()
    }
    
    private func setupView() {
        view.backgroundColor = .systemBackground
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(loginButton)
        view.addSubview(goToRegisterButton)
        
        NSLayoutConstraint.activate([
            emailTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            emailTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            emailTextField.topAnchor.constraint(equalTo: view.centerYAnchor, constant: -100),
            
            passwordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            passwordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 30),
            
            loginButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            loginButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            loginButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 30),
            
            goToRegisterButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            goToRegisterButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 30)
        ])
    }
    
    @objc func login(_ sender: UIButton) {
        
        guard let email = emailTextField.text, !email.isEmpty,
              let password = passwordTextField.text, !password.isEmpty else {
            print("Missing fields")
            return
        }
        
        if let email = emailTextField.text, let pass = passwordTextField.text
        {
            presenter.loginAll(email: email, password: pass)
        }
    }
    
    @objc func performRegister(_ sender: UIButton) {
        var router = RegisterRouter()
        RegistrationFactory.assembledScreen(withRouter: router)
    }
}
