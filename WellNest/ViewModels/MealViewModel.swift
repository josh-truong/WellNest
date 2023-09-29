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
            let data = try await apiService.makeWgerGETRequest(endpoint: endpoint)
            let parsedData = try JSONDecoder().decode(WgerIngredientSearchResponse.self, from: data)
            ingredientSuggestions = parsedData.suggestions
            print(parsedData)
            print("Finished - \(term)")
        } catch {
            print(error)
            print("Error: \(error.localizedDescription)")
        }
    }
}
