//
//  ListOfMoviewPresenter.swift
//  BPCinema
//
//  Created by Anita Stashevskaya on 18.03.2024.
//

import Foundation

protocol ListOfMoviesPresenterProtocol {
    var output: Output { get }
    var input: Input { get }
    var outputChanged: (() -> ())? { get set }
}

final class ListOfMoviesPresenter: ListOfMoviesPresenterProtocol {
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
    
    init(router: Router<ListOfMoviesViewController>,
         interactor: MovieListInteractorProtocol = MovieListInteractor(), 
         output: Output = .init(),
         outputChanged: (() -> Void)? = nil,
         mapper: Mapper = Mapper()) {
        self.router = router
        self.interactor = interactor
        self.output = output
        self.outputChanged = outputChanged
        self.mapper = mapper
        
        switch String(describing: router) {
        case "BPCinema.MovieListRouter":
            Task {
                let array = await interactor.getMovies("1").map(mapper.map(entity:))
                await MainActor.run {
                    self.output.viewModel = .init(movies: array)
                }
            }
        case "BPCinema.ListOfFavouriteMoviesRouter":
            Task {
                let models = await interactor.getFavourites().map(mapper.map(entity:))
                await MainActor.run {
                    self.output.viewModel = .init(movies: models)
                }
            }
        default:
            Task {
                let array = await interactor.getMovies("1").map(mapper.map(entity:))
                await MainActor.run {
                    self.output.viewModel = .init(movies: array)
                }
            }
        }
        input.movieSelected = { [unowned self] movieIndex in
            let movie = interactor.movies[movieIndex]
            (self.router as? MovieDetailsRoute)?.openMovieDetails(movie)
        }
    }
}
