//
//  MovieDTO.swift
//  BPCinema
//
//  Created by Anita Stashevskaya on 05.04.2024.
//

import Foundation

struct MovieDTO: Decodable {
    let id: Int
    let title: String
    let overview: String
    let imageURL: String
    let votes: Double
    
    enum CodingKeys: String, CodingKey {
        case id, title, overview
        case imageURL = "poster_path"
        case votes = "vote_average"
    }
}
