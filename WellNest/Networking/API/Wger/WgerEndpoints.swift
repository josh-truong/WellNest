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

class WgerEndpoints {
    static let shared = WgerEndpoints()
    let scheme = "https"
    let host = "wger.de"
    let version = "/api/v2/"
    
    private init() {}

    func searchExercises(term: String) async throws -> WgerEndpoint {
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
    
    func searchExerciseBase(baseId: Int) async throws -> WgerEndpoint {
        var components = URLComponents()
        components.scheme = scheme
        components.host = host
        components.path = "\(version)exercise-base/\(baseId)"

        guard let url = components.url else {
            throw NetworkError.badURL
        }
        
        return WgerEndpoint(url: url)
    }
    
    func getIngredients() async throws -> WgerEndpoint {
        var components = URLComponents()
        components.scheme = scheme
        components.host = host
        components.path = "\(version)ingredient/"
        
        guard let url = components.url else {
            throw NetworkError.badURL
        }
        
        return WgerEndpoint(url: url)
    }
    
    func searchIngredients(term: String) async throws -> WgerEndpoint {
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
