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
    func validate(p1: String, p2: String) -> Bool
}

final class LoginInteractor: LoginInteractable {
    func login(email: String, password: String) {
        let auth = Auth.auth()
        auth.signIn(withEmail: email, password: password) { [weak self] authResult, error in
            if error == nil && ((self?.validate(p1: email, p2: password)) != nil) {
                self?.showTabBar()
            } else {
                print("FAILED TO LOG IN")
                // Handle login error
            }
        }
    }
    
    func isAlreadyLogin() {
//        if Auth.auth().currentUser != nil {
//            showTabBar()
//        }
    }
    
     /* почему не так
     func validaten(p1: String, p2: String) -> Bool {
        p1.isValidEmailRequirements && p2.isValidEmailRequirements
     }
      */
    
    
    func validate(p1: String, p2: String) -> Bool {
        return (dataValid(p1: p1, p2: p2))
    }
    
    private func dataValid(p1: String, p2: String) -> Bool {
        return p1.isValidEmailRequirements && p2.isValidPasswordRequirements
    }
    
    
    // TODO: Make this shit normal
    
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

extension String {
    var isValidEmailRequirements: Bool {
        let email = self
        let emailRegx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailCheck = NSPredicate(format: "SELF MATCHES %@", emailRegx)
        let val = emailCheck.evaluate(with: email)
        return val
    }
    var isValidPasswordRequirements: Bool {
        let password = self
        let passwordRegx = "^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.*[@$!#%*?&]).{8,}$"
        let passwordCheck = NSPredicate(format: "SELF MATCHES %@", passwordRegx)
        let val = passwordCheck.evaluate(with: password)
        return val
    }
}
