//
//  WorkoutViewModel.swift
//  WellNest
//
//  Created by Joshua Truong on 9/21/23.
//
import Foundation

class ExerciseViewModel: ObservableObject {
    @Published var exerciseDictionary: [String: WgerExerciseCategory]? = nil
    
    private let apiService: APIService
    
    init(apiService: APIService) {
        self.apiService = apiService
    }
    
    @MainActor
    func searchExercises(term: String) async {
        do {
            print("Requesting - \(term)")
            let endpoint = WgerEndpoints.getExerciseSearchEndpoint(term: term)
            let data = try await apiService.makeWgerGETRequest(endpoint: endpoint, responseType: WgerExerciseSearchResponse.self)
            exerciseDictionary = groupExerciseDataDetailsByCategory(exercises: data.suggestions)
            print("Finished - \(term)")
        } catch {
            print("Error: \(error.localizedDescription)")
        }
    }
    
    @MainActor
    func reset() {
        
    }
    
    private func groupExerciseDataDetailsByCategory(exercises: [WgerExerciseSuggestion]) -> [String: WgerExerciseCategory] {
        var categories = [String: WgerExerciseCategory]()
        for data in exercises {
            let category = data.data.category
            if !categories.keys.contains(category) {
                categories[category] = WgerExerciseCategory(name: category, exercises: [])
            }
            categories[category]?.exercises.append(data.data)
        }
        return categories
    }
}
