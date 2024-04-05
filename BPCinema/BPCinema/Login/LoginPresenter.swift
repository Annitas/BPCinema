//
//  AuthPresenter.swift
//  BPCinema
//
//  Created by Anita Stashevskaya on 27.03.2024.
//

import Foundation

protocol LoginPresentable {
    var loginInteractor : LoginInteractable? {get set}
    func loginAll(email : String, password : String )
    func isAlreadyLogin()
    
    var input: LoginPresenterInput { get }
    var output: LoginPresenterOutput { get }
}


final class LoginPresenter: LoginPresentable {
    var loginInteractor: LoginInteractable?
    var input = LoginPresenterInput()
    var output = LoginPresenterOutput(viewModel: LoginViewModel(emailLabel: "Enter email", passwordLabel: "Enter pass"))
    var outputChanged: (() -> Void)?
    
    func loginAll(email: String, password: String) {
        loginInteractor?.login(email: email, password: password)
    }
    
    func isAlreadyLogin() {
        loginInteractor?.isAlreadyLogin()
    }
    
    private func dataUpdated() {
//        let result = loginInteractor.validate(p1: output.email, p2: output.password)
//        output.loginButtonEnabled = result
    }
}

struct LoginPresenterInput {
    var emailEntered: ((String) -> Void)?
    var passwordEntered: ((String) -> Void)?
}

struct LoginPresenterOutput {
    var viewModel: LoginViewModel
    var email: String = ""
    var password: String = ""
    var loginButtonEnabled: Bool = false
}
