//
//  ListOfFavouriteMoviesRouter.swift
//  BPCinema
//
//  Created by Anita Stashevskaya on 29.03.2024.
//

import Foundation
import UIKit

protocol ListOfFavouriteMoviesRouting: AnyObject {
    var listOfFavouriteMoviesView: ListOfFavouriteMoviesViewController? { get }
    var detailRouter: DetailRouting? { get }
    
    func showListOfFavouriteMovies(window: UIWindow?)
    func showDetailMovie(withMovieID movieID: String)
}

final class ListOfFavouriteMoviesRouter: ListOfFavouriteMoviesRouting {
    var listOfFavouriteMoviesView: ListOfFavouriteMoviesViewController?
    var detailRouter: DetailRouting?
    
    func showListOfFavouriteMovies(window: UIWindow?) {
        self.detailRouter = DetailRouter()
        let interactor = ListOfFavouriteMoviesInteractor()
        let presenter = ListOfFavouriteMoviesPresenter(listOfFavouriteMoviesInteractor: interactor,
                                              router: self)
        listOfFavouriteMoviesView = ListOfFavouriteMoviesViewController(presenter: presenter)
        presenter.ui = listOfFavouriteMoviesView as? any ListOfFavouriteMoviesUI
        window?.rootViewController = listOfFavouriteMoviesView
        window?.makeKeyAndVisible()
    }
    
    func showDetailMovie(withMovieID movieID: String) {
        guard let fromViewController = listOfFavouriteMoviesView else {
            return
        }
        detailRouter?.showDetails(fromViewController: fromViewController, withMovieID: movieID)
    }
}
