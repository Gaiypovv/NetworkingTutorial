//
//  CoinAPIError.swift
//  NetworkingTutorial
//
//  Created by Eldar Gaiypov on 27/11/23.
//

import Foundation

enum CoinAPIError: Error {
    case invalidData
    case jsonParsingFailure
    case requestFailed(description: String)
    case invalidStatusCode(statusCode: Int)
    case unknowError(error: Error)
    
    var customDescriction: String {
        switch  self {
        case .invalidData: return "Invalid data"
        case .jsonParsingFailure: return "Failed to parse JSON"
        case let .requestFailed(description): return "Request failed: \(description)"
        case let .invalidStatusCode(statusCode): return "Invalid status code: \(statusCode)"
        case let .unknowError(error): return "An unknown error occured \(error.localizedDescription)"
        }
    }
}
