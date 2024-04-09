//
//  RegistrationFactory.swift
//  BPCinema
//
//  Created by Anita Stashevskaya on 08.04.2024.
//

import Foundation

import UIKit

import UIKit

final class RegistrationFactory {
    static func assembledScreen(withRouter router: RegistrationRouter) {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let window = windowScene.windows.first else {
            return
        }
        let interactor = RegisterInteractor()
        let presenter = RegisterPresenter(registerInteractor: interactor, router: router)
        let registerView = RegisterViewController(presenter: presenter)
        window.rootViewController = registerView
        window.makeKeyAndVisible()
    }
}
