//
//  ListOfMoviewPresenter.swift
//  BPCinema
//
//  Created by Anita Stashevskaya on 18.03.2024.
//

import Foundation

protocol ListOfMoviesPresentable: AnyObject {
    var ui: ListOfMoviesUI? { get }
    var viewModels: [MovieViewModel] { get }
    func onViewAppear()
}

protocol ListOfMoviesUI: AnyObject {
    func update(movies: [MovieViewModel])
}

final class ListOfMoviesPresenter: ListOfMoviesPresentable {
    weak var ui: ListOfMoviesUI?
    
    private let listOfMoviesInteractor: ListOfMoviesInteractable
    var viewModels: [MovieViewModel] = []
    private let mapper: Mapper
    
    init(listOfMoviesInteractor: ListOfMoviesInteractable, mapper: Mapper = Mapper()) {
        self.listOfMoviesInteractor = listOfMoviesInteractor
        self.mapper = mapper
    }
    
    func onViewAppear() {
        Task {
            let models = await listOfMoviesInteractor.getListOfMoview().results
            viewModels = models.map(mapper.map(entity:))
            ui?.update(movies: viewModels)
        }
    }
}
