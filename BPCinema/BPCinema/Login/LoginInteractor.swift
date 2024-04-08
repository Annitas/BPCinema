//
//  AuthInteractor.swift
//  BPCinema
//
//  Created by Anita Stashevskaya on 27.03.2024.
//

import UIKit
import Firebase

protocol LoginInteractable {
    func login(email : String, password : String )
    func isAlreadyLogin()
    func validate(p1: String, p2: String) -> Bool
}

final class LoginInteractor: LoginInteractable {
    private let tabBarCoordinator = TabBarCoordinator()

    func login(email: String, password: String) {
        let auth = Auth.auth()
        auth.signIn(withEmail: email, password: password) { [weak self] authResult, error in
            if error == nil && ((self?.validate(p1: email, p2: password)) != nil) {
                guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                      let window = windowScene.windows.first else {
                    return
                }
                self?.tabBarCoordinator.showTabBar(withWindow: window)
            } else {
                print("FAILED TO LOG IN")
                // TODO: Handle login error
            }
        }
    }
    
    func isAlreadyLogin() {
//        if Auth.auth().currentUser != nil {
//            guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
//                  let window = windowScene.windows.first else {
//                return
//            }
//            tabBarCoordinator.showTabBar(withWindow: window)
//        }
    }

    func validate(p1: String, p2: String) -> Bool {
        return (dataValid(p1: p1, p2: p2))
    }
    
    private func dataValid(p1: String, p2: String) -> Bool {
        return p1.isValidEmailRequirements && p2.isValidPasswordRequirements
    }
}

extension String {
    var isValidEmailRequirements: Bool {
        let email = self
        let emailRegx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailCheck = NSPredicate(format: "SELF MATCHES %@", emailRegx)
        let val = emailCheck.evaluate(with: email)
        return val
    }
    var isValidPasswordRequirements: Bool {
        let password = self
        let passwordRegx = "^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.*[@$!#%*?&]).{8,}$"
        let passwordCheck = NSPredicate(format: "SELF MATCHES %@", passwordRegx)
        let val = passwordCheck.evaluate(with: password)
        return val
    }
}
