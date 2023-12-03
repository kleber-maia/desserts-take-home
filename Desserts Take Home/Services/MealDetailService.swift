//
//  MealDetailService.swift
//  Desserts Take Home
//
//  Created by Kleber Maia on 11/6/23.
//

import Foundation

/// Service for consuming `Meal` remote API.
protocol MealDetailServicing {
    /// Dessertses a `Meal` matching a given `id`.
    func fetch(id: String) async throws -> MealDetailModel?
}

/// Service for consuming `Meal` remote API.
final class MealDetailService: MealDetailServicing {
    private let session: URLSessionProtocol

    init(session: URLSessionProtocol = URLSession.shared) {
        self.session = session
    }

    /// Dessertses a `Meal` matching a given `id`.
    func fetch(id: String) async throws -> MealDetailModel? {
        guard let url = URL(string: "https://themealdb.com/api/json/v1/1/lookup.php?i=\(id)") else {
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

        return try MealDetailModel.decode(from: data)
    }
}
