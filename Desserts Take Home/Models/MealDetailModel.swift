//
//  MealModel.swift
//  Desserts Take Home
//
//  Created by Kleber Maia on 11/6/23.
//

import Foundation

/// Represents a `MealDetail` on the database.
struct MealDetailModel: Decodable {
    private struct MealDetailResult: Decodable {
        let meals: [MealDetailModel]
    }

    enum CodingKeys: String, CodingKey {
        case id = "idMeal"
        case name = "strMeal"
        case thumbnailUrl = "strMealThumb"
        case drinkAlternate = "strDrinkAlternate"
        case category = "strCategory"
        case area = "strArea"
        case instructions = "strInstructions"
        case tags = "strTags"
        case youtubeUrl = "strYoutube"
    }
    
    let id: String
    let name: String
    let thumbnailUrl: URL
    let drinkAlternate: String?
    let category: String
    let area: String
    let instructions: String
    let tags: String?
    let youtubeUrl: URL?

    var ingredients = [String]()
    var measures = [String]()

    /// Decodes `data` and returns a `MealDetailModel` when available.
    static func decode(from data: Data) throws -> Self? {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase

        let meals = try decoder.decode(MealDetailResult.self, from: data).meals

        var result = meals.first

        // some special treatment for decoding ingredients / measures, since the number
        // of items is unknown
        guard
            let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
            let root = (json["meals"] as? [Any])?.first,
            let mealDict = root as? [String: Any]
        else {
            return nil
        }

        for index in (1...99) {
            guard
                let ingredient = (mealDict["strIngredient\(index)"] as? String)?.trimmingCharacters(in: [" "]),
                !ingredient.isEmpty,
                let measure = (mealDict["strMeasure\(index)"] as? String)?.trimmingCharacters(in: [" "]),
                !measure.isEmpty
            else {
                break
            }

            result?.ingredients.append(ingredient)
            result?.measures.append(measure)
        }

        return result
    }
}
