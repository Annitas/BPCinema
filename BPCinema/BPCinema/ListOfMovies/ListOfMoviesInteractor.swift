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
}

final class ListOfMoviesInteractor: ListOfMoviesInteractable {
    func getListOfMoview() async -> PopularMovieResponseEntity {
        let url = URL(string: "https://api.themoviedb.org/3/movie/popular?api_key=fae05adc59b94dcb33377a38bfd09528")!
        let (data, _) = try! await URLSession.shared.data(from: url)
        return try! JSONDecoder().decode(PopularMovieResponseEntity.self, from: data)
    }
}

final class ListOfMoviesInteractorMock: ListOfMoviesInteractable {
    func getListOfMoview() async -> PopularMovieResponseEntity {
        return PopularMovieResponseEntity(results: [
            .init(id: 0, title: "Panda", overview: "----", imageURL: "", votes: 10),
            .init(id: 1, title: "Red Panda", overview: "rferferf", imageURL: "", votes: 10),
            .init(id: 2, title: "Kung Fu Panda", overview: "kmlkmlkm", imageURL: "", votes: 20),
            .init(id: 3, title: "Panda panda", overview: "m;mom[", imageURL: "", votes: 20),
            .init(id: 4, title: "Another Panda", overview: "yftcuvuoijok", imageURL: "", votes: 30),
            .init(id: 5, title: "Another Panda", overview: "yftcuvuoijok", imageURL: "", votes: 40),
        ])
    }
}
