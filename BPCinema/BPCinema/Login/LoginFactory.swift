//
//  LoginFactory.swift
//  BPCinema
//
//  Created by Anita Stashevskaya on 08.04.2024.
//

import UIKit

final class LoginFactory {
    static func assembledScreen(withRouter router: LoginRouter, window: UIWindow?) -> LoginViewController {
        let interactor = LoginInteractor()
        let presenter = LoginPresenter(loginInteractor: interactor, router: router)
        let loginView = LoginViewController(presenter: presenter)
        router.showLoginView(in: window)
        return loginView
    }
}
