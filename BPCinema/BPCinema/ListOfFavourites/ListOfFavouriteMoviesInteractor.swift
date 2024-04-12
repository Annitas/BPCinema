//
//  ListOfFavouriteMoviesInteractor.swift
//  BPCinema
//
//  Created by Anita Stashevskaya on 29.03.2024.
//

import Foundation

protocol ListOfFavouriteMoviesInteractable: AnyObject {
    func getFavourites() async -> PopularMovieResponseEntity
}

final class ListOfFavouriteMoviesInteractor: ListOfFavouriteMoviesInteractable  {
    func getFavourites() async -> PopularMovieResponseEntity {
        do {
            return try await NetworkService.request(type: .getFavourites, responseType: PopularMovieResponseEntity.self)
        } catch {
            return PopularMovieResponseEntity(page: 0, results: [PopularMovieEntity(id: 0, title: "", overview: "", imageURL: "", votes: 0.0)])
        }
    }
}

final class ListOfFavouriteMoviesInteractorMock: ListOfFavouriteMoviesInteractable {
    func getFavourites() async -> PopularMovieResponseEntity {
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
