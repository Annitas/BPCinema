//
//  PopularMovieResponseEntity.swift
//  BPCinema
//
//  Created by Anita Stashevskaya on 18.03.2024.
//

import Foundation

struct PopularMovieResponseEntity: Decodable {
    let page: Int?
    let results: [PopularMovieEntity]
}
