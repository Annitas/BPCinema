//
//  RegisterPresenter.swift
//  BPCinema
//
//  Created by Anita Stashevskaya on 27.03.2024.
//

import UIKit
import Foundation

protocol RegisterPresentable {
    var registerInteractor : RegisterInteractable? {get set}
    
    func registerAll(email : String, password : String)
    func checkIsRegistrationFormCorrect(name: String?, surname: String?, email: String?, password1: String?, password2: String?) -> (String, String)
}

final class RegisterPresenter: RegisterPresentable {
    var registerInteractor: RegisterInteractable?
    private let router: RegisterRouting
    
    init(registerInteractor: RegisterInteractable? = nil, router: RegisterRouting) {
        self.registerInteractor = registerInteractor
        self.router = router
    }
    
    func registerAll(email: String, password: String) {
        registerInteractor?.register(email: email, password: password)
    }
    
    func checkIsRegistrationFormCorrect(name: String?, surname: String?, email: String?, password1: String?, password2: String?) -> (String, String) {
        print("Func called")
        guard let name = name, !name.isEmpty,
              let surname = surname, !surname.isEmpty,
              let email = email, !email.isEmpty,
              let password1 = password1, !password1.isEmpty,
              let password2 = password2, !password2.isEmpty else {
            return ("Error", "Missing fields")
        }
        if password1 != password2 {
            return ("Error", "Passwords aren't equal")
        }
        registerAll(email: email, password: password1)
        return ("Account created", "Account created, log in")
    }
}
