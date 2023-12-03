//
//  WorkoutViewModel.swift
//  WellNest
//
//  Created by Joshua Truong on 9/21/23.
//
import Foundation

class ExerciseViewModel: ObservableObject {
    @Published var exerciseDictionary: [String: WgerExerciseCategory]? = nil
    private let apiService: APIService = .shared
    
    @MainActor
    func searchExercises(term: String) async {
        do {
            print("Requesting - \(term)")
            let endpoint = try await WgerEndpoints.shared.searchExercises(term: term)
            apiService.makeWgerGETRequest(endpoint: endpoint, responseType: WgerExerciseSearchResponse.self) { [weak self] result in
                guard let self = self else { return }
                DispatchQueue.main.async {
                    switch result {
                    case .success(let data):
                        self.exerciseDictionary = self.groupExerciseDataDetailsByCategory(exercises: data.suggestions)
                    case .failure(let error):
                        self.exerciseDictionary = [:]
                        print("Error: \(error.localizedDescription)")
                    }
                }
            }
            print("Finished - \(term)")
        } catch {
            print("Error: \(error.localizedDescription)")
        }
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
