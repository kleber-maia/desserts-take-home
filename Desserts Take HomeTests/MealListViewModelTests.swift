//
//  MealListViewModelTests.swift
//  Desserts Take Home
//
//  Created by Kleber Maia on 11/6/23.
//

import Combine
import XCTest
@testable import Desserts_Take_Home

final class MealListViewModelTests: XCTestCase {
    private let meals = [
        MealModel(id: "id_1", name: "Dulce de Leche", thumbnailUrl: URL(string: "https://dummy.com")!),
        MealModel(id: "id_2", name: "Vanilla Ice Cream", thumbnailUrl: URL(string: "https://dummy.com")!),
        MealModel(id: "id_3", name: "Key Lime Pie", thumbnailUrl: URL(string: "https://dummy.com")!)
    ]

    func testInitialState() {
        // Arrange / Act
        let viewModel = MealListViewModel(service: MockMealService())

        // Assert
        XCTAssert(viewModel.loading == false)
        XCTAssert(viewModel.errorMessage == nil)
        XCTAssert(viewModel.meals.isEmpty)
    }

    func testFetchData_whenItSucceeds() {
        // Arrange
        let mock = MockMealService(result: meals)

        let viewModel = MealListViewModel(service: mock)

        // Act
        viewModel.fetchData()

        XCTAssert(viewModel.loading)

        expectation(observing: viewModel.$meals.dropFirst().first())

        waitForExpectations(timeout: 1)

        // Assert
        XCTAssert(viewModel.loading == false)
        XCTAssert(mock.fetchCategory == "Dessert")
        XCTAssert(viewModel.errorMessage == nil)
        XCTAssert(viewModel.meals == meals)
    }

    func testFetchData_whenItFails() {
        // Arrange
        let mock = MockMealService(error: NSError(domain: "domain", code: 1001, userInfo: [NSLocalizedFailureErrorKey: "some error message"]))

        let viewModel = MealListViewModel(service: mock)

        // Act
        viewModel.fetchData()

        expectation(observing: viewModel.$errorMessage.dropFirst().first())

        waitForExpectations(timeout: 1)

        // Assert
        XCTAssert(viewModel.errorMessage == "some error message")
        XCTAssert(viewModel.meals.isEmpty)
    }

    func testSearchText() {
        // Arrange
        let mock = MockMealService(result: meals)

        let viewModel = MealListViewModel(service: mock)

        viewModel.fetchData()

        expectation(observing: viewModel.$meals.dropFirst().first())

        waitForExpectations(timeout: 1)

        // Act - Assert
        viewModel.searchText = "Lime"

        XCTAssert(viewModel.meals.count == 1)

        // Act - Assert
        viewModel.searchText = "Ice Cream"

        XCTAssert(viewModel.meals.count == 1)

        // Act - Assert
        viewModel.searchText = "Dulce de Leche"

        XCTAssert(viewModel.meals.count == 1)

        // Act - Assert
        viewModel.searchText = "Chocolate"

        XCTAssert(viewModel.meals.isEmpty)
    }
}
