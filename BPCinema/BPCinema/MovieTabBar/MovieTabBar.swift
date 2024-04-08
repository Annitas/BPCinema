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
        
        let listOfMoviesRouter = ListOfMoviesRouter()
        listOfMoviesRouter.showListOfMovies(window: window)
        let listOfMoviesNavController = UINavigationController(rootViewController: listOfMoviesRouter.listOfMoviesView!)
        listOfMoviesNavController.tabBarItem = UITabBarItem(title: "Movies", image: UIImage(systemName: "movieclapper.fill"), tag: 1)
        
        let listOfFavouriteMoviesRouter = ListOfFavouriteMoviesRouter()
        listOfFavouriteMoviesRouter.showListOfFavouriteMovies(window: window)
        let listOfFavouriteMoviesNavController = UINavigationController(rootViewController: listOfFavouriteMoviesRouter.listOfFavouriteMoviesView!)
        listOfFavouriteMoviesNavController.tabBarItem = UITabBarItem(title: "Favourites", image: UIImage(systemName: "heart.fill"), tag: 2)
        
        tabBarController.viewControllers = [listOfMoviesNavController, listOfFavouriteMoviesNavController]
        
        window.rootViewController = tabBarController
        window.makeKeyAndVisible()
    }
}
