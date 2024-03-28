//
//  Register.swift
//  BPCinema
//
//  Created by Anita Stashevskaya on 27.03.2024.
//

import Foundation


protocol RegisterRouting {
    static func createRegisterModule(ref: RegisterViewController)
}

final class RegisterRouter: RegisterRouting {
    static func createRegisterModule(ref: RegisterViewController) {
        ref.register = RegisterPresenter()
        ref.register?.registerInteractor = RegisterInteractor()
    }
}
