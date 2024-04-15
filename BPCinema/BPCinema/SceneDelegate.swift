//
//  SceneDelegate.swift
//  BPCinema
//
//  Created by Anita Stashevskaya on 18.03.2024.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var loginRouter = LoginRouter()

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        let vc = LoginFactory.assembledScreen(loginRouter)
        InitialRouter().openLogin()
    }
    final class InitialRouter: Router<LoginViewController>,  LoginRoute {
        var openLoginTransition: Transition = WindowRootTransition()
    }
}

