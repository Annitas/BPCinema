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

final class RegisterRouter: RegisterRouting {
    var registerView: RegisterViewController?
    
    func showRegisterView(window: UIWindow?) {
        let interactor = RegisterInteractor()
        let presenter = RegisterPresenter(registerInteractor: interactor, router: self)
        registerView = RegisterViewController(presenter: presenter)
        
        guard let registerView = registerView else {
            fatalError("Failed to create RegisterViewController")
        }
        
        window?.rootViewController = registerView
        window?.makeKeyAndVisible()
    }
}
