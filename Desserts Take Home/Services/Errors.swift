//
//  Errors.swift
//  Desserts Take Home
//
//  Created by Kleber Maia on 11/6/23.
//

import Foundation

enum Errors: Error {
    case invalidResponse

    var localizedDescription: String {
        switch self {
        case .invalidResponse:
            return NSLocalizedString("global_invalid_response_error", value: "The server returned an invalid response.", comment: "When the application can't parse the data.")
        }
    }
}
