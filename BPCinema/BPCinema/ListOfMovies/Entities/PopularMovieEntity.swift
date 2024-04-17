//
//  PopularMovieEntity.swift
//  BPCinema
//
//  Created by Anita Stashevskaya on 18.03.2024.
//

import Foundation

struct PopularMovieEntity: Decodable {
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
    
//    init(from decoder: any Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        self.id = try container.decode(Int.self, forKey: .id)
//        self.title = try container.decode(String.self, forKey: .title)
//        self.overview = try container.decode(String.self, forKey: .overview)
//        self.imageURL = "https://image.tmdb.org/t/p/w200 + \(self.imageURL)"
//        self.votes = try container.decode(Double.self, forKey: .votes)
//    }
}
