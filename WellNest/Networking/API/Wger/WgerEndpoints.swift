//
//  WgerEndpoints.swift
//  WellNest
//
//  Created by Joshua Truong on 9/21/23.
//

import Foundation

enum WgerEndpoints {
    static let baseURL = "https://wger.de"
    static let apiV2 = "/api/v2"
    static func getExerciseSearch(term: String) -> String {
        let encodedTerm = term.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? ""
        return "\(baseURL)\(apiV2)/exercise/search/?language=en&term=\(encodedTerm)"
    }
}
