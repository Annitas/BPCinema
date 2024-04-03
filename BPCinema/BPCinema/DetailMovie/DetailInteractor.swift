//
//  DetailInteractor.swift
//  BPCinema
//
//  Created by Anita Stashevskaya on 19.03.2024.
//

import Foundation

protocol DetailMovieInteractable: AnyObject {
    func getDetailMovie(withID id: String) async -> DetailMovieEntity
    func addToFavorites(movieId: String, accountId: String) async
}

final class DetailMovieInteractor: DetailMovieInteractable {
    func getDetailMovie(withID id: String) async -> DetailMovieEntity {
        return await APIService.shared.getDetailMovie(withID: id)
    }
    
    func addToFavorites(movieId: String, accountId: String) async {
        await APIService.shared.addToFavorites(movieId: movieId, accountId: accountId)
    }
}
