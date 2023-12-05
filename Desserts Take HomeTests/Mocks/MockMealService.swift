//
//  MockMealService.swift
//  Desserts Take Home
//
//  Created by Kleber Maia on 11/6/23.
//

import XCTest
@testable import Desserts_Take_Home

class MockMealService: MealServicing {
    private(set) var inputCategory: String?

    private var outputModels: [MealModel]
    private var outputError: Error?

    init(outputModels: [MealModel] = [], outputError: Error? = nil) {
        self.outputModels = outputModels
        self.outputError = outputError
    }

    func fetch(category: String) async throws -> [MealModel] {
        inputCategory = category

        if let outputError {
            throw outputError
        }

        return outputModels
    }
}
