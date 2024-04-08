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
    static func assembledScreen(withRouter router: RegisterRouter) {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let window = windowScene.windows.first else {
            return
        }
        router.showRegisterView(window: window)
    }
}
