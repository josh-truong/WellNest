//
//  IngredientViewModel.swift
//  WellNest
//
//  Created by Joshua Truong on 11/12/23.
//

import Foundation

@MainActor
class IngredientViewModel : ObservableObject {
    private let api = APIService.shared
    @Published var results = [WgerIngredientSuggestion]()
    @Published var defaultIngredients = WgerIngredientResponse()
    
    func searchIngredient(term: String) async {
        do {
            print("Requesting - \(term)")
            let endpoint = try await WgerEndpoints.shared.searchIngredients(term: term)
            let data = try await api.makeWgerGETRequest(endpoint: endpoint, responseType: WgerIngredientSearchResponse.self)
            self.results = data.suggestions
            print("Finished - \(term)")
        } catch {
            print("Error: \(error.localizedDescription)")
        }
    }
    
    func requestDefaultIngredients() async {
        do {
            print("Requesting Default Ingredients")
            let endpoint = try await WgerEndpoints.shared.getIngredients()
            let data = try await api.makeWgerGETRequest(endpoint: endpoint, responseType: WgerIngredientResponse.self)
            defaultIngredients = data
            self.results = defaultIngredients.results.map { value in
                return WgerIngredientSuggestion(value: value.name, data: WgerIngredientData(name: value.name))
            }
            print("Finished Default Ingredients")
        } catch {
            print("Error: \(error.localizedDescription)")
        }
    }
}
