//
//  DBManager.swift
//  BPCinema
//
//  Created by Anita Stashevskaya on 23.03.2024.
//

import Foundation
import FirebaseDatabase
import FirebaseAuth

final class DBManager {
    public static let shared: DBManager = DBManager()
    
    private let database = Database.database().reference()
    
    public func addUser(with user: CinemaUser, completion: @escaping (Bool) -> Void) {
        database.child(user.safeEmail).setValue([
            "first_name": user.firstName,
            "last_name": user.lastName
        ]) { error, _ in
            guard error == nil else {
                print("Failed to add user to database")
                completion(false)
                return
            }
            
            completion(true)
        }
    }
}
