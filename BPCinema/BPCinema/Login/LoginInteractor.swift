//
//  AuthInteractor.swift
//  BPCinema
//
//  Created by Anita Stashevskaya on 27.03.2024.
//

import UIKit
import Firebase

protocol LoginInteractable {
    func login(email : String, password : String )
    func isAlreadyLogin()
}

final class LoginInteractor: LoginInteractable {
    func login(email: String, password: String) {
        let auth = Auth.auth()
        auth.signIn(withEmail: email, password: password) { [weak self] authResult, error in
            if error == nil {
                self?.showTabBar()
            } else {
                // Handle login error
            }
        }
    }
    
    func isAlreadyLogin() {
        if Auth.auth().currentUser != nil {
            showTabBar()
        }
    }
    
    private func showTabBar() {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let window = windowScene.windows.first else {
            return
        }
        let tabBarController = UITabBarController()
        
        // MARK: List of popular movies tab
        let listOfMoviesRouter = ListOfMoviesRouter()
        listOfMoviesRouter.showListOfMovies(window: window)
        let listOfMoviesNavController = UINavigationController(rootViewController: listOfMoviesRouter.listOfMoviesView!)
        listOfMoviesNavController.tabBarItem = UITabBarItem(title: "Movies", image: UIImage(systemName: "movieclapper.fill"), tag: 1)
        
        // MARK: List of favourite movies tab
        let listOfFavouriteMoviesRouter = ListOfFavouriteMoviesRouter()
        listOfFavouriteMoviesRouter.showListOfFavouriteMovies(window: window)
        let listOfFavouriteMoviesNavController = UINavigationController(rootViewController: listOfFavouriteMoviesRouter.listOfFavouriteMoviesView!)
        listOfFavouriteMoviesNavController.tabBarItem = UITabBarItem(title: "Favourites", image: UIImage(systemName: "heart.fill"), tag: 2)
        
        tabBarController.viewControllers = [listOfMoviesNavController, listOfFavouriteMoviesNavController] //
        
        window.rootViewController = tabBarController
        window.makeKeyAndVisible()
    }
}


