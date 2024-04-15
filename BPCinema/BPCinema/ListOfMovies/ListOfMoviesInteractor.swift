//
//  ListOfMoviesInteractor.swift
//  BPCinema
//
//  Created by Anita Stashevskaya on 18.03.2024.
//

// API Key: fae05adc59b94dcb33377a38bfd09528

import Foundation
import CoreData

protocol MovieListInteractorProtocol {
    func getMovies(_ page: String) async -> [PopularMovieEntity]
    var movies: [PopularMovieEntity] { get }
}

class MovieListInteractor: MovieListInteractorProtocol {
    var service: MovieListServiceProtocol
    init(service: MovieListServiceProtocol = MovieService()) {
        self.service = service
    }
    var movies: [PopularMovieEntity] = []
    func getMovies(_ page: String = "1") async -> [PopularMovieEntity] {
        do {
            movies = try await service.getMovies(page)
        } catch {
            movies = []
        }
        return movies
    }
}

protocol MovieListServiceProtocol {
    func getMovies(_ page: String) async throws -> [PopularMovieEntity]
}

class MovieService: MovieListServiceProtocol {
    func getMovies(_ page: String = "1") async throws -> [PopularMovieEntity] {
        try await NetworkService.request(type: .getMovies(page), responseType: PopularMovieResponseEntity.self)
            .results
            .map { PopularMovieEntity(id: $0.id, title: $0.title, overview: $0.overview, imageURL: $0.imageURL, votes: $0.votes) }
    }
}
