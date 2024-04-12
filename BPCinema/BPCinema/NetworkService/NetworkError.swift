//
//  NetworkError.swift
//  BPCinema
//
//  Created by Anita Stashevskaya on 10.04.2024.
//

enum NetworkError: Error {
    case httpError(statusCode: Int)
    case notFound
    case noData
    case decodingError
    case encodingError
    case unauthorized
    case invalidBaseURL
    case invalidURLComponents
    case invalidURL
}
