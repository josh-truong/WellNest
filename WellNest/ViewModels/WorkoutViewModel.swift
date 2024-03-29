//
//  WorkoutViewModel.swift
//  WellNest
//
//  Created by Joshua Truong on 9/21/23.
//
import Foundation

class ExerciseViewModel: ObservableObject {
    @Published var exerciseData = [WgerExerciseSuggestion]()
    @Published var exerciseDataByCategory = [String: WgerExerciseCategory]()
    @Published var exerciseBase = [WgerExerciseBaseModel]()
    
    private let apiService: APIService
    
    init(apiService: APIService) {
        self.apiService = apiService
    }
    
    @MainActor
    func searchExercises(term: String) async {
        Task {
            do {
                print("Requesting - \(term)")
                let endpoint = WgerEndpoints.getExerciseSearchEndpoint(term: term)
                let data = try await apiService.makeWgerGETRequest(endpoint: endpoint)
                let decodedData = try JSONDecoder().decode(WgerExerciseDataModel.self, from: data)
                exerciseData = decodedData.suggestions
                print("Finished - \(term)")
            } catch {
                print("Error: \(error.localizedDescription)")
            }
        }
        exerciseDataByCategory = groupExerciseDataDetailsByCategory()
    }
    
    @MainActor
    func getExerciseBase(exercise: WgerExerciseDetail) async {
        Task {
            do {
                print("Requesting - \(exercise.name)")
                let endpoint = WgerEndpoints.getExerciseBaseEndpoint(baseId: exercise.baseId)
                let data = try await apiService.makeWgerGETRequest(endpoint: endpoint)
                let decodedData = try JSONDecoder().decode(WgerExerciseBaseModel.self, from: data)
                exerciseBase = [decodedData]
                print("Finished - \(exercise.name)")
            } catch {
                print("Error: \(error.localizedDescription)")
                print("Details:\n\(error)")
            }
        }
    }
    
    @MainActor
    private func groupExerciseDataDetailsByCategory() -> [String: WgerExerciseCategory] {
        var categories = [String: WgerExerciseCategory]()
        for data in exerciseData {
            let category = data.data.category
            if !categories.keys.contains(category) {
                categories[category] = WgerExerciseCategory(name: category, exercises: [])
            }
            categories[category]?.exercises.append(data.data)
        }
        return categories
    }
}
