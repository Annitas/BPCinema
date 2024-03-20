//
//  DetailMovieViewModel.swift
//  BPCinema
//
//  Created by Anita Stashevskaya on 19.03.2024.
//

import Foundation

struct DetailMovieViewModel: Decodable {
    let title: String
    let overview: String
    let backdropPath: URL?
//    let status: String
//    let releaseDate: String
//    let voteAverage: Double
//    let voteCount: Int
}
