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
