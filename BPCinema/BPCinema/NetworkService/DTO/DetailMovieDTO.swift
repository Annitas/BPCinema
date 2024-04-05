//
//  DetailMovieDTO.swift
//  BPCinema
//
//  Created by Anita Stashevskaya on 05.04.2024.
//

import Foundation

struct DetailMovieDTO: Decodable {
    let title: String
    let overview: String
    let backdropPath: String
    let status: String
    let releaseDate: String
    let voteAverage: Double
    let voteCount: Int
}
