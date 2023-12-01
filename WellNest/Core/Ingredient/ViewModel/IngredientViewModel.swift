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
    
    @MainActor
    func searchIngredient(term: String) async {
        do {
            print("Requesting - \(term)")
            let endpoint = try await WgerEndpoints.shared.searchIngredients(term: term)
            api.makeWgerGETRequest(endpoint: endpoint, responseType: WgerIngredientSearchResponse.self) { [weak self] result in
               guard let self = self else { return }
                DispatchQueue.main.async {
                    switch result {
                    case .success(let data):
                        self.results = data.suggestions
                    case .failure(let error):
                        self.results = [WgerIngredientSuggestion]()
                        print("Error: \(error.localizedDescription)")
                    }
                }
           }
            print("Finished - \(term)")
        } catch {
            print("Error: \(error.localizedDescription)")
        }
    }
    
    func requestDefaultIngredients() async {
        do {
            print("Requesting Default Ingredients")
            let endpoint = try await WgerEndpoints.shared.getIngredients()
            api.makeWgerGETRequest(endpoint: endpoint, responseType: WgerIngredientResponse.self) { [weak self] result in
                guard let self = self else { return }
                DispatchQueue.main.async {
                    switch result {
                    case .success(let data):
                        self.defaultIngredients = data
                        self.results = self.defaultIngredients.results.map { value in
                            return WgerIngredientSuggestion(value: value.name, data: WgerIngredientData(name: value.name))
                        }
                    case .failure(let error):
                        self.results = [WgerIngredientSuggestion]()
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
