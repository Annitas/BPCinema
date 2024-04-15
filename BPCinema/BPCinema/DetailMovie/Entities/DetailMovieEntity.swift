//
//  DetailMovieEntity.swift
//  BPCinema
//
//  Created by Anita Stashevskaya on 19.03.2024.
//

import Foundation

struct DetailMovieEntity: Decodable {
    var title: String = ""
    var overview: String = ""
    var backdropPath: String = ""
    var status: String = ""
    var releaseDate: String = ""
    var voteAverage: Double = 0.0
    var voteCount: Int = 0
}
