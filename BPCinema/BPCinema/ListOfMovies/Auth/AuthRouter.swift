//
//  AuthRouter.swift
//  BPCinema
//
//  Created by Anita Stashevskaya on 22.03.2024.
//

import Foundation
import UIKit

protocol AuthRouting: AnyObject {
    var listOfMoviesRouter: ListOfMoviesRouting? { get }
}

final class LoginRouter {
    var listOfMoviesRouter: ListOfMoviesRouting?
    var loginView = LoginViewController()
    
    func showLoginView(window: UIWindow?) {
        window?.rootViewController = loginView
        window?.makeKeyAndVisible()
    }
}
