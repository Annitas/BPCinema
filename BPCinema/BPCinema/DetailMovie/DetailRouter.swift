//
//  DetailRouter.swift
//  BPCinema
//
//  Created by Anita Stashevskaya on 19.03.2024.
//

import Foundation
import UIKit

final class MovieDetailsRouter: Router<DetailMovieViewController>, MovieDetailsRouter.Routes {
    typealias Routes = Any
}

protocol MovieDetailsRoute {
    var openMovieDetailsTransition: Transition { get }
    func openMovieDetails(_ movie: PopularMovieEntity)
}
extension MovieDetailsRoute where Self: RouterProtocol {
    func openMovieDetails(_ movie: PopularMovieEntity) {
        let router = MovieDetailsRouter()
        let movieID = String(movie.id)
        let viewController = MovieDetailsFactory.assembledScreen(router, movieID: movieID)
        openWithNextRouter(viewController, nextRouter: router, transition: openMovieDetailsTransition)
    }
}
