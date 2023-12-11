//
//  String.swift
//  WellNest
//
//  Created by Joshua Truong on 11/15/23.
//

import Foundation
import SwiftSoup

extension String {
    func trimmed() -> String {
        self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    var htmlAttributedString: String {
        do {
            let doc: Document = try SwiftSoup.parse(self)
            return try doc.text()
        } catch {
            print("Error converting HTML to attributed string: \(error)")
            return self
        }
    }
}
