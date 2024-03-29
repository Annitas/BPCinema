//
//  APIService.swift
//  BPCinema
//
//  Created by Anita Stashevskaya on 27.03.2024.
//

import Foundation

final class APIService {
    static let shared = APIService()
    // MARK: List of movies
    func getListOfMoview() async -> PopularMovieResponseEntity {
        let url = URL(string: "https://api.themoviedb.org/3/movie/popular?api_key=fae05adc59b94dcb33377a38bfd09528&page=1")!
        let (data, _) = try! await URLSession.shared.data(from: url)
        return try! JSONDecoder().decode(PopularMovieResponseEntity.self, from: data)
    }
    
    // MARK: Detail Movies
    func getDetailMovie(withID id: String) async -> DetailMovieEntity {
        let url = URL(string: "https://api.themoviedb.org/3/movie/\(id)?api_key=fae05adc59b94dcb33377a38bfd09528")!
        let (data, _) = try! await URLSession.shared.data(from: url)
        let jsonDecoder = JSONDecoder()
        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
        return try! jsonDecoder.decode(DetailMovieEntity.self, from: data)
    }
    
    func addToFavorites(movieId: String, accountId: String) {
        let urlString = "https://api.themoviedb.org/3/account/\(accountId)/favorite?api_key=fae05adc59b94dcb33377a38bfd09528"
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            return
        }
        let headers = [
          "accept": "application/json",
          "content-type": "application/json",
          "Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJmYWUwNWFkYzU5Yjk0ZGNiMzMzNzdhMzhiZmQwOTUyOCIsInN1YiI6IjY1ZjE0NzIyMmZkZWM2MDE4OTIxMzFmNyIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.NqkryGcwJ1BvUn_id9-DGJgpL_wm2stm4FTC4p5cEVQ"
        ]
        let parameters = [
          "media_type": "movie",
          "media_id": movieId,
          "favorite": "true"
        ] as [String : Any]
        
        let postData = try! JSONSerialization.data(withJSONObject: parameters, options: []) // TODO: Fix force unwrap

        let request = NSMutableURLRequest(url: NSURL(string: "https://api.themoviedb.org/3/account/\(accountId)/favorite")! as URL,
                                                cachePolicy: .useProtocolCachePolicy,
                                            timeoutInterval: 10.0)
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = headers
        request.httpBody = postData as Data
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
