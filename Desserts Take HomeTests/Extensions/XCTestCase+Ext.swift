//
//  XCTestCase+Ext.swift
//  Desserts Take Home
//
//  Created by Kleber Maia on 11/6/23.
//

import Combine
import XCTest
@testable import Desserts_Take_Home

extension XCTestCase {
    private static var cancellables = Set<AnyCancellable>()

    /// Creates an Expectation that auto-fulfills when `publisher` completes.
    @discardableResult
    func expectation<T: Publisher>(observing publisher: T) -> XCTestExpectation {
        let expectation = expectation(description: "Awaiting publisher")

        publisher
            .sink { _ in
                expectation.fulfill()
            } receiveValue: { _ in
            }
            .store(in: &Self.cancellables)

        return expectation
    }
}
