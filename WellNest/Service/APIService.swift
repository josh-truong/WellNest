//
//  APIService.swift
//  WellNest
//
//  Created by Joshua Truong on 9/21/23.
//

import Foundation

class APIService {
    static let shared = APIService()
    
    enum APIError: Error {
            case invalidURL
            case requestFailed
            case invalidResponse
            case decodingError
        }
    
    func makeWgerGETRequest(endpoint: WgerEndpoint) async throws -> Data {
        var request = URLRequest(url: endpoint.url)
        
        request.setValue("Token \(Constants.wger_api_key)", forHTTPHeaderField: "Authorization")
        
        let (data, response) = try await URLSession.shared.data(from: request.url!)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw APIError.invalidResponse
        }
        
        return data;
    }
}


