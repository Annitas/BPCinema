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
        let router = RegistrationRouter()
        let viewController = RegistrationFactory.assembledScreen(withRouter: router)
        
    }
}
