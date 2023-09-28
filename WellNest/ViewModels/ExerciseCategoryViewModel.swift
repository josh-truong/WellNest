//
//  ExerciseCategoryViewModel.swift
//  WellNest
//
//  Created by Joshua Truong on 9/22/23.
//

import Foundation

class ExerciseCategoryViewModel : ObservableObject {
    @Published var selectedExercise: WgerExerciseDetail = WgerExerciseDetail()
    @Published var exerciseBase: WgerExerciseBaseResponse?
    
    private let apiService: APIService
    
    init(apiService: APIService) {
        self.apiService = apiService
    }
    
    @MainActor
    func getExerciseBase() async {
        do {
            print("Requesting - \(selectedExercise.name)")
            let endpoint = WgerEndpoints.getExerciseBaseEndpoint(baseId: selectedExercise.baseId)
            let data = try await apiService.makeWgerGETRequest(endpoint: endpoint)
            exerciseBase = try JSONDecoder().decode(WgerExerciseBaseResponse.self, from: data)
            print("Finished - \(selectedExercise.name)")
        } catch {
            print("Error: \(error.localizedDescription)")
            print("Details:\n\(error)")
        }
    }
    
    @MainActor
    func reset() {
        exerciseBase = nil
    }
}
