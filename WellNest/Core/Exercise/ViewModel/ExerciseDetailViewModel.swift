//
//  ExerciseDetailViewModel.swift
//  WellNest
//
//  Created by Joshua Truong on 12/7/23.
//

import Foundation

@MainActor
class ExerciseDetailViewModel : ObservableObject {
    @Published var result: WgerExerciseBaseResponse?
    private let apiService: APIService = .shared
    
    func getExerciseBase(_ exercise: WgerExerciseDetail) async {
        do {
            print("Requesting - \(exercise.name)")
            let endpoint = try await WgerEndpoints.shared.searchExerciseBase(baseId: exercise.baseId)
            apiService.makeWgerGETRequest(endpoint: endpoint, responseType: WgerExerciseBaseResponse.self) { [weak self] result in
                guard let self = self else { return }
                DispatchQueue.main.async {
                    switch result {
                    case .success(let data):
                        self.result = data
                    case .failure(let error):
                        self.result = nil
                        print("Error: \(error.localizedDescription)")
                    }
                }
            }
            print("Finished - \(exercise.name)")
        } catch {
            print("Error: \(error.localizedDescription)")
            print("Details:\n\(error)")
        }
    }
}
