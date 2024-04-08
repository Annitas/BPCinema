//
//  LoginFactory.swift
//  BPCinema
//
//  Created by Anita Stashevskaya on 08.04.2024.
//

import UIKit

final class LoginFactory {
    static func assembledScreen(withRouter router: LoginRouter) {
        let presenter = LoginPresenter(router: router)
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let window = windowScene.windows.first else {
            return
        }
        router.showLoginView(window: window)
    }
}
