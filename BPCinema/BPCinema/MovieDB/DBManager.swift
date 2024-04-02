//
//  DBManager.swift
//  BPCinema
//
//  Created by Anita Stashevskaya on 23.03.2024.
//

import RealmSwift
import Foundation

final class DBManager {
    public static let shared: DBManager = DBManager()
    
    let realm = try! Realm()
    lazy var categories: Results<DBMovieModel> = { self.realm.objects(DBMovieModel.self) }()
    var dbMovie = DBMovieModel()
    
    func addToDB(movie: DetailMovieEntity) {
        try! realm.write() {
            self.dbMovie.title = movie.title
            self.dbMovie.overView = movie.overview
            print("SAAAVING")
            let imageData = try Data(contentsOf: URL(string: "https://image.tmdb.org/t/p/w300" + movie.backdropPath)!)
            dbMovie.image = imageData
            realm.add(dbMovie)
            fetchMoviesFromRealm()
        }
        
    }
    
    func fetchMoviesFromRealm() {
        do {
            print("GET DATAAAAA")
            let realm = try Realm()
            let movies = realm.objects(DBMovieModel.self)
            
            for movie in movies {
                print("Title: \(movie.title)")
                print("Overview: \(movie.overView)")
                print("Image \(movie.image)")
            }
        } catch {
            print("Ошибка при доступе к базе данных Realm: \(error)")
        }
    }
}
