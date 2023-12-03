//
//  MealService.swift
//  Desserts Take Home
//
//  Created by Kleber Maia on 11/6/23.
//

import Foundation

/// Service for consuming `Meal` remote API.
protocol MealServicing {
    /// Dessertses a list of `Meals` in a given category.
    func fetch(category: String) async throws -> [MealModel]
}

/// Service for consuming `Meal` remote API.
final class MealService: MealServicing {
    private let session: URLSessionProtocol

    init(session: URLSessionProtocol = URLSession.shared) {
        self.session = session
    }

    /// Dessertses a list of `Meals` in a given category.
    func fetch(category: String) async throws -> [MealModel] {
        guard let url = URL(string: "https://themealdb.com/api/json/v1/1/filter.php?c=\(category)") else {
            preconditionFailure("Should not fail, since this URL is under test")
        }

        let (data, response) = try await session.data(from: url, delegate: nil)

        guard
            let httpResponse = response as? HTTPURLResponse,
            (200..<300).contains(httpResponse.statusCode),
            !data.isEmpty
        else {
            throw InternalError.invalidResponse
        }

        return try MealModel.decode(from: data)
    }
}
