//
//  ListOfFavouritesPresenter.swift
//  BPCinema
//
//  Created by Anita Stashevskaya on 29.03.2024.
//


final class ListOfFavouriteMoviesPresenter {
    var movies: [PopularMovieEntity] = []
    
    let interactor: ListOfFavouriteMoviesInteractorProtocol
    var output: Output = .init() {
        didSet {
            outputChanged?()
        }
    }
    var outputChanged: (() -> ())?
    var input: Input = .init()
    struct Output {
        var viewModel: MovieListViewModel = .init(movies: [])
    }
    struct Input {
        var movieSelected: ((Int) -> ())?
    }
    var router: Router<ListOfFavouriteMoviesViewController>
    private let mapper: Mapper
    
    var viewModels: [MovieViewModel] = []
    
    init(router: Router<ListOfFavouriteMoviesViewController> = ListOfFavouriteMoviesRouter(),
         interactor: ListOfFavouriteMoviesInteractorProtocol = ListOfFavouriteMoviesInteractor(),
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
