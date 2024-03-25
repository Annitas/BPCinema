//
//  Movie+CoreDataClass.swift
//  
//
//  Created by Anita Stashevskaya on 22.03.2024.
//
//

import Foundation
import CoreData

@objc(Movie)
public class Movie: NSManagedObject {
    public var title: String?
    public var movieImage: Data?
    public var movieDescription: String?
}
