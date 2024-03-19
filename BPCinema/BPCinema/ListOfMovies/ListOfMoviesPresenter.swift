//
//  ListOfMoviewPresenter.swift
//  BPCinema
//
//  Created by Anita Stashevskaya on 18.03.2024.
//

import Foundation

protocol ListOfMoviesUI: AnyObject {
    func update(movies: [MovieViewModel])
}

final class ListOfMoviesPresenter {
    var ui: ListOfMoviesUI?
    
    private let listOfMoviesInteractor: ListOfMoviesInteractor
    var viewModels: [MovieViewModel] = []
    private let mapper: Mapper
    
    init(listOfMoviesInteractor: ListOfMoviesInteractor, mapper: Mapper = Mapper()) {
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
