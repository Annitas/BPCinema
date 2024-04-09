//
//  ListOfMoviesRouter.swift
//  BPCinema
//
//  Created by Anita Stashevskaya on 18.03.2024.
//

import Foundation
import UIKit

protocol ListOfMoviesRouting: AnyObject {
    var detailRouter: DetailRouting? { get }
    var listOfMoviesView: ListOfMoviesViewController? { get }
    
    func showListOfMovies(listOfMoviesView: ListOfMoviesViewController)
    func showDetailMovie(withMovieID movieID: String)
}

final class ListOfMoviesRouter: ListOfMoviesRouting {
    var detailRouter: DetailRouting?
    var listOfMoviesView: ListOfMoviesViewController?
    
    
    func showListOfMovies(listOfMoviesView: ListOfMoviesViewController) {
            self.listOfMoviesView = listOfMoviesView
            self.detailRouter = DetailRouter()
        }
        
        func showDetailMovie(withMovieID movieID: String) {
            guard let fromViewController = listOfMoviesView else {
                return
            }
            detailRouter?.showDetails(fromViewController: fromViewController, withMovieID: movieID)
        }
}
