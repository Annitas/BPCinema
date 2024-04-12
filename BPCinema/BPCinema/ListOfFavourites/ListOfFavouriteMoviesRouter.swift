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
    
    func showListOfFavouriteMovies(listOfFavouriteMoviesView: ListOfFavouriteMoviesViewController)
    func showDetailMovie(withMovieID movieID: String)
}

final class ListOfFavouriteMoviesRouter: ListOfFavouriteMoviesRouting {
    var listOfFavouriteMoviesView: ListOfFavouriteMoviesViewController?
    var detailRouter: DetailRouting?
    
    func showListOfFavouriteMovies(listOfFavouriteMoviesView: ListOfFavouriteMoviesViewController) {
        self.listOfFavouriteMoviesView = listOfFavouriteMoviesView
        self.detailRouter = DetailRouter()
    }
    
    func showDetailMovie(withMovieID movieID: String) {
        guard let fromViewController = listOfFavouriteMoviesView else {
            return
        }
        detailRouter?.showDetails(fromViewController: fromViewController, withMovieID: movieID)
    }
}
