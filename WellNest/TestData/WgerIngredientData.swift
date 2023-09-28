//
//  WgerIngredientData.swift
//  WellNest
//
//  Created by Joshua Truong on 9/28/23.
//

import Foundation

class WgerIngredientDataSource {
    private let decoder: JSONDecoder = JSONDecoder()
    
    func getWgerIngredient() -> WgerIngredientResponse {
        let jsonData = """
            {
            "count": 86732,
            "next": "https://wger.de/api/v2/ingredient/?limit=20&offset=20",
            "previous": null,
            "results": [
            {
              "id": 77897,
              "uuid": "7b13e612-14e6-424a-9418-4fd366ff3224",
              "code": "8801043020756",
              "name": "감자깡",
              "created": "2020-12-20T01:00:00+01:00",
              "creation_date": "2020-12-20 00:00:00+00:00",
              "last_update": "2023-04-08T02:00:00+02:00",
              "energy": 470,
              "protein": "6.000",
              "carbohydrates": "72.000",
              "carbohydrates_sugar": "4.000",
              "fat": "18.000",
              "fat_saturated": "6.000",
              "fibres": null,
              "sodium": "0.508",
              "license": 5,
              "license_title": "감자깡",
              "license_object_url": "",
              "license_author": "Open Food Facts",
              "license_author_url": "",
              "license_derivative_source_url": "",
              "language": 2
            },
            {
              "id": 85292,
              "uuid": "d340371a-53dd-45e7-8978-d0d5aaa6537c",
              "code": "8801052036229",
              "name": "햇살담은 양조간장",
              "created": "2023-02-08T01:00:00+01:00",
              "creation_date": "2023-02-08 00:00:00+00:00",
              "last_update": "2023-04-08T02:00:00+02:00",
              "energy": 64,
              "protein": "8.000",
              "carbohydrates": "8.100",
              "carbohydrates_sugar": "0.000",
              "fat": "0.100",
              "fat_saturated": "0.000",
              "fibres": null,
              "sodium": "4.200",
              "license": 5,
              "license_title": "햇살담은 양조간장",
              "license_object_url": "https://world.openfoodfacts.org/product/8801052036229/",
              "license_author": "openfoodfacts-contributors, oettimaggl, packbot, ecoscore-impact-estimator",
              "license_author_url": "",
              "license_derivative_source_url": "",
              "language": 1
            },
            {
              "id": 73598,
              "uuid": "7d29c11a-1d33-41d2-9db3-b457afc423d2",
              "code": "8410384053073",
              "name": "0.0% Alcohol Free Sparkling Rosé",
              "created": "2020-12-20T01:00:00+01:00",
              "creation_date": "2020-12-20 00:00:00+00:00",
              "last_update": "2023-04-08T02:00:00+02:00",
              "energy": 25,
              "protein": "0.000",
              "carbohydrates": "6.000",
              "carbohydrates_sugar": "5.400",
              "fat": "0.000",
              "fat_saturated": "0.000",
              "fibres": null,
              "sodium": "0.004",
              "license": 5,
              "license_title": "0.0% Alcohol Free Sparkling Rosé",
              "license_object_url": "",
              "license_author": "Open Food Facts",
              "license_author_url": "",
              "license_derivative_source_url": "",
              "language": 2
            }
            """.data(using: .utf8)!
        do {
            return try decoder.decode(WgerIngredientResponse.self, from: jsonData)
        } catch {
            return WgerIngredientResponse()
        }
    }
}
