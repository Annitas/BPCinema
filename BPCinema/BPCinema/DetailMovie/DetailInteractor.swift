//
//  DetailInteractor.swift
//  BPCinema
//
//  Created by Anita Stashevskaya on 19.03.2024.
//

import Foundation

protocol DetailMovieInteractable: AnyObject {
    func getDetailMovie(withID id: String) async -> DetailMovieEntity
    func addToFavorites(movieId: Int, accountId: Int)
}

final class DetailMovieInteractor: DetailMovieInteractable {
    func getDetailMovie(withID id: String) async -> DetailMovieEntity {
        let url = URL(string: "https://api.themoviedb.org/3/movie/\(id)?api_key=fae05adc59b94dcb33377a38bfd09528")!
        let (data, _) = try! await URLSession.shared.data(from: url)
        let jsonDecoder = JSONDecoder()
        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
        return try! jsonDecoder.decode(DetailMovieEntity.self, from: data)
    }
    
    func addToFavorites(movieId: Int, accountId: Int) {
        let urlString = "https://api.themoviedb.org/3/account/\(accountId)/favorite?api_key=fae05adc59b94dcb33377a38bfd09528"
        
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            return
        }
        
        let parameters = [
            "media_type": "movie",
            "media_id": "\(movieId)",
            "favorite": "true"
        ]
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = try? JSONSerialization.data(withJSONObject: parameters)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error: \(error)")
                return
            }
            if let data = data {
                if let httpResponse = response as? HTTPURLResponse {
                    if httpResponse.statusCode == 200 {
                        // MARK: return status to change button's color?
                        print("Movie added to favorites successfully")
                    } else {
                        print("Failed to add movie to favorites. Status code: \(httpResponse.statusCode)")
                    }
                }
            }
        }
        task.resume()
    }
}




// Add NetworkService
// redo login/register to screen architecture with presenters and interactors, router
// refactor duplicated code
// Constraint -> PinLayout
//
