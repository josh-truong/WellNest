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
            let endpoint = try await WgerEndpoints.shared.searchExerciseBase(baseId: selectedExercise.baseId)
            apiService.makeWgerGETRequest(endpoint: endpoint, responseType: WgerExerciseBaseResponse.self) { [weak self] result in
                guard let self = self else { return }
                DispatchQueue.main.async {
                    switch result {
                    case .success(let data):
                        self.exerciseBase = data
                    case .failure(let error):
                        self.exerciseBase = nil
                        print("Error: \(error.localizedDescription)")
                    }
                }
            }
            
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
