//
//  User.swift
//  WellNest
//
//  Created by Joshua Truong on 11/8/23.
//

import Foundation

struct User: Identifiable, Codable {
    var id: String = ""
    var fullname: String = ""
    var email: String = ""
    var requests: [String] = []
    var friends: [String] = []
}

extension User {
    func toJson() -> [String : Any] {
        do {
            let userData = try JSONEncoder().encode(self)
            return try JSONSerialization.jsonObject(with: userData) as? [String: Any] ?? [:]
        } catch { print("[DEBUG] \(error.localizedDescription)") }
        return [:]
    }
}
