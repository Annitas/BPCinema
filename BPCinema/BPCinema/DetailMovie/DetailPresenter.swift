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
    }
}

extension MovieDetailsPresenter: MovieDetailsPresenterProtocol {
    struct Input {
        
    }

    struct Output {
        var viewModel: DetailMovieViewModel = .init(title: "", overview: "", backdropPath: URL(string: ""))
    }
}


// - OLD
//protocol DetailPresenterUI: AnyObject {
//    func updateUI(viewModel: DetailMovieViewModel)
//}

//protocol DetailPresentable: AnyObject {
//    var ui: DetailPresenterUI? { get }
//    var movieID: String { get }
//    var movieDetail: DetailMovieEntity? { get }
//    func onViewAppear()
//    func addToFavourites(withID: String) async
//}
//
//final class DetailPresenter: DetailPresentable {
//    weak var ui: DetailPresenterUI?
//    
//    let movieID: String
//    private let interactor: DetailMovieInteractable
//    private let mapper: MapperDetailMovieViewModel
//    var movieDetail: DetailMovieEntity?
//    
//    init(movieID: String,
//         interactor: DetailMovieInteractable,
//         mapper: MapperDetailMovieViewModel) {
//        self.interactor = interactor
//        self.movieID = movieID
//        self.mapper = mapper
//    }
//    
//    func onViewAppear() {
//        Task {
//            let model = await interactor.getDetails(withID: movieID)
//            let viewModel = mapper.map(entity: model)
//            await MainActor.run {
//                self.ui?.updateUI(viewModel: viewModel)
//            }
//            
//        }
//    }
//    
//    func addToFavourites(withID id: String) async {
//        await interactor.addMovieToFavourite(movieId: id)
//    }
//}
