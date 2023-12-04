//
//  MockMealDetailService.swift
//  Desserts Take Home
//
//  Created by Kleber Maia on 11/6/23.
//

import XCTest
@testable import Desserts_Take_Home

class MockMealDetailService: MealDetailServicing {
    private(set) var fetchId: String?

    private var result: MealDetailModel?
    private var error: Error?

    init(result: MealDetailModel? = nil, error: Error? = nil) {
        self.result = result
        self.error = error
    }

    func fetch(id: String) async throws -> MealDetailModel? {
        fetchId = id

        if let error {
            throw error
        }

        return result
    }
}
