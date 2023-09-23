//
//  WorkoutViewModel.swift
//  WellNest
//
//  Created by Joshua Truong on 9/21/23.
//
import Foundation

class ExerciseViewModel: ObservableObject {
    @Published var exerciseDictionary = [String: WgerExerciseCategory]()
    @Published var searchExerciseTerm: String = "dumbbell"
    
    private let apiService: APIService
    
    init(apiService: APIService) {
        self.apiService = apiService
    }
    
    @MainActor
    func searchExercises() async {
        do {
            print("Requesting - \(searchExerciseTerm)")
            let endpoint = WgerEndpoints.getExerciseSearchEndpoint(term: searchExerciseTerm)
            let data = try await apiService.makeWgerGETRequest(endpoint: endpoint)
            let parsedData = try JSONDecoder().decode(WgerExerciseDataModel.self, from: data)
            exerciseDictionary = groupExerciseDataDetailsByCategory(exercises: parsedData.suggestions)
            print("Finished - \(searchExerciseTerm)")
        } catch {
            print("Error: \(error.localizedDescription)")
        }
    }
    
    private func groupExerciseDataDetailsByCategory(exercises: [WgerExerciseSuggestionModel]) -> [String: WgerExerciseCategory] {
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
