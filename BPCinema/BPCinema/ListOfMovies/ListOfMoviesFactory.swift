//
//  ListOfMoviesFactory.swift
//  BPCinema
//
//  Created by Anita Stashevskaya on 09.04.2024.
//

import UIKit

final class ListOfMoviesFactory {
    class func assembledScreen(_ router: MovieListRouter = .init()) -> ListOfMoviesViewController {
        let interactor = MovieListInteractor()
        let presenter = ListOfMoviesPresenter(router: router, interactor: interactor)
        let viewController = ListOfMoviesViewController()
        viewController.presenter = presenter
        router.viewController = viewController
        return viewController
    }
}
final class ListOfFavouriteMoviesFactory {
    static func assembledScreen(_ router: ListOfFavouriteMoviesRouter = .init()) -> ListOfFavouriteMoviesViewController {
        let interactor = MovieListInteractor()
        let presenter = ListOfFavouriteMoviesPresenter(router: router, interactor: interactor)
        let viewController = ListOfFavouriteMoviesViewController()
        viewController.presenter = presenter
        router.viewController = viewController
        return viewController
    }
}
