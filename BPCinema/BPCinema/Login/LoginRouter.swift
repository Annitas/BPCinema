//
//  AuthRouter.swift
//  BPCinema
//
//  Created by Anita Stashevskaya on 27.03.2024.
//

import Foundation
import UIKit

final class LoginRouter: Router<LoginViewController>, LoginRouter.Routes {
    var openMovieListTransition: Transition = PushTransition()
    
    typealias Routes = MovieListRoute
}


protocol LoginRoute {
    var openLoginTransition: Transition { get }
    func openLogin()
}

extension LoginRoute where Self: RouterProtocol {
    func openLogin() {
        let router = LoginRouter()
        let viewController = LoginFactory.assembledScreen(router)
        openWithNextRouter(viewController, nextRouter: router, transition: openLoginTransition)
    }
}
