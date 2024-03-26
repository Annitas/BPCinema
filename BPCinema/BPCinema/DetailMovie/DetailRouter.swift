//
//  DetailRouter.swift
//  BPCinema
//
//  Created by Anita Stashevskaya on 19.03.2024.
//

import Foundation
import UIKit

protocol DetailRouting {
    func showDetails(fromViewController: UIViewController, withMovieID movieID: String)
}

final class DetailRouter: DetailRouting {
    func showDetails(fromViewController: UIViewController, withMovieID movieID: String) {
        let interactor = DetailMovieInteractor()
        let presenter = DetailPresenter(movieID: movieID,
                                        interactor: interactor,
                                        mapper: MapperDetailMovieViewModel())
        let view = DetailMovieView(presenter: presenter)
        presenter.ui = view
        fromViewController.present(view, animated: true)
    }
}
