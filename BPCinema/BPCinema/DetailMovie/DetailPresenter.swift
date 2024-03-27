//
//  DetailPresenter.swift
//  BPCinema
//
//  Created by Anita Stashevskaya on 19.03.2024.
//

import Foundation

protocol DetailPresenterUI: AnyObject {
    func updateUI(viewModel: DetailMovieViewModel)
}

protocol DetailPresentable: AnyObject {
    var ui: DetailPresenterUI? { get }
    var movieID: String { get }
    var movieDetail: DetailMovieEntity? { get }
    func onViewAppear()
}

final class DetailPresenter: DetailPresentable {
    weak var ui: DetailPresenterUI?
    
    let movieID: String
    private let interactor: DetailMovieInteractable
    private let mapper: MapperDetailMovieViewModel
    var movieDetail: DetailMovieEntity?
    
    init(movieID: String,
         interactor: DetailMovieInteractable,
         mapper: MapperDetailMovieViewModel) {
        self.interactor = interactor
        self.movieID = movieID
        self.mapper = mapper
    }
    
    func onViewAppear() {
        Task {
            let model = await interactor.getDetailMovie(withID: movieID)
            let viewModel = mapper.map(entity: model)
            await MainActor.run {
                self.ui?.updateUI(viewModel: viewModel)
                print(viewModel)
            }
            
        }
    }
}
