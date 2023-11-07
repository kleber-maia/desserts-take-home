//
//  MealServiceTests.swift
//  Desserts Take Home
//
//  Created by Kleber Maia on 11/6/23.
//

import XCTest
@testable import Desserts_Take_Home

final class MealServiceTests: XCTestCase {
    func testDessertsCategory() async throws {
        // Arrange
        guard
            let jsonUrl = Bundle(for: Self.self).url(forResource: "desserts", withExtension: "json"),
            let jsonData = try? Data(contentsOf: jsonUrl)
        else {
            XCTFail("JSON fixture couldn't be found")
            return
        }

        let mockSession = MockURLSessionProtocol(data: jsonData, statusCode: 200)

        let service = MealService(session: mockSession)

        // Act
        let actual = try await service.fetch(category: "category")

        // Assert
        XCTAssertEqual(actual.count, 65)
        XCTAssertEqual(mockSession.requestUrl?.absoluteString, "https://themealdb.com/api/json/v1/1/filter.php?c=category")
    }

    func testDessertsCategory_whenResponseIsInvalid() async throws {
        // Arrange
        let mockSession = MockURLSessionProtocol(data: Data(), statusCode: 500)

        let service = MealService(session: mockSession)

        do {
            // Act
            _ = try await service.fetch(category: "category")
        } catch Errors.invalidResponse {
            // expected outcome
        } catch {
            // invalid outcome
            XCTFail("Should have failed with .invalidResponse")
        }
    }
}

// MARK: -

private class MockURLSessionProtocol: URLSessionProtocol {
    var requestUrl: URL?

    private var data: Data
    private var statusCode: Int

    init(data: Data, statusCode: Int) {
        self.data = data
        self.statusCode = statusCode
    }

    func data(from url: URL, delegate: (URLSessionTaskDelegate)?) async throws -> (Data, URLResponse) {
        requestUrl = url

        return (data, HTTPURLResponse(url: url, statusCode: statusCode, httpVersion: nil, headerFields: nil)!)
    }
}
