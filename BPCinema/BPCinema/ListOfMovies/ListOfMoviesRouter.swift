//
//  ListOfMoviesRouter.swift
//  BPCinema
//
//  Created by Anita Stashevskaya on 18.03.2024.
//

import Foundation
import UIKit

protocol ListOfMoviesRouting: AnyObject {
    var detailRouter: DetailRouting? { get set } // remove set
    var listOfMoviesView: ListOfMoviesViewController? { get }
    
    func showListOfMovies(window: UIWindow?)
    func showDetailMovie(withMovieID movieID: String)
}

final class ListOfMoviesRouter: ListOfMoviesRouting {
    var detailRouter: DetailRouting?
    var listOfMoviesView: ListOfMoviesViewController?
    
    func showListOfMovies(window: UIWindow?) {
        self.detailRouter = DetailRouter()
        let interactor = ListOfMoviesInteractor()
        let presenter = ListOfMoviesPresenter(listOfMoviesInteractor: interactor, 
                                              router: self)
        listOfMoviesView = ListOfMoviesViewController(presenter: presenter)
        presenter.ui = listOfMoviesView
//        window?.rootViewController = listOfMoviesView
        window?.makeKeyAndVisible()
    }
    
    func showDetailMovie(withMovieID movieID: String) {
        guard let fromViewController = listOfMoviesView else {
            return
        }
        detailRouter?.showDetails(fromViewController: fromViewController, withMovieID: movieID)
    }
}
