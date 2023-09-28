//
//  WgerExerciseData.swift
//  WellNest
//
//  Created by Joshua Truong on 9/22/23.
//

import Foundation

class WgerExerciseData {
    private let decoder: JSONDecoder = JSONDecoder()
    
    func getWgerExerciseDetail() -> WgerExerciseDetail {
        let jsonData = """
        {
            "id": 210,
            "base_id": 537,
            "name": "Incline Bench Press - Dumbbell",
            "category": "Chest",
            "image": "/media/exercise-images/16/Incline-press-1.png",
            "image_thumbnail": "/media/exercise-images/16/Incline-press-1.png.30x30_q85_crop-smart.png"
        }
        """.data(using: .utf8)!
        do {
            return try decoder.decode(WgerExerciseDetail.self, from: jsonData)
        } catch {
            return WgerExerciseDetail()
        }
    }
}
