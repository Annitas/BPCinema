//
//  ListOfMoviewPresenter.swift
//  BPCinema
//
//  Created by Anita Stashevskaya on 18.03.2024.
//

import Foundation

final class ListOfMoviesPresenter {
    let interactor: MovieListInteractorProtocol
    var router: Router<ListOfMoviesViewController>
    var output: Output = .init() {
        didSet {
            outputChanged?()
        }
    }
    var input: Input = .init()
    var outputChanged: (() -> ())?
    private let mapper: Mapper
    
    init(router: Router<ListOfMoviesViewController> = MovieListRouter(),
         interactor: MovieListInteractorProtocol = MovieListInteractor(), 
         output: Output = .init(),
         outputChanged: (() -> Void)? = nil,
         mapper: Mapper = Mapper()) {
        self.router = router
        self.interactor = interactor
        self.output = output
        self.outputChanged = outputChanged
        self.mapper = mapper
        Task {
            let array = await interactor.getMovies("1").map(mapper.map(entity:))
            await MainActor.run {
                self.output.viewModel = .init(movies: array)
            }
        }

        input.movieSelected = { [unowned self] movieIndex in
            let movie = interactor.movies[movieIndex]
            (self.router as? MovieDetailsRoute)?.openMovieDetails(movie)
        }
    }
}

extension ListOfMoviesPresenter {
    struct Output {
        var viewModel: MovieListViewModel = .init(movies: [])
    }
    struct Input {
        var movieSelected: ((Int) -> ())?
    }
}

final class ListOfFavouriteMoviesPresenter {
    let interactor: MovieListInteractorProtocol
    var output: Output = .init() {
        didSet {
            outputChanged?()
        }
    }
    var outputChanged: (() -> ())?
    var input: Input = .init()
    var router: Router<ListOfFavouriteMoviesViewController>
    private let mapper: Mapper
    init(router: Router<ListOfFavouriteMoviesViewController> = ListOfFavouriteMoviesRouter(),
         interactor: MovieListInteractorProtocol = MovieListInteractor(),
         output: Output = .init(),
         outputChanged: (() -> Void)? = nil,
         mapper: Mapper = Mapper()
         ) {
        self.router = router
        self.interactor = interactor
        self.output = output
        self.outputChanged = outputChanged
        self.mapper = mapper
        Task {
            let models = await interactor.getFavourites().map(mapper.map(entity:))
            await MainActor.run {
                self.output.viewModel = .init(movies: models)
            }
        }
        input.movieSelected = { [unowned self] movieIndex in
            let movie = interactor.movies[movieIndex]
            (self.router as? MovieDetailsRoute)?.openMovieDetails(movie)
        }
    }
}

extension ListOfFavouriteMoviesPresenter {
    struct Output {
        var viewModel: MovieListViewModel = .init(movies: [])
    }
    struct Input {
        var movieSelected: ((Int) -> ())?
    }
}
