//
//  MockURLSessionProtocol.swift
//  Desserts Take Home
//
//  Created by Kleber Maia on 11/6/23.
//

import XCTest
@testable import Desserts_Take_Home

class MockURLSessionProtocol: URLSessionProtocol {
    private(set) var inputUrl: URL?

    private var outputData: Data
    private var outputStatusCode: Int

    init(outputData: Data, outputStatusCode: Int) {
        self.outputData = outputData
        self.outputStatusCode = outputStatusCode
    }

    func data(from url: URL, delegate: (URLSessionTaskDelegate)?) async throws -> (Data, URLResponse) {
        inputUrl = url

        return (outputData, HTTPURLResponse(url: url, statusCode: outputStatusCode, httpVersion: nil, headerFields: nil)!)
    }
}
