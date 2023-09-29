//
//  DefaultIngredientViewModel.swift
//  WellNest
//
//  Created by Joshua Truong on 9/29/23.
//

import Foundation

class DefaultIngredientViewModel: ObservableObject {
    @Published var defaultIngredients: WgerIngredientResponse
    private let apiService: APIService = APIService()
    
    init() {
        self.defaultIngredients = WgerIngredientResponse() // Initialize with a default value
    }
    
    @MainActor
    func getIngredientPlaceholder() async {
        do {
            print("Requesting Default Ingredients")
            let endpoint = WgerEndpoints.getIngredientsEndpoint()
            let data = try await apiService.makeWgerGETRequest(endpoint: endpoint)
            let parsedData = try JSONDecoder().decode(WgerIngredientResponse.self, from: data)
            defaultIngredients = parsedData
            print(parsedData)
            print("Finished Default Ingredients")
        } catch {
            print("Error: \(error.localizedDescription)")
        }
    }
}
