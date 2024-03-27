//
//  UserViewModel.swift
//  BPCinema
//
//  Created by Anita Stashevskaya on 22.03.2024.
//

import Foundation
// TODO: Remake to "FavouriteMovie"
struct CinemaUser {
    var firstName: String
    var lastName: String
    var emailAddress: String
    
    var safeEmail: String {
        var safeEmail = emailAddress.replacingOccurrences(of: ".", with: "-")
        safeEmail = safeEmail.replacingOccurrences(of: "@", with: "-")
        return safeEmail
    }
}

