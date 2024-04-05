//
//  APIService.swift
//  BPCinema
//
//  Created by Anita Stashevskaya on 27.03.2024.
//

import Foundation

enum NetworkError: Error {
    case httpError(statusCode: Int)
    case notFound
    case noData
    case decodingError
    case encodingError
    case unauthorized
}

class NetworkUtils {
    static let GET: String = "GET"
    static let POST: String = "POST"
    
    static func ensureStatusCodeIs200(response: URLResponse) throws {
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.httpError(statusCode: -1)
        }
        print("network request \(response.url!.absoluteString) status code \((response as? HTTPURLResponse)!.statusCode)")
        guard (200...299).contains(httpResponse.statusCode) else {
            if httpResponse.statusCode == 404 {
                throw NetworkError.notFound
            } else if httpResponse.statusCode == 401 {
                throw NetworkError.unauthorized
            } else {
                throw NetworkError.httpError(statusCode: httpResponse.statusCode)
            }
        }
    }
}

enum NetworkService {
    static let baseURL = URL(string: "https://api.themoviedb.org/3/")
    
    case getListOfMovies
    case getMovieDetails(movieID: String)
    case addToFavourites(accountID: String)
    case getFavouriteMovies
}

extension NetworkService {
    var path: String {
        switch self {
        case .getListOfMovies:
                return "movie/popular?api_key=fae05adc59b94dcb33377a38bfd09528&page=1"
        case .getMovieDetails(let movieID):
                return "movie/\(movieID)?api_key=fae05adc59b94dcb33377a38bfd09528"
        case .addToFavourites(let accountID):
                return "account/\(accountID)/favorite?api_key=fae05adc59b94dcb33377a38bfd09528"
        case .getFavouriteMovies:
                return "account/21098921/favorite/movies?language=en-US&page=1&sort_by=created_at.asc"
        }
    }
    
    var method: String {
        switch self {
        case .getListOfMovies, .getMovieDetails, .getFavouriteMovies:
            return NetworkUtils.GET
        case .addToFavourites:
            return NetworkUtils.POST
        }
    }
    
    var headers: [String: String]? {
        switch self {
        case .addToFavourites:
            return ["content-type": "application/json"]
        default:
            return nil
        }
    }
}

extension NetworkService {
    static func request<T: Decodable> (type: NetworkService, responseType: T.Type) async throws -> T {
        let urlRequest = buildRequest(type: type)

        let (data, response) = try await URLSession.shared.data(for: urlRequest)

        try NetworkUtils.ensureStatusCodeIs200(response: response)
        let json = try? JSONSerialization.jsonObject(with: data)
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601

        do {
            return try decoder.decode(T.self, from: data)
        } catch {
            throw NetworkError.decodingError
        }
    }
    
    static func request(type: NetworkService) async throws {
        let urlRequest = buildRequest(type: type)

        let (_, response) = try await URLSession.shared.data(for: urlRequest)

        try NetworkUtils.ensureStatusCodeIs200(response: response)
    }
    
    private static func buildRequest(type: NetworkService) -> URLRequest {
        guard let resourceURL = baseURL?.appendingPathComponent(type.path) else {
            fatalError("Failed to convert baseURL to a URL")
        }

        var urlRequest = URLRequest(url: resourceURL)
        urlRequest.httpMethod = type.method

        if let headers = type.headers {
            for (key, value) in headers {
                urlRequest.addValue(value, forHTTPHeaderField: key)
            }
        }
        print(urlRequest)
        return urlRequest
    }
}


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
    
    // MARK: Favourites
    
    func addToFavorites(movieId: String, accountId: String) async {
        do {
            let detailMovie = await getDetailMovie(withID: movieId)
            DBManager.shared.addToDB(movie: detailMovie)
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
            let postData = try! JSONSerialization.data(withJSONObject: parameters, options: [])
            
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.allHTTPHeaderFields = headers
            request.httpBody = postData as Data
            let session = URLSession.shared
            let dataTask = session.dataTask(with: request, completionHandler: { (data, response, error) -> Void in
                if let error = error {
                    print(error)
                } else if let httpResponse = response as? HTTPURLResponse {
                    print(httpResponse)
                }
            })
            dataTask.resume()
        } catch {
            print("Error: \(error)")
        }
    }



    func getFavouriteMovies() async -> PopularMovieResponseEntity {
        let headers = [
            "accept": "application/json",
            "Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJmYWUwNWFkYzU5Yjk0ZGNiMzMzNzdhMzhiZmQwOTUyOCIsInN1YiI6IjY1ZjE0NzIyMmZkZWM2MDE4OTIxMzFmNyIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.NqkryGcwJ1BvUn_id9-DGJgpL_wm2stm4FTC4p5cEVQ"
        ]

        let url = URL(string: "https://api.themoviedb.org/3/account/21098921/favorite/movies?language=en-US&page=1&sort_by=created_at.asc")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        let (data, response) = try! await URLSession.shared.data(for: request)
        let heroes = try! JSONDecoder().decode(PopularMovieResponseEntity.self, from: data)
//        for hero in heroes.results {
//            print("Hero... \(hero)")
//        }
//        print(data)
//        guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
//            throw NSError(domain: "HTTPError", code: (response as? HTTPURLResponse)?.statusCode ?? 500, userInfo: nil)
//        }

        return try! JSONDecoder().decode(PopularMovieResponseEntity.self, from: data)
    }

}
