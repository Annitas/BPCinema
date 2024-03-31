//
//  DBFavouriteMovies.swift
//  BPCinema
//
//  Created by Anita Stashevskaya on 29.03.2024.
//

import Foundation

import CoreData
// TODO: Remake to "FavouriteMovie"
class DBFavouriteMovies: NSManagedObject {
    var movies: [DBMovie] = []
}
