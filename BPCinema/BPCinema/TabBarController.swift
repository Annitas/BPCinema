//
//  TabBarController.swift
//  BPCinema
//
//  Created by Anita Stashevskaya on 01.04.2024.
//
import UIKit

final class TabViewController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .gray
        setUpTabs()
    }
    
    private func setUpTabs() {
        let firstViewController = ListOfMoviesRouter().listOfMoviesView!
        let secondViewController = ListOfFavouriteMoviesRouter().listOfFavouriteMoviesView!
        setViewControllers(
            [firstViewController, secondViewController],
            animated: true
        )
    }

}
