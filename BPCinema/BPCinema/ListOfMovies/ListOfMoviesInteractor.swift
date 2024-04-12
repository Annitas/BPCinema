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
    func getMovies() async -> PopularMovieResponseEntity
}

final class ListOfMoviesInteractor: ListOfMoviesInteractable {
    func getMovies() async -> PopularMovieResponseEntity {
        do {
            return try await NetworkService.request(type: .getMovies, responseType: PopularMovieResponseEntity.self)
        } catch {
            return PopularMovieResponseEntity(page: 0, results: [PopularMovieEntity(id: 0, title: "", overview: "", imageURL: "", votes: 0.0)])
        }
    }
}

final class ListOfMoviesInteractorMock: ListOfMoviesInteractable {
    func getMovies() async -> PopularMovieResponseEntity {
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
