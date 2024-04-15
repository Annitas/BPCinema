//
//  ListOfFavouriteMoviesInteractor.swift
//  BPCinema
//
//  Created by Anita Stashevskaya on 29.03.2024.
//

import Foundation


//protocol ListOfFavouriteMoviesInteractorProtocol {
//    func getFavourites() async -> [PopularMovieEntity]
//    var movies: [PopularMovieEntity] { get }
//}

final class ListOfFavouriteMoviesInteractor: ListOfFavouriteMoviesInteractorProtocol  {
    var service: SecondServiceProtocol
    init(service: SecondServiceProtocol = SecondService()) {
        self.service = service
    }
    
    var movies: [PopularMovieEntity] = []
    
    func getFavourites() async -> [PopularMovieEntity] {
        do {
            movies = try await service.getFavourites()
        } catch {
            movies = []
        }
        return movies
    }
}

protocol SecondServiceProtocol {
    func getFavourites() async throws -> [PopularMovieEntity]
}

class SecondService: SecondServiceProtocol {
    func getFavourites() async throws -> [PopularMovieEntity] {
        try await NetworkService.request(type: .getFavourites, responseType: PopularMovieResponseEntity.self)
            .results
            .map { PopularMovieEntity(id: $0.id, title: $0.title, overview: $0.overview, imageURL: $0.imageURL, votes: $0.votes) }
    }
}

final class ListOfFavouriteMoviesInteractorMock {
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
