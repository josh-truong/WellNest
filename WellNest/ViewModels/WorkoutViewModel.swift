//
//  WorkoutViewModel.swift
//  WellNest
//
//  Created by Joshua Truong on 9/21/23.
//

import Foundation

class WorkoutViewModel: ObservableObject {
    @Published var exerciseData: [WGERExerciseSuggestion] = []
    
    func searchExercises(term: String) async {
        do {
            let url = URL(string: WgerEndpoints.getExerciseSearch(term: term))!
            let data = try await APIService().makeWgerGETRequest(url: url)
            
            let decodedData = try JSONDecoder().decode(WgerExerciseDataModel.self, from: data)
            exerciseData = decodedData.suggestions
        } catch {
            print("Error: \(error.localizedDescription)")
        }
    }
}
