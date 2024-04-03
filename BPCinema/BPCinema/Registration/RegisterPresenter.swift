//
//  RegisterPresenter.swift
//  BPCinema
//
//  Created by Anita Stashevskaya on 27.03.2024.
//

import Foundation

protocol RegisterPresentable {
    var registerInteractor : RegisterInteractable? {get set}
    
    func registerAll(email : String, password : String)
}

final class RegisterPresenter: RegisterPresentable {
    var registerInteractor: RegisterInteractable?
    
    func registerAll(email: String, password: String) {
        registerInteractor?.register(email: email, password: password)
    }
}
