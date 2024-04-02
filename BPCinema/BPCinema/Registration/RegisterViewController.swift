//
//  RegistrationViewController.swift
//  BPCinema
//
//  Created by Anita Stashevskaya on 22.03.2024.
//

import UIKit
import Firebase

class RegisterViewController: UIViewController {
    
    private var headerImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "profilepic")
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.borderWidth = 2.0
        imageView.layer.borderColor = UIColor.systemBlue.cgColor
        imageView.layer.masksToBounds = false
        return imageView
    }()
    
    private var nameTextField = CustomTextField(placeholderText: "First name")
    private var surnameTextField = CustomTextField(placeholderText: "Last name")
    private var emailTextField = CustomTextField(placeholderText: "Email")
    private var passwordTextField = CustomTextField(placeholderText: "Enter password", isPassword: true)
    private var password2TextField = CustomTextField(placeholderText: "Repeat password", isPassword: true)
    private let registerButton = CustomButton(title: "Register")
    private let goToLoginButton = GoToButton(title: "Back to sign in")
    
    var register: RegisterPresentable?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //        self.hideKeyboardWhenTappedAround()
        self.navigationController?.navigationBar.tintColor = .white
        view.backgroundColor = .systemBackground
        view.addSubview(headerImage)
        view.addSubview(nameTextField)
        view.addSubview(surnameTextField)
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(password2TextField)
        view.addSubview(registerButton)
        view.addSubview(goToLoginButton)
        addConstraints()
        registerButton.addTarget(self, action: #selector(performList(_:)), for: .touchUpInside)
        goToLoginButton.addTarget(self, action: #selector(backToLogin(_:)), for: .touchUpInside)
        
        headerImage.isUserInteractionEnabled = true
        let gesture = UITapGestureRecognizer(target: self, action: #selector(didTapChangeProfilePicture))
        headerImage.addGestureRecognizer(gesture)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
    }
    @objc func hideKeyboard() {
        view.endEditing(true)
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        headerImage.layer.cornerRadius = headerImage.frame.size.width / 2
        headerImage.clipsToBounds = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        nameTextField.becomeFirstResponder()
    }
    
    @objc private func didTapChangeProfilePicture() {
        presentPhotoActionShit()
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            headerImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            headerImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            headerImage.heightAnchor.constraint(equalToConstant: 90),
            headerImage.widthAnchor.constraint(equalToConstant: 90),
            
            nameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            nameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            nameTextField.topAnchor.constraint(equalTo: headerImage.bottomAnchor, constant: 20),
            
            surnameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            surnameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            surnameTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 20),
            
            emailTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            emailTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            emailTextField.topAnchor.constraint(equalTo: surnameTextField.bottomAnchor, constant: 20),
            
            passwordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            passwordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 20),
            
            password2TextField.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 20),
            password2TextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            password2TextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            
            registerButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            registerButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            registerButton.topAnchor.constraint(equalTo: password2TextField.bottomAnchor, constant: 20),
            
            goToLoginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            goToLoginButton.topAnchor.constraint(equalTo: registerButton.bottomAnchor, constant: 20),
        ])
    }
    
    @objc func backToLogin(_ sender: UIButton) {
        let loginVC = LoginViewController()
        loginVC.modalPresentationStyle = .fullScreen
        present(loginVC, animated: true)
    }
    
    @objc func performList(_ sender: UIButton) {
        guard let name = nameTextField.text, !name.isEmpty,
              let surname = surnameTextField.text, !surname.isEmpty,
              let email = emailTextField.text, !email.isEmpty,
              let password = passwordTextField.text, !password.isEmpty, let password2 = password2TextField.text, !password2.isEmpty else {
            print("Missing fields")
            return
        }
        if password != password2 {
            showCreateAccount(title: "Error", message: "Passwords aren't equal")
            return
        }
        if let te = emailTextField.text, let tp = passwordTextField.text {
            register?.registerAll(email: te, password: tp)
        }
        showCreateAccount(title: "Account created", message: "Account created, log in")
    }
    
    func showCreateAccount(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ouf", style: .cancel, handler: { _ in
            
        }))
        present(alert, animated: true)
    }
}

extension RegisterViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func presentPhotoActionShit() {
        let actionSheet = UIAlertController(title: "Profile picture", message: "Set profile picture", preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        actionSheet.addAction(UIAlertAction(title: "Choose from gallery", style: .default, handler: {[weak self] _ in
            self?.presentPhotoLibrary()
        }))
        present(actionSheet, animated: true)
    }
    
    func presentPhotoLibrary() {
        let vc = UIImagePickerController()
        vc.sourceType = .photoLibrary
        vc.delegate = self
        vc.allowsEditing = true
        present(vc, animated: true)
    }
}
