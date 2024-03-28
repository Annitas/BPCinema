//
//  AuthInteractor.swift
//  BPCinema
//
//  Created by Anita Stashevskaya on 27.03.2024.
//

import Foundation
import UIKit
import Firebase

protocol LoginInteractable {
    func login(email : String, password : String )
    func isAlreadyLogin()
}

final class LoginInteractor: LoginInteractable {
    func login(email: String, password: String) {
        let auth = Auth.auth()
        auth.signIn(withEmail: email, password: password) { [weak self] authResult, error in
            guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                  let window = windowScene.windows.first else {
                return
            }
            let listRouter = ListOfMoviesRouter()
            listRouter.showListOfMovies(window: window)
            //                        strongSelf.emailTextField.resignFirstResponder()
            //                        strongSelf.passwordTextField.resignFirstResponder()
        }
    }
    
    func isAlreadyLogin() {
        if Auth.auth().currentUser != nil {
            guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                  let window = windowScene.windows.first else {
                return
            }
            let listRouter = ListOfMoviesRouter()
            listRouter.showListOfMovies(window: window)
        }
    }
}


