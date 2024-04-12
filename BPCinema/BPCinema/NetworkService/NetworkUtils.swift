//
//  NetworkUtils.swift
//  BPCinema
//
//  Created by Anita Stashevskaya on 10.04.2024.
//

import Foundation

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
