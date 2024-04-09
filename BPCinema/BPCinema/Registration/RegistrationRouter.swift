//
//  Register.swift
//  BPCinema
//
//  Created by Anita Stashevskaya on 27.03.2024.
//

import UIKit
protocol RegisterRouting: AnyObject {
    var registerView: RegisterViewController? { get }
    
    func showRegisterView(window: UIWindow?)
}

final class RegistrationRouter: RegisterRouting {
    var registerView: RegisterViewController?
    
    func showRegisterView(window: UIWindow?) {
        guard let window = window else { return }
        let viewController = RegistrationFactory.assembledScreen(withRouter: self)
        window.rootViewController = viewController
        window.makeKeyAndVisible()
        self.registerView = viewController
    }
}
