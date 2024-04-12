//
//  FMapper.swift
//  BPCinema
//
//  Created by Anita Stashevskaya on 03.04.2024.
//

import Foundation

struct FMapper {
    func map(entity: FavouriteMovieEntity) -> FavouriteMovieViewModel {
        FavouriteMovieViewModel(title: entity.title,
                       overview: entity.overview,
                       imageURL: URL(string: "https://image.tmdb.org/t/p/w200" + entity.imageURL))
    }
}
