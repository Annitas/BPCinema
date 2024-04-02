//
//  AuthRouter.swift
//  BPCinema
//
//  Created by Anita Stashevskaya on 27.03.2024.
//

import Foundation
import UIKit

protocol LoginRouting {
    static func createLoginModule(ref: LoginViewController)
}

final class LoginRouter: LoginRouting {
    static func createLoginModule(ref: LoginViewController) {
        ref.presenter = LoginPresenter()
        ref.presenter?.loginInteractor = LoginInteractor()
    }
}
