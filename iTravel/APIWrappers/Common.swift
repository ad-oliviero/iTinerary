//
//  Common.swift
//  iTravel
//
//  Created by Adriano Oliviero on 30/04/24.
//

enum APIError: Error {
    case responseUninitialized
}

import Foundation
class CommonAPIUtils {
    public func httpsRequest(url: String) async throws -> Data {
        do {
            let response = try await URLSession.shared.data(for: URLRequest(url: URL(string: url)!))
            return response.0
        } catch {
            throw error
        }
    }
}
