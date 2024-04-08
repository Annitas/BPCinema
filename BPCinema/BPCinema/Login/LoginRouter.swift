//
//  AuthRouter.swift
//  BPCinema
//
//  Created by Anita Stashevskaya on 27.03.2024.
//

import Foundation
import UIKit

protocol LoginRouting: AnyObject {
    var listOfMoviesRouter: ListOfMoviesRouting? { get }
    var loginView: LoginViewController? { get }
    
    func showLoginView(window: UIWindow?)
}

final class LoginRouter: LoginRouting {
    var listOfMoviesRouter: ListOfMoviesRouting?
    var loginView: LoginViewController?
    
    func showLoginView(window: UIWindow?) {
        self.listOfMoviesRouter = ListOfMoviesRouter()
        let interactor = LoginInteractor()
        let presenter = LoginPresenter(loginInteractor: interactor, router: self)
        loginView = LoginViewController(presenter: presenter)
        
        guard let loginView = loginView else {
            fatalError("Failed to create LoginViewController")
        }
        
        window?.rootViewController = loginView
        window?.makeKeyAndVisible()
    }
}
