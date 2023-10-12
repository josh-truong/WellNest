//
//  MealViewModel.swift
//  WellNest
//
//  Created by Joshua Truong on 9/28/23.
//

import Foundation

class MealViewModel : ObservableObject {
    @Published var ingredientSuggestions: [WgerIngredientSuggestion]
    private let apiService: APIService
    
    init(apiService: APIService) {
        self.apiService = apiService
        self.ingredientSuggestions = [] // Initialize with an empty array
    }
    
    @MainActor
    func searchIngredient(term: String) async {
        do {
            print("Requesting - \(term)")
            let endpoint = WgerEndpoints.getIngredientSearchEndpoint(term: term)
            let data = try await apiService.makeWgerGETRequest(endpoint: endpoint, responseType: WgerIngredientSearchResponse.self)
            ingredientSuggestions = data.suggestions
            print(data)
            print("Finished - \(term)")
        } catch {
            print(error)
            print("Error: \(error.localizedDescription)")
        }
    }
}
