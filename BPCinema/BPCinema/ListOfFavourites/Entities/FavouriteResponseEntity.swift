//
//  FavouriteResponseEntity.swift
//  BPCinema
//
//  Created by Anita Stashevskaya on 03.04.2024.
//

import Foundation

struct FavouriteMovieEntity: Decodable {
    var id: Int
    var title: String
    var overview: String
    var imageURL: String
    var votes: Double
    
    enum CodingKeys: String, CodingKey {
        case id, title, overview
        case imageURL = "poster_path"
        case votes = "vote_average"
    }
}
