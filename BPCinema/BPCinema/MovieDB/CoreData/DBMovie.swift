//
//  UserViewModel.swift
//  BPCinema
//
//  Created by Anita Stashevskaya on 22.03.2024.
//

import CoreData

class DBMovie: NSManagedObject {
    var title = String()
    var overView = String()
    var image = Data()
}

//var id: Int
//var title: String
//var overview: String
//var imageURL: String
//var votes: Double
