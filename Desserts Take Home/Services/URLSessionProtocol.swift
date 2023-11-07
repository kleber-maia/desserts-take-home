//
//  File.swift
//  Desserts Take Home
//
//  Created by Kleber Maia on 11/6/23.
//

import Foundation

/// Extracts `URLSession`'s consumed public interface for testing purposes.
protocol URLSessionProtocol {
    func data(from url: URL, delegate: (URLSessionTaskDelegate)?) async throws -> (Data, URLResponse)
}

extension URLSession: URLSessionProtocol {}
