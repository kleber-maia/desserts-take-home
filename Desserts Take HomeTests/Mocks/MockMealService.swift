//
//  MockMealService.swift
//  Desserts Take Home
//
//  Created by Kleber Maia on 11/6/23.
//

import XCTest
@testable import Desserts_Take_Home

class MockMealService: MealServicing {
    private(set) var fetchCategory: String?

    private var result: [MealModel]
    private var error: Error?

    init(result: [MealModel] = [], error: Error? = nil) {
        self.result = result
        self.error = error
    }

    func fetch(category: String) async throws -> [MealModel] {
        fetchCategory = category

        if let error {
            throw error
        }

        return result
    }
}
