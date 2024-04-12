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
    func onTapCell(atIndex: Int)
}

protocol ListOfMoviesUI: AnyObject {
    func update(movies: [MovieViewModel])
}

final class ListOfMoviesPresenter: ListOfMoviesPresentable {
    weak var ui: ListOfMoviesUI?
    private let listOfMoviesInteractor: ListOfMoviesInteractable
    var viewModels: [MovieViewModel] = []
    private var models: [PopularMovieEntity] = []
    private let mapper: Mapper
    private let router: ListOfMoviesRouting
    
    init(listOfMoviesInteractor: ListOfMoviesInteractable, 
         mapper: Mapper = Mapper(),
         router: ListOfMoviesRouting) {
        self.listOfMoviesInteractor = listOfMoviesInteractor
        self.mapper = mapper
        self.router = router
    }
    
    func onViewAppear() {
        Task {
            models = await listOfMoviesInteractor.getMovies().results
            viewModels = models.map(mapper.map(entity:))
            ui?.update(movies: viewModels)
        }
    }
    
    func onTapCell(atIndex: Int) {
        let movieID = models[atIndex].id
        router.showDetailMovie(withMovieID: movieID.description)
    }
}
