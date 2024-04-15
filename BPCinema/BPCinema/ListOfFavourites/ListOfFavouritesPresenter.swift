//
//  ListOfFavouritesPresenter.swift
//  BPCinema
//
//  Created by Anita Stashevskaya on 29.03.2024.
//

import Foundation


protocol ListOfFavouriteMoviesPresentable: AnyObject {
    var ui: ListOfFavouriteMoviesUI? { get }
    var viewModels: [MovieViewModel] { get }
    func onViewAppear()
    func onTapCell(atIndex: Int)
}

protocol ListOfFavouriteMoviesUI: AnyObject {
    func update(movies: [MovieViewModel])
}

final class ListOfFavouriteMoviesPresenter: ListOfFavouriteMoviesPresentable {
    weak var ui: ListOfFavouriteMoviesUI?
    private let listOfFavouriteMoviesInteractor: ListOfFavouriteMoviesInteractable
    var viewModels: [MovieViewModel] = []
    private var models: [PopularMovieEntity] = []
    private let mapper: Mapper
    private let router: ListOfFavouriteMoviesRouting
    
//    var outputChanged: (() -> Void)?
    
    init(listOfFavouriteMoviesInteractor: ListOfFavouriteMoviesInteractable,
         mapper: Mapper = Mapper(),
         router: ListOfFavouriteMoviesRouting) {
        self.listOfFavouriteMoviesInteractor = listOfFavouriteMoviesInteractor
        self.mapper = mapper
        self.router = router
    }
    
    func onViewAppear() {
        Task {
            models = await listOfFavouriteMoviesInteractor.getFavourites().results
            viewModels = models.map(mapper.map(entity:))
            ui?.update(movies: viewModels)
        }
    }
    
    func onTapCell(atIndex: Int) {
        let movieID = models[atIndex].id
        router.showDetailMovie(withMovieID: movieID.description)
    }
}
