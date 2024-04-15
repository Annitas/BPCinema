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
        print("ID OF MOVIE \(movieID)")
        let viewController = MovieDetailsFactory.assembledScreen(router, movieID: movieID)
        openWithNextRouter(viewController, nextRouter: router, transition: openMovieDetailsTransition)
    }
}

//
//
//protocol DetailRouting {
//    func showDetails(fromViewController: UIViewController, withMovieID movieID: String)
//}
//
//final class DetailRouter: DetailRouting {
//    func showDetails(fromViewController: UIViewController, withMovieID movieID: String) {
////        let interactor = DetailMovieInteractor()
////        let presenter = DetailPresenter(movieID: movieID,
////                                        interactor: interactor,
////                                        mapper: MapperDetailMovieViewModel())
////        let view = DetailMovieViewController(presenter: presenter)
////        presenter.ui = view
////        fromViewController.present(view, animated: true)
//    }
//}
