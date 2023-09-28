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
    static let baseURL = "https://wger.de"
    static let apiV2 = "/api/v2"
    static func getExerciseSearchEndpoint(term: String) -> WgerEndpoint {
        let processed = term.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? ""
        let url = parseURL(string: "\(baseURL)\(apiV2)/exercise/search/?language=en&term=\(processed)")
        return WgerEndpoint(url: url)
    }
    
    static func getExerciseBaseEndpoint(baseId: Int) -> WgerEndpoint {
        let url: URL = parseURL(string: "\(baseURL)\(apiV2)/exercise-base/\(baseId)")
        return WgerEndpoint(url: url)
    }
    
    static func getIngredientsEndpoint() -> WgerEndpoint {
        let url: URL = parseURL(string: "\(baseURL)\(apiV2)/ingredient/")
        return WgerEndpoint(url: url)
    }
    
    static func getIngredientSearchEndpoint(term: String) -> WgerEndpoint {
        let processed = term.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? ""
        let url: URL = parseURL(string: "\(baseURL)\(apiV2)/ingredient/search/?language=en&term=\(processed)")
        return WgerEndpoint(url: url)
    }
    
    private static func parseURL(string: String) -> URL {
        guard let url = URL(string: string) else {
            fatalError("Invalid URL: \(string)")
        }
        return url
    }
}
