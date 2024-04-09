//
//  ListOfMoviesFactory.swift
//  BPCinema
//
//  Created by Anita Stashevskaya on 09.04.2024.
//

import UIKit

final class ListOfMoviesFactory {
    static func assembledScreen(withRouter router: ListOfMoviesRouter) -> ListOfMoviesViewController {
        let interactor = ListOfMoviesInteractor()
        let presenter = ListOfMoviesPresenter(listOfMoviesInteractor: interactor,
                                              router: router)
        let listOfMoviesView = ListOfMoviesViewController(presenter: presenter)
        presenter.ui = listOfMoviesView
        router.showListOfMovies(listOfMoviesView: listOfMoviesView)
        return listOfMoviesView
    }
}
