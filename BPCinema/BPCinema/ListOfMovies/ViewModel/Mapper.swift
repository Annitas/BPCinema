//
//  Mapper.swift
//  BPCinema
//
//  Created by Anita Stashevskaya on 19.03.2024.
//

import Foundation

struct Mapper {
    func map(entity: PopularMovieEntity) -> MovieViewModel {
        MovieViewModel(title: entity.title,
                       overview: entity.overview,
                       imageURL: URL(string: "https://image.tmdb.org/t/p/w200" + entity.imageURL))
    }
}
