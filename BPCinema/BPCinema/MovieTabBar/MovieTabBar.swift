//
//  MovieTabBar.swift
//  BPCinema
//
//  Created by Anita Stashevskaya on 08.04.2024.
//

import Foundation
import UIKit

final class TabBarCoordinator {
    func showTabBar(withWindow window: UIWindow) {
        let tabBarController = UITabBarController()
        
        let listOfMoviesRouter = MovieListRouter()
        let listOfMoviesVC = ListOfMoviesFactory.assembledScreen(listOfMoviesRouter)
        let listOfMoviesNavController = UINavigationController(rootViewController: listOfMoviesVC)
        listOfMoviesNavController.tabBarItem = UITabBarItem(title: "Movies", image: UIImage(systemName: "movieclapper.fill"), tag: 1)
        
        let listOfFavouriteMoviesRouter = ListOfFavouriteMoviesRouter()
        let listOfFavouriteMoviesVC = ListOfFavouriteMoviesFactory.assembledScreen(withRouter: listOfFavouriteMoviesRouter)
        let listOfFavouriteMoviesNavController = UINavigationController(rootViewController: listOfFavouriteMoviesVC)
        listOfFavouriteMoviesNavController.tabBarItem = UITabBarItem(title: "Favourites", image: UIImage(systemName: "heart.fill"), tag: 2)
        
        tabBarController.viewControllers = [listOfMoviesNavController, listOfFavouriteMoviesNavController]
        
        window.rootViewController = tabBarController
        window.makeKeyAndVisible()
    }
}
