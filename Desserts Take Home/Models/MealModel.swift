//
//  MealModel.swift
//  Desserts Take Home
//
//  Created by Kleber Maia on 11/6/23.
//

import Foundation

/// Represents a `Meal` on the database.
struct MealModel: Decodable, Hashable, Identifiable {
    private struct MealResult: Decodable {
        let meals: [MealModel]
    }

    enum CodingKeys: String, CodingKey {
        case id = "idMeal"
        case name = "strMeal"
        case thumbnailUrl = "strMealThumb"
    }
    
    let id: String
    let name: String
    let thumbnailUrl: URL

    /// Decodes `data` and returns an `[MealModel]`.
    static func decode(from data: Data) throws -> [Self] {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase

        let result = try decoder.decode(MealResult.self, from: data)

        return result.meals
    }
}
