//
//  WorkoutViewModel.swift
//  WellNest
//
//  Created by Joshua Truong on 9/21/23.
//
import Foundation

class WorkoutViewModel: ObservableObject {
    @Published var exerciseData = [WgerExerciseSuggestion]()
    @Published var exerciseDataByCategory = [String: WgerExerciseCategory]()
    @Published var exerciseBase = [WgerExerciseBaseModel]()
    
    private let apiService: APIService
    
    init(apiService: APIService) {
        self.apiService = apiService
    }
    
    func searchExercises(term: String) async {
        Task {
            do {
                let endpoint = WgerEndpoints.getExerciseSearchEndpoint(term: term)
                let data = try await apiService.makeWgerGETRequest(endpoint: endpoint)
                let decodedData = try JSONDecoder().decode(WgerExerciseDataModel.self, from: data)
                exerciseData = decodedData.suggestions
            } catch {
                print("Error: \(error.localizedDescription)")
            }
        }
        exerciseDataByCategory = groupExerciseDataDetailsByCategory()
    }
    
    func getExerciseBase(exercise: WgerExerciseDetail) async {
        Task {
            do {
                let endpoint = WgerEndpoints.getExerciseBaseEndpoint(baseId: exercise.baseId)
                let data = try await apiService.makeWgerGETRequest(endpoint: endpoint)
                let decodedData = try JSONDecoder().decode(WgerExerciseBaseModel.self, from: data)
                exerciseBase = [decodedData]
            } catch {
                print("Error: \(error.localizedDescription)")
                print("\(error)")
            }
        }
    }
    
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
