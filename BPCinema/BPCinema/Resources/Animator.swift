//
//  Animator.swift
//  BPCinema
//
//  Created by Anita Stashevskaya on 12.04.2024.
//

import UIKit

public protocol Animator: UIViewControllerAnimatedTransitioning {
    var isPresenting: Bool { get set }
}
