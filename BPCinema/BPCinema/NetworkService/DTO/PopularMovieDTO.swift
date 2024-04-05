//
//  PopularMovieDTO.swift
//  BPCinema
//
//  Created by Anita Stashevskaya on 05.04.2024.
//

import Foundation
struct PopularMovieDTO: Decodable {
    let page: Int?
    let results: [PopularMovieEntity]
}
