//
//  MovieDetailsFactory.swift
//  BPCinema
//
//  Created by Anita Stashevskaya on 12.04.2024.
//

import Foundation

final class MovieDetailsFactory {
    class func assembledScreen(_ router: MovieDetailsRouter = .init()) -> DetailMovieViewController {
        let interactor = MovieDetailsInteractor()
        let presenter = MovieDetailsPresenter(router, interactor)
        let viewController = DetailMovieViewController()
        viewController.presenter = presenter
        router.viewController = viewController
        return viewController
    }
}
