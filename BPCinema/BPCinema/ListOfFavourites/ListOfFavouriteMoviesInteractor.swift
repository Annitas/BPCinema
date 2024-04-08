//
//  ListOfFavouriteMoviesInteractor.swift
//  BPCinema
//
//  Created by Anita Stashevskaya on 29.03.2024.
//

import Foundation

protocol ListOfFavouriteMoviesInteractable: AnyObject {
    func getFavouriteMovies() async -> PopularMovieResponseEntity
}

protocol ListOfMoviesDataService {
    func loadMovies()
}
class FavoriteLisOfMoviesService {
    
}
class DefaultListOfMoviesSerice {
    
}

final class ListOfFavouriteMoviesInteractor: ListOfFavouriteMoviesInteractable  {
    func getFavouriteMovies() async -> PopularMovieResponseEntity {
        await APIService.shared.getFavouriteMovies()
    }
}

final class ListOfFavouriteMoviesInteractorMock: ListOfFavouriteMoviesInteractable {
    func getFavouriteMovies() async -> PopularMovieResponseEntity {
        return PopularMovieResponseEntity(page: 1, results: [
            .init(id: 0, title: "Panda", overview: "----", imageURL: "", votes: 10),
            .init(id: 1, title: "Red Panda", overview: "rferferf", imageURL: "", votes: 10),
            .init(id: 2, title: "Kung Fu Panda", overview: "kmlkmlkm", imageURL: "", votes: 20),
            .init(id: 3, title: "Panda panda", overview: "m;mom[", imageURL: "", votes: 20),
            .init(id: 4, title: "Another Panda", overview: "yftcuvuoijok", imageURL: "", votes: 30),
            .init(id: 5, title: "Another Panda", overview: "yftcuvuoijok", imageURL: "", votes: 40),
        ])
    }
}
