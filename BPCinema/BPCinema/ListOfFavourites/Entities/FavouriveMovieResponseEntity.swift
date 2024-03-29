//
//  FavouriveMovieResponseEntity.swift
//  BPCinema
//
//  Created by Anita Stashevskaya on 29.03.2024.
//

import Foundation

struct FavouriteMovieResponseEntity: Decodable {
    let page: Int?
    let results: [FavouriteMovieEntity]
}
