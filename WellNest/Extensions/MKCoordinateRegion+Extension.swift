//
//  MKCoordinateRegion+Extension.swift
//  WellNest
//
//  Created by Joshua Truong on 10/10/23.
//

import Foundation
import MapKit

extension MKCoordinateRegion {
    static var userRegion: MKCoordinateRegion {
        return .init(center: .userLocation, latitudinalMeters: 10000, longitudinalMeters: 10000)
    }
}
