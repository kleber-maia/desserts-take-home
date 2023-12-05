//
//  MealDetailServiceTests.swift
//  Desserts Take Home
//
//  Created by Kleber Maia on 11/6/23.
//

import XCTest
@testable import Desserts_Take_Home

final class MealDetailServiceTests: XCTestCase {
    func testDessertsId() async throws {
        // Arrange
        guard
            let jsonUrl = Bundle(for: Self.self).url(forResource: "creme_brulee", withExtension: "json"),
            let jsonData = try? Data(contentsOf: jsonUrl)
        else {
            XCTFail("JSON fixture couldn't be found")
            return
        }

        let mockSession = MockURLSessionProtocol(outputData: jsonData, outputStatusCode: 200)

        let service = MealDetailService(session: mockSession)

        // Act
        let actual = try await service.fetch(id: "id")

        // Assert
        XCTAssertEqual(actual?.id, "52917")
        XCTAssertEqual(mockSession.inputUrl?.absoluteString, "https://themealdb.com/api/json/v1/1/lookup.php?i=id")
    }

    func testDessertsId_whenResponseIsInvalid() async throws {
        // Arrange
        let mockSession = MockURLSessionProtocol(outputData: Data(), outputStatusCode: 500)

        let service = MealDetailService(session: mockSession)

        do {
            // Act
            _ = try await service.fetch(id: "id")
        } catch InternalError.invalidResponse {
            // expected outcome
        } catch {
            // invalid outcome
            XCTFail("Should have failed with .invalidResponse")
        }
    }
}
