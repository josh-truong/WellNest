//
//  User.swift
//  WellNest
//
//  Created by Joshua Truong on 11/8/23.
//

import Foundation

struct User: Identifiable, Codable {
    let id: String
    let fullname: String
    let email: String
    var requests: [String]
    var friends: [String]
    
    var initials : String {
        let formatter = PersonNameComponentsFormatter()
        if let components = formatter.personNameComponents(from: fullname) {
            formatter.style = .abbreviated
            return formatter.string(from: components)
        }
        
        return ""
    }
}
