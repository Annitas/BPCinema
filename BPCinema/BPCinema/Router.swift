//
//  Router.swift
//  BPCinema
//
//  Created by Anita Stashevskaya on 12.04.2024.
//

import Foundation
import UIKit

public protocol Closable: AnyObject {
    func close(_ animated: Bool)
}

public protocol RouterProtocol: AnyObject {
    associatedtype ViewController: UIViewController
    var viewController: ViewController? { get }
    
    func open(_ viewController: UIViewController, transition: Transition)
    func openWithNextRouter<U: UIViewController>(_ viewController: UIViewController, nextRouter: Router<U>, transition: Transition)
    func close(_ animated: Bool)
}


