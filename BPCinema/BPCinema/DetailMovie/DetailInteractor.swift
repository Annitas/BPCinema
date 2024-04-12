//
//  DetailInteractor.swift
//  BPCinema
//
//  Created by Anita Stashevskaya on 19.03.2024.
//

import Foundation

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
