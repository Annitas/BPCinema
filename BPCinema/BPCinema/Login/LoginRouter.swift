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
        guard let window = window else { return }
        let loginViewController = LoginFactory.assembledScreen(withRouter: self)
        self.loginView = loginViewController
    }
}
