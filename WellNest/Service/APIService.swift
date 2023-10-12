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
    
    func makeWgerGETRequest<T: Decodable>(endpoint: WgerEndpoint, responseType: T.Type) async throws -> T {
        var request = URLRequest(url: endpoint.url)
        
        request.setValue("Token \(Constants.wger_api_key)", forHTTPHeaderField: "Authorization")
        
        let (data, response) = try await URLSession.shared.data(from: request.url!)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw APIError.invalidResponse
        }
        
        let decodedData = try JSONDecoder().decode(T.self, from: data)
        return decodedData;
    }
}


