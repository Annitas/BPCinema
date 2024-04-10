//
//  APIService.swift
//  BPCinema
//
//  Created by Anita Stashevskaya on 27.03.2024.
//

import Foundation

enum NetworkService {
    static let baseURL = URL(string: "https://api.themoviedb.org/3/")
    
    case getMovies
    case getFavourites
    case getMovieDetails(id: String)
    case addMovieToFavourites(movieId: String)
}

extension NetworkService {
    var path: String {
        switch self {
        case .getMovies:
            return "movie/popular"
        case .getFavourites:
            return "account/21098921/favorite/movies"
        case .getMovieDetails(let id):
            return "movie/\(id)"
        case .addMovieToFavourites:
            return "account/21098921/favorite"
        }
    }
    
    var method: String {
        switch self {
        case .getMovies, .getFavourites, .getMovieDetails:
            return NetworkUtils.GET
        case .addMovieToFavourites:
            return NetworkUtils.POST
        }
    }
    
    var queryItems: [URLQueryItem]? {
        switch self {
        case .getMovies:
            return [
                URLQueryItem(name: "api_key", value: "fae05adc59b94dcb33377a38bfd09528"),
                URLQueryItem(name: "page", value: "1")
            ]
        case .getFavourites:
            return [
                URLQueryItem(name: "language", value: "en-US"),
                    URLQueryItem(name: "page", value: "1"),
                    URLQueryItem(name: "sort_by", value: "created_at.asc")
            ]
        case .getMovieDetails, .addMovieToFavourites:
            return [
                URLQueryItem(name: "api_key", value: "fae05adc59b94dcb33377a38bfd09528")
            ]
        }
        
    }
    var body: Data? {
        switch self {
        case .addMovieToFavourites(let movieId):
            let parameters: [String: Any] = [
                "media_type": "movie",
                "media_id": movieId,
                "favorite": true
            ]
            return try? JSONSerialization.data(withJSONObject: parameters)
        default:
            return nil
        }
    }
    
    var headers: [String: String]? {
        var headers: [String: String] = [:]
        headers["accept"] = "application/json"
        
        switch self {
            case .getFavourites:
             headers["accept"] = "application/json"
             headers["Authorization"] = "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJmYWUwNWFkYzU5Yjk0ZGNiMzMzNzdhMzhiZmQwOTUyOCIsInN1YiI6IjY1ZjE0NzIyMmZkZWM2MDE4OTIxMzFmNyIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.NqkryGcwJ1BvUn_id9-DGJgpL_wm2stm4FTC4p5cEVQ"
        case .addMovieToFavourites:
            headers["accept"] = "application/json"
            headers["content-type"] = "application/json"
            headers["Authorization"] = "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJmYWUwNWFkYzU5Yjk0ZGNiMzMzNzdhMzhiZmQwOTUyOCIsInN1YiI6IjY1ZjE0NzIyMmZkZWM2MDE4OTIxMzFmNyIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.NqkryGcwJ1BvUn_id9-DGJgpL_wm2stm4FTC4p5cEVQ"
        default:
            return nil
        }
        return headers
    }
    
    var parameters: [String: Any] {
        var parameters: [String: Any] = [:]
        
        switch self {
        case .addMovieToFavourites(let movieId):
            parameters["media_type"] = "movie"
            parameters["media_id"] = movieId
            parameters["favorite"] = "true"
        default:
            break
        }
        
        return parameters
    }
    
    static func request<T: Decodable>(type: NetworkService, responseType: T.Type) async throws -> T {
        let urlRequest = buildRequest(type: type)
        
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        
        try NetworkUtils.ensureStatusCodeIs200(response: response)
        let decoder = JSONDecoder()
        
        if case .getMovieDetails = type {
            decoder.keyDecodingStrategy = .convertFromSnakeCase
        } else {
            decoder.dateDecodingStrategy = .iso8601
        }
        print("TYPE REQUEST \(type)")
        
        do {
            return try decoder.decode(T.self, from: data)
        } catch {
            throw NetworkError.decodingError
        }
    }
    
    private static func buildRequest(type: NetworkService) -> URLRequest {
        guard let baseURL = baseURL else {
            fatalError("Failed to retrieve baseURL")
        }
        
        var components = URLComponents(url: baseURL.appendingPathComponent(type.path), resolvingAgainstBaseURL: true)
        components?.queryItems = type.queryItems
        
        guard let url = components?.url else {
            fatalError("Failed to build URL")
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = type.method
        
        if let headers = type.headers {
            for (key, value) in headers {
                urlRequest.addValue(value, forHTTPHeaderField: key)
            }
        }
        
        if let body = type.body {
            urlRequest.httpBody = body
        }
        
        return urlRequest
    }
}
