//
//  Movie+CoreDataProperties.swift
//  
//
//  Created by Anita Stashevskaya on 22.03.2024.
//
//

import Foundation
import CoreData


extension Movie {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Movie> {
        return NSFetchRequest<Movie>(entityName: "Movie")
    }

    @NSManaged public var title: String?
    @NSManaged public var movieImage: Data?
    @NSManaged public var movieDescription: String?

}
