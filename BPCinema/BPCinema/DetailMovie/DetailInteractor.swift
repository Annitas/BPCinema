//
//  DetailInteractor.swift
//  BPCinema
//
//  Created by Anita Stashevskaya on 19.03.2024.
//

import Foundation

protocol MovieDetailsInteractorProtocol {
    func getGetailMovie(withID id: String) async -> DetailMovieEntity
    var movie: DetailMovieEntity { get }
}

final class MovieDetailsInteractor: MovieDetailsInteractorProtocol {
    var movie = DetailMovieEntity()
    
    func getGetailMovie(withID id: String) async -> DetailMovieEntity {
        do {
            movie = try await NetworkService.request(type: .getMovieDetails(id: id), responseType: DetailMovieEntity.self)
        } catch {
            movie = DetailMovieEntity(title: "", overview: "", backdropPath: "", status: "", releaseDate: "", voteAverage: 0.0, voteCount: 0)
        }
        return movie
    }
}


protocol DetailMovieInteractable: AnyObject {
    func getDetails(withID id: String) async -> DetailMovieEntity
    func addMovieToFavourite(movieId: String) async
}

final class DetailMovieInteractor: DetailMovieInteractable {
    func getDetails(withID id: String) async -> DetailMovieEntity {
        do {
            return try await NetworkService.request(type: .getMovieDetails(id: id), responseType: DetailMovieEntity.self)
        } catch {
            return DetailMovieEntity(title: "", overview: "", backdropPath: "", status: "", releaseDate: "", voteAverage: 0.0, voteCount: 0)
        }
    }
    
    func addMovieToFavourite(movieId: String) async {
        do {
            let detailMovie = try! await NetworkService.request(type: .getMovieDetails(id: movieId), responseType: DetailMovieEntity.self)
            DBManager.shared.addToDB(movie: detailMovie)
            try await NetworkService.request(type: .addMovieToFavourites(movieId: movieId), responseType: DetailMovieEntity.self)
        } catch {
            print("OOOPS")
        }
    }
    
}
