//
//  RegistrationViewController.swift
//  BPCinema
//
//  Created by Anita Stashevskaya on 22.03.2024.
//

import UIKit

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
    private let messageLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 10)
        label.numberOfLines = 0
        return label
    }()
    
    private let minPasswordLength = 6
    private lazy var regex = "^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.*[@$!#%*?&]).{\(minPasswordLength),}$"
    
    private let registerButton = CustomButton(title: "Register") // TODO: disable this while password is incorrect
    private let goToLoginButton = GoToButton(title: "Back to sign in")
    
    private let presenter: RegisterPresentable
    
    init(presenter: RegisterPresentable) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.tintColor = .white
        view.backgroundColor = .systemBackground
        view.addSubview(headerImage)
        view.addSubview(nameTextField)
        view.addSubview(surnameTextField)
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(messageLabel)
        view.addSubview(password2TextField)
        view.addSubview(registerButton)
        view.addSubview(goToLoginButton)
        
        addConstraints()
        registerButton.addTarget(self, action: #selector(performList(_:)), for: .touchUpInside)
        goToLoginButton.addTarget(self, action: #selector(backToLogin(_:)), for: .touchUpInside)
        passwordTextField.delegate = self
        headerImage.isUserInteractionEnabled = true
        let gesture = UITapGestureRecognizer(target: self, action: #selector(didTapChangeProfilePicture))
        headerImage.addGestureRecognizer(gesture)
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
            passwordTextField.heightAnchor.constraint(equalToConstant: 40),
            
            messageLabel.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 10),
            messageLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            messageLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            password2TextField.topAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: 20),
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
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                      let window = windowScene.windows.first else {
                    return
                }
        let router = LoginRouter()
        let loginView = LoginFactory.assembledScreen(router)
        window.rootViewController = loginView
        window.makeKeyAndVisible()
    }
    
    @objc func performList(_ sender: UIButton) {
        let registerResult = presenter.checkIsRegistrationFormCorrect(name: nameTextField.text,
                                                 surname: surnameTextField.text,
                                                 email: emailTextField.text,
                                                 password1: passwordTextField.text,
                                                 password2: password2TextField.text)
        showCreateAccount(title: (registerResult.0), message: (registerResult.1))
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

extension RegisterViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = (textField.text as NSString?)?.replacingCharacters(in: range, with: string) else { return true }
        
        if textField == passwordTextField || textField == password2TextField {
            let isValid = validatePassword(text)
            messageLabel.textColor = isValid ? .systemGreen : .systemRed
            messageLabel.text = isValid ? "Password is correct" : "Password should contain at least \(minPasswordLength) characters, one uppercase letter, one lowercase letter, one digit, and one special character."
            return true
        }
        return true
    }
    
    private func validatePassword(_ password: String) -> Bool {
        let passwordRegex = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[@$!#%*?&])[A-Za-z\\d@$!#%*?&]{\(minPasswordLength),}$"
        let passwordPredicate = NSPredicate(format: "SELF MATCHES %@", passwordRegex)
        return passwordPredicate.evaluate(with: password)
    }
}

extension String {
    func matches(_ regex: String) -> Bool {
        return self.range(of: regex, options: .regularExpression, range: nil, locale: nil) != nil
    }
}
