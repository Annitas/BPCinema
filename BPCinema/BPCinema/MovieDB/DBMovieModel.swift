//
//  DBMovieModel.swift
//  BPCinema
//
//  Created by Anita Stashevskaya on 01.04.2024.
//

import Foundation
import RealmSwift

class DBMovieModel: Object {
  @objc dynamic var title = ""
  @objc dynamic var overView: String = ""
  @objc dynamic var image = Data()
}
