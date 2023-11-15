//
//  WgerEndpoints.swift
//  WellNest
//
//  Created by Joshua Truong on 9/21/23.
//

import Foundation

struct WgerEndpoint {
    let url: URL
}

enum WgerEndpoints {
    static let scheme = "https"
    static let host = "wger.de"
    static let version = "/api/v2/"

    static func getExerciseSearchEndpoint(term: String) async throws -> WgerEndpoint {
        var components = URLComponents()
        components.scheme = scheme
        components.host = host
        components.path = "\(version)exercise/search/"
        components.queryItems = [
            URLQueryItem(name: "language", value: "en"),
            URLQueryItem(name: "term", value: term)
        ]
        
        guard let url = components.url else {
            throw NetworkError.badURL
        }
        
        return WgerEndpoint(url: url)
    }
    
    static func getExerciseBaseEndpoint(baseId: Int) async throws -> WgerEndpoint {
        var components = URLComponents()
        components.scheme = scheme
        components.host = host
        components.path = "\(version)exercise-base/\(baseId)"

        guard let url = components.url else {
            throw NetworkError.badURL
        }
        
        return WgerEndpoint(url: url)
    }
    
    static func getIngredientsEndpoint() async throws -> WgerEndpoint {
        var components = URLComponents()
        components.scheme = scheme
        components.host = host
        components.path = "\(version)ingredient/"
        
        guard let url = components.url else {
            throw NetworkError.badURL
        }
        
        return WgerEndpoint(url: url)
    }
    
    static func getIngredientSearchEndpoint(term: String) async throws -> WgerEndpoint {
        var components = URLComponents()
        components.scheme = scheme
        components.host = host
        components.path = "\(version)ingredient/search/"
        components.queryItems = [
            URLQueryItem(name: "language", value: "en"),
            URLQueryItem(name: "term", value: term)
        ]
        
        guard let url = components.url else {
            throw NetworkError.badURL
        }

        return WgerEndpoint(url: url)
    }
}
