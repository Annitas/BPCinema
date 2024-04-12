//
//  RegisterInteractor.swift
//  BPCinema
//
//  Created by Anita Stashevskaya on 27.03.2024.
//

import Foundation
import Firebase

protocol RegisterInteractable {
    func register(email : String, password : String)
}

final class RegisterInteractor: RegisterInteractable {
    func register(email: String, password: String) {
        let auth = Auth.auth()
        auth.createUser(withEmail: email, password: password)
        {
            (authresult, error) in
            if let user = authresult?.user
            {
                print(user)
            }else
            {
                print("User can't enter.")
            }
        }
    }
}
