//
//  MealDetailViewModelTests.swift
//  Desserts Take Home
//
//  Created by Kleber Maia on 11/6/23.
//

import Combine
import XCTest
@testable import Desserts_Take_Home

final class MealDetailViewModelTests: XCTestCase {
    private let detailModel = MealDetailModel(
        id: "id", name: "nane", thumbnailUrl: URL(string: "https://url.com")!, drinkAlternate: "drinkAlternate", category: "category", area: "area", instructions: "instructions", tags: "tags", youtubeUrl: URL(string: "https://youtube.com")!
    )

    func testInitialState() {
        // Arrange / Act
        let viewModel = MealDetailViewModel(id: "dummy", service: MockMealDetailService())

        // Assert
        XCTAssert(viewModel.loading == false)
        XCTAssert(viewModel.errorMessage == nil)
        XCTAssert(viewModel.meal == nil)
    }

    func testFetchData_whenItSucceeds() {
        // Arrange
        let mock = MockMealDetailService(outputModel: detailModel)

        let viewModel = MealDetailViewModel(id: "dummy", service: mock)

        // Act
        viewModel.fetchData()

        XCTAssert(viewModel.loading)

        expectation(observing: viewModel.$meal.dropFirst().first())

        waitForExpectations(timeout: 1)

        // Assert
        XCTAssert(viewModel.loading == false)
        XCTAssert(mock.inputId == "dummy")
        XCTAssert(viewModel.errorMessage == nil)
        XCTAssert(viewModel.meal == detailModel)
    }

    func testFetchData_whenItFails() {
        // Arrange
        let mock = MockMealDetailService(outputError: NSError(domain: "domain", code: 1001, userInfo: [NSLocalizedFailureErrorKey: "some error message"]))

        let viewModel = MealDetailViewModel(id: "dummy", service: mock)

        // Act
        viewModel.fetchData()

        expectation(observing: viewModel.$errorMessage.dropFirst().first())

        waitForExpectations(timeout: 1)

        // Assert
        XCTAssert(viewModel.errorMessage == "some error message")
        XCTAssert(viewModel.meal == nil)
    }
}
