//
//  ListOfMoviesInteractor.swift
//  BPCinema
//
//  Created by Anita Stashevskaya on 18.03.2024.
//

// API Key: fae05adc59b94dcb33377a38bfd09528

import Foundation
import CoreData

protocol ListOfMoviesInteractable: AnyObject {
    func getListOfMoview() async -> PopularMovieResponseEntity
    func getFavouriteMovies() async -> PopularMovieResponseEntity
    func getMovies() async throws -> [MovieDTO]
}

final class ListOfMoviesInteractor: ListOfMoviesInteractable {
    func getMovies() async throws -> [MovieDTO] {
        let userCategories = try await NetworkService.request(type: .getListOfMovies, responseType: [PopularMovieDTO].self)
        return try await NetworkService.request(type: .getListOfMovies, responseType: [MovieDTO].self)
            .map { movieDTO in
                MovieDTO(id: movieDTO.id, title: movieDTO.title,
                         overview: movieDTO.overview, imageURL: movieDTO.imageURL,
                         votes: movieDTO.votes)
            }
    }
    
    func getListOfMoview() async -> PopularMovieResponseEntity {
        await APIService.shared.getListOfMoview()
    }
    
    func getFavouriteMovies() async -> PopularMovieResponseEntity {
        await APIService.shared.getFavouriteMovies()
    }
}

final class ListOfMoviesInteractorMock: ListOfMoviesInteractable {
    func getMovies() async throws -> [MovieDTO] {
        return []
    }
    
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
    
    func getListOfMoview() async -> PopularMovieResponseEntity {
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
