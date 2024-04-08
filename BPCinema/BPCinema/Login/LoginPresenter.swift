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
}

final class LoginPresenter: LoginPresentable {
    var loginInteractor: LoginInteractable?
    private let router: LoginRouting
    
    init(loginInteractor: LoginInteractable? = nil, router: LoginRouting) {
        self.loginInteractor = loginInteractor
        self.router = router
    }
    
    func loginAll(email: String, password: String) {
        loginInteractor?.login(email: email, password: password)
    }
    
    func isAlreadyLogin() {
        loginInteractor?.isAlreadyLogin()
    }
}
