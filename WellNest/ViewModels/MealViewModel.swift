//
//  MealViewModel.swift
//  WellNest
//
//  Created by Joshua Truong on 9/28/23.
//

import Foundation

class MealViewModel : ObservableObject {
    @Published var ingredients: WgerIngredientResponse? = nil
    @Published var ingredientSuggestions: WgerIngredientSearchResponse? = nil
    private let apiService: APIService
    
    init(apiService: APIService) {
        self.apiService = apiService
    }
    
    @MainActor
    func searchIngredient(term: String) async {
        do {
            print("Requesting - \(term)")
            let endpoint = WgerEndpoints.getIngredientSearchEndpoint(term: term)
            let data = try await apiService.makeWgerGETRequest(endpoint: endpoint)
            let parsedData = try JSONDecoder().decode(WgerIngredientSearchResponse.self, from: data)
            ingredientSuggestions = parsedData
            print("Finished - \(term)")
        } catch {
            print("Error: \(error.localizedDescription)")
        }
    }
    
    @MainActor
    func getIngredientPlaceholder() async {
        do {
            print("Requesting Default Ingredients")
            let endpoint = WgerEndpoints.getIngredientsEndpoint()
            let data = try await apiService.makeWgerGETRequest(endpoint: endpoint)
            let parsedData = try JSONDecoder().decode(WgerIngredientResponse.self, from: data)
            ingredients = parsedData
            print(parsedData)
            print("Finished Default Ingredients")
        } catch {
            print(error)
            print("Error: \(error.localizedDescription)")
        }
    }
}
