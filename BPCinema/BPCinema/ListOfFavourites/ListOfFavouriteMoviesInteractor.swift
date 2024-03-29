//
//  ListOfFavouriteMoviesInteractor.swift
//  BPCinema
//
//  Created by Anita Stashevskaya on 29.03.2024.
//

import Foundation

protocol ListOfFavouriteMoviesInteractable: AnyObject {
    func getFavouriteMovies() // async -> PopularMovieResponseEntity
}

final class ListOfFavouriteMoviesInteractor: ListOfFavouriteMoviesInteractable  {
    func getFavouriteMovies() { //  async -> FavouriteMovieResponseEntity
        let headers = [
          "accept": "application/json",
          "Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJmYWUwNWFkYzU5Yjk0ZGNiMzMzNzdhMzhiZmQwOTUyOCIsInN1YiI6IjY1ZjE0NzIyMmZkZWM2MDE4OTIxMzFmNyIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.NqkryGcwJ1BvUn_id9-DGJgpL_wm2stm4FTC4p5cEVQ"
        ]

        let request = NSMutableURLRequest(url: NSURL(string: "https://api.themoviedb.org/3/account/21098921/favorite/movies?language=en-US&page=1&sort_by=created_at.asc")! as URL,
                                                cachePolicy: .useProtocolCachePolicy,
                                            timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers

        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
          if (error != nil) {
            print(error as Any)
          } else {
            let httpResponse = response as? HTTPURLResponse
            print(httpResponse ?? "")
          }
        })

        dataTask.resume()
    }
}
