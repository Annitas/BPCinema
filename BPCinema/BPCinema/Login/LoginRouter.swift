//
//  AuthRouter.swift
//  BPCinema
//
//  Created by Anita Stashevskaya on 27.03.2024.
//

import Foundation
import UIKit

protocol LoginRouting: AnyObject {
    var loginView: LoginViewController? { get }
    
    func showLoginView(in window: UIWindow?)
}

final class LoginRouter: LoginRouting {
    var loginView: LoginViewController?
    
    func showLoginView(in window: UIWindow?) {
        let loginViewController = LoginViewController(presenter: LoginPresenter(loginInteractor: LoginInteractor(), router: self))
        window?.rootViewController = loginViewController
        window?.makeKeyAndVisible()
        self.loginView = loginViewController
    }
}
