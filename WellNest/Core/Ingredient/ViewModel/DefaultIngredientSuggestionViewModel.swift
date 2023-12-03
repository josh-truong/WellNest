//
//  DefaultIngredientSuggestionViewModel.swift
//  WellNest
//
//  Created by Joshua Truong on 12/2/23.
//

import Foundation

@MainActor
class DefaultIngredientSuggestionViewModel : ObservableObject {
    private let apiService = APIService.shared
    @Published var suggestions = [WgerIngredientResult]()
    
    func getDefaultIngredients() async {
        do {
            print("Requesting Default Ingredients")
            let endpoint = try await WgerEndpoints.shared.getIngredients()
            apiService.makeWgerGETRequest(endpoint: endpoint, responseType: WgerIngredientResponse.self) { [weak self] result in
                guard let self = self else { return }
                DispatchQueue.main.async {
                    switch result {
                    case .success(let data):
                        self.suggestions = data.results
                    case .failure(let error):
                        self.suggestions = [WgerIngredientResult]()
                        print("Error: \(error.localizedDescription)")
                    }
                }
            }
            print("Finished Default Ingredients")
        } catch {
            print("Error: \(error.localizedDescription)")
        }
    }
}
