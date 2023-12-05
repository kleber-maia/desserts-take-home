//
//  MockMealDetailService.swift
//  Desserts Take Home
//
//  Created by Kleber Maia on 11/6/23.
//

import XCTest
@testable import Desserts_Take_Home

class MockMealDetailService: MealDetailServicing {
    private(set) var inputId: String?

    private var outputModel: MealDetailModel?
    private var outputError: Error?

    init(outputModel: MealDetailModel? = nil, outputError: Error? = nil) {
        self.outputModel = outputModel
        self.outputError = outputError
    }

    func fetch(id: String) async throws -> MealDetailModel? {
        inputId = id

        if let outputError {
            throw outputError
        }

        return outputModel
    }
}
