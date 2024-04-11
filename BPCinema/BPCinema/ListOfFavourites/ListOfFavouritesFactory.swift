//
//  ListOfFavouritesFactory.swift
//  BPCinema
//
//  Created by Anita Stashevskaya on 09.04.2024.
//

import UIKit

final class ListOfFavouriteMoviesFactory {
    static func assembledScreen(withRouter router: ListOfFavouriteMoviesRouter) -> ListOfFavouriteMoviesViewController {
        let interactor = ListOfFavouriteMoviesInteractor()
        let presenter = ListOfFavouriteMoviesPresenter(listOfFavouriteMoviesInteractor: interactor,
                                              router: router)
        let listOfFavouriteMoviesView = ListOfFavouriteMoviesViewController(presenter: presenter)
        presenter.ui = listOfFavouriteMoviesView
        router.showListOfFavouriteMovies(listOfFavouriteMoviesView: listOfFavouriteMoviesView)
        return listOfFavouriteMoviesView
    }
}
