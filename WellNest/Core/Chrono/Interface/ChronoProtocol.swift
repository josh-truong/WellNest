//
//  ChronoProtocol.swift
//  WellNest
//
//  Created by Joshua Truong on 12/15/23.
//

import Foundation
import SwiftUI
import CoreData

protocol ChronoProtocol {
    func setup(_ hour: Int, _ minute: Int, _ second: Int)
    func setupEntity(_ entity: FetchedResults<ActivityEntity>.Element, context: NSManagedObjectContext)
    
    func start()
    func pause()
    func resume()
    func finish()
    func reset()
}
