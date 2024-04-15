//
//  ListOfFavouritesFactory.swift
//  BPCinema
//
//  Created by Anita Stashevskaya on 09.04.2024.
//

import UIKit

final class ListOfFavouriteMoviesFactory {
    static func assembledScreen(_ router: ListOfFavouriteMoviesRouter = .init()) -> ListOfFavouriteMoviesViewController {
        let interactor = ListOfFavouriteMoviesInteractor()
        let presenter = ListOfFavouriteMoviesPresenter(router: router, interactor: interactor)
        let viewController = ListOfFavouriteMoviesViewController()
        viewController.presenter = presenter
        router.viewController = viewController
        return viewController
    }
}
