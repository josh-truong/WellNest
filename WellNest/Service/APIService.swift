//
//  APIService.swift
//  WellNest
//
//  Created by Joshua Truong on 9/21/23.
//

import Foundation

class APIService {
    static let shared = APIService()
    private init() {}

    private var debounceTimer: Timer?

    func makeWgerGETRequest<T: Decodable>(endpoint: WgerEndpoint, responseType: T.Type, debounceInterval: TimeInterval = 0.5, completion: @escaping (Result<T, Error>) -> Void) {
        // Invalidate the previous timer, if any
        debounceTimer?.invalidate()

        // Create a new timer
        debounceTimer = Timer.scheduledTimer(withTimeInterval: debounceInterval, repeats: false) { [weak self] _ in
            // Perform the API request after the debounce interval
            self?.performRequest(endpoint: endpoint, responseType: responseType, completion: completion)
        }
    }

    private func performRequest<T: Decodable>(endpoint: WgerEndpoint, responseType: T.Type, completion: @escaping (Result<T, Error>) -> Void) {
        var request = URLRequest(url: endpoint.url)
        request.setValue("Token \(Constants.wger_api_key)", forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                completion(.failure(NetworkError.badID))
                return
            }
            
            do {
                if let data = data {
                    let decodedData = try JSONDecoder().decode(T.self, from: data)
                    completion(.success(decodedData))
                } else {
                    completion(.failure(NetworkError.badData))
                }
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
