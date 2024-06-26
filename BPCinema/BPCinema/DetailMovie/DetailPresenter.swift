//
//  DetailPresenter.swift
//  BPCinema
//
//  Created by Anita Stashevskaya on 19.03.2024.
//

import Foundation


protocol MovieDetailsPresenterProtocol {
    var router: Router<DetailMovieViewController> { get }
    var interactor: MovieDetailsInteractorProtocol { get }
    var input: Input { get }
}

final class MovieDetailsPresenter {
    let router: Router<DetailMovieViewController>
    let interactor: MovieDetailsInteractorProtocol
    var output: Output = .init() {
        didSet {
            outputChanged?()
        }
    }
    let movieID: String
    var outputChanged: (() -> ())?
    private let mapper: MapperDetailMovieViewModel
    var input: Input = .init()
    
    init(_ router: Router<DetailMovieViewController>,
         _ interactor: MovieDetailsInteractorProtocol,
         output: Output = .init(),
         outputChanged: (() -> Void)? = nil,
         movieID: String = "",
         mapper: MapperDetailMovieViewModel = MapperDetailMovieViewModel()) {
        self.router = router
        self.interactor = interactor
        self.output = output
        self.outputChanged = outputChanged
        self.movieID = movieID
        self.mapper = mapper
        Task {
            let model = await interactor.getGetailMovie(withID: movieID)
            let viewModel = mapper.map(entity: model)
            await MainActor.run {
                self.output.viewModel = .init(title: viewModel.title, overview: viewModel.overview, backdropPath: viewModel.backdropPath)
            }
        }
        input.addToFavouritesSelected = { [unowned self] movieIndex in
            await interactor.addMovieToFavourite(movieId: movieIndex)
        }
    }
}

extension MovieDetailsPresenter: MovieDetailsPresenterProtocol {
    struct Output {
        var viewModel: DetailMovieViewModel = .init(title: "", overview: "", backdropPath: URL(string: ""))
    }
}
