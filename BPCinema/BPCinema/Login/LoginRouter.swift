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
    
    func showLoginView()
}

final class LoginRouter: LoginRouting {
    var listOfMoviesRouter: ListOfMoviesRouting?
    var loginView: LoginViewController?
    
    func showLoginView() {
        self.listOfMoviesRouter = ListOfMoviesRouter()
    }
}
