//
//  ListOfMoviesRouter.swift
//  BPCinema
//
//  Created by Anita Stashevskaya on 18.03.2024.
//

import Foundation
import UIKit
final class MovieListRouter: Router<ListOfMoviesViewController>, MovieListRouter.Routes {
    var openMovieDetailsTransition: Transition = PushTransition()
    typealias Routes = MovieDetailsRoute
}

protocol MovieListRoute {
    var openMovieListTransition: Transition { get }
    func openMovieList()
}
extension MovieListRoute where Self: RouterProtocol {
    func openMovieList() {
        let router = MovieListRouter()
        let viewController = ListOfMoviesFactory.assembledScreen(router)
        openWithNextRouter(viewController, nextRouter: router, transition: openMovieListTransition)
    }
}
