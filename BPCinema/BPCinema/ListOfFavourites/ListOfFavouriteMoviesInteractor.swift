//
//  ListOfFavouriteMoviesInteractor.swift
//  BPCinema
//
//  Created by Anita Stashevskaya on 29.03.2024.
//

protocol ListOfFavouriteMoviesInteractorProtocol {
    func getFavourites() async -> [PopularMovieEntity]
    var movies: [PopularMovieEntity] { get }
}

final class ListOfFavouriteMoviesInteractor: ListOfFavouriteMoviesInteractorProtocol  {
    var service: PopularMoviesServiceProtocol
    init(service: PopularMoviesServiceProtocol = PopularMoviesService()) {
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

protocol PopularMoviesServiceProtocol {
    func getFavourites() async throws -> [PopularMovieEntity]
}

class PopularMoviesService: PopularMoviesServiceProtocol {
    func getFavourites() async throws -> [PopularMovieEntity] {
        try await NetworkService.request(type: .getFavourites, responseType: PopularMovieResponseEntity.self)
            .results
            .map { PopularMovieEntity(id: $0.id, title: $0.title, overview: $0.overview, imageURL: $0.imageURL, votes: $0.votes) }
    }
}

