//
//  FavouriteMovieResponseEntity.swift
//  BPCinema
//
//  Created by Anita Stashevskaya on 03.04.2024.
//

import Foundation

struct FavouriteMovieResponseEntity: Decodable {
    let page: Int?
    let results: [FavouriteMovieEntity]
}
