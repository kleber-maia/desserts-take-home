//
//  MealModelTests.swift
//  Desserts Take Home
//
//  Created by Kleber Maia on 11/6/23.
//

import XCTest
@testable import Desserts_Take_Home

final class MealModelTests: XCTestCase {
    func testDecode_whenDataIsValid() throws {
        // Arrange
        guard
            let jsonUrl = Bundle(for: Self.self).url(forResource: "desserts", withExtension: "json"),
            let jsonData = try? Data(contentsOf: jsonUrl)
        else {
            XCTFail("JSON fixture couldn't be found")
            return
        }

        // Act
        let actual = try MealModel.decode(from: jsonData)

        // Assert
        XCTAssertEqual(actual.count, 65)

        XCTAssertEqual(actual.first?.id, "53049")
        XCTAssertEqual(actual.first?.name, "Apam balik")
        XCTAssertEqual(actual.first?.thumbnailUrl.absoluteString, "https://www.themealdb.com/images/media/meals/adxcbq1619787919.jpg")

        XCTAssertEqual(actual.last?.id, "52917")
        XCTAssertEqual(actual.last?.name, "White chocolate creme brulee")
        XCTAssertEqual(actual.last?.thumbnailUrl.absoluteString, "https://www.themealdb.com/images/media/meals/uryqru1511798039.jpg")
    }

    func testDecode_whenDataFormatIsInvalid() throws {
        // Arrange
        let jsonData = "{someData:[something:123]}".data(using: .utf8)!

        // Act / Assert
        XCTAssertThrowsError(try MealModel.decode(from: jsonData))
    }
}
