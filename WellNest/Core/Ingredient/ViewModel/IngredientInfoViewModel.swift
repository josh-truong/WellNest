//
//  IngredientInfoViewModel.swift
//  WellNest
//
//  Created by Joshua Truong on 12/2/23.
//

import Foundation

@MainActor
class IngredientInfoViewModel: ObservableObject {
    @Published var info: WgerIngredientResult = .init()
    private let apiService: APIService = .shared
    
    func getIngredientInfo(_ ingredient: WgerIngredientResult) async {
        do {
            print("Requesting - \(ingredient.id)")
            let endpoint = try await WgerEndpoints.shared.getIngredientInfo(id: ingredient.id)
            apiService.makeWgerGETRequest(endpoint: endpoint, responseType: WgerIngredientResult.self) { [weak self] result in
                guard let self = self else { return }
                DispatchQueue.main.async {
                    switch result {
                    case .success(let data):
                        self.info = data
                    case .failure(let error):
                        self.info = .init()
                        print("Error: \(error.localizedDescription)")
                    }
                }
            }
            print("Finished - \(ingredient.id)")
        } catch {
            print("Error: \(error.localizedDescription)")
        }
    }
}
