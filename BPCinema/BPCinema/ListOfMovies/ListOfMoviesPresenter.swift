//
//  ListOfMoviewPresenter.swift
//  BPCinema
//
//  Created by Anita Stashevskaya on 18.03.2024.
//

import Foundation

protocol MovieListInteractorProtocol {
    func getMovies() async -> [PopularMovieEntity]
    var movies: [PopularMovieEntity] { get }
}

final class ListOfMoviesPresenter {
    let interactor: MovieListInteractorProtocol
    var output: Output = .init() {
        didSet {
            outputChanged?()
        }
    }
    var input: Input = .init()
    
    struct Output {
        var viewModel: MovieListViewModel = .init(movies: [])
    }
    struct Input {
        var movieSelected: ((Int) -> ())?
    }
    private let mapper: Mapper
    var outputChanged: (() -> ())?
    var router: Router<ListOfMoviesViewController>
    
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
            let array = await interactor.getMovies().map(mapper.map(entity:))
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
