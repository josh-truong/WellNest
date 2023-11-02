//
//  FirebaseManager.swift
//  WellNest
//
//  Created by Joshua Truong on 11/1/23.
//

import Foundation
import FirebaseCore
import FirebaseFirestore
import FirebaseDatabase

class FirebaseManager : ObservableObject {
    var ref: DatabaseReference!
    
    init() {
        ref = Database.database().reference()
        self.ref.setValue(["counter": 1])
    }
}
