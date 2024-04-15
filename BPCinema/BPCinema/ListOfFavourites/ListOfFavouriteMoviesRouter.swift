//
//  ListOfFavouriteMoviesRouter.swift
//  BPCinema
//
//  Created by Anita Stashevskaya on 29.03.2024.
//

import Foundation
import UIKit

//protocol ListOfFavouriteMoviesRouting: AnyObject {
//    var listOfFavouriteMoviesView: ListOfFavouriteMoviesViewController? { get }
//    var detailRouter: DetailRouting? { get }
//    
//    func showListOfFavouriteMovies(listOfFavouriteMoviesView: ListOfFavouriteMoviesViewController)
//    func showDetailMovie(withMovieID movieID: String)
//}

final class ListOfFavouriteMoviesRouter: Router<ListOfFavouriteMoviesViewController>, ListOfFavouriteMoviesRouter.Routes {
    var openMovieDetailsTransition: Transition = PushTransition()
    typealias Routes = MovieDetailsRoute
}

protocol FavouritesListRoute {
    var openFavouritesListTransition: Transition { get }
    func openFavouritesList()
}

extension FavouritesListRoute where Self: RouterProtocol {
    func openFavouritesList() {
        let router = ListOfFavouriteMoviesRouter()
        let viewController = ListOfFavouriteMoviesFactory.assembledScreen(router)
        openWithNextRouter(viewController, nextRouter: router, transition: openFavouritesListTransition)
    }
}
