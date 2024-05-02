//
//  Common.swift
//  iTravel
//
//  Created by Adriano Oliviero on 30/04/24.
//

import Foundation
class CommonAPIUtils {
    private func httpsRequest(url: String) async throws -> Data {
        do {
            let response = try await URLSession.shared.data(for: URLRequest(url: URL(string: url)!))
            return response.0
        } catch {
            throw error
        }
    }
    public func responseRawData(_ url: String) async throws -> Data { return try await httpsRequest(url: url); }
    public func responseToString(_ url: String) async throws -> String {
        let response = try await httpsRequest(url: url)
        return String(decoding: response, as: UTF8.self)
    }
    public func responseToDict(_ url: String) async throws -> [String: Any] {
        let response = try await httpsRequest(url: url)
        do {
            return try (JSONSerialization.jsonObject(with: response, options: []) as? [String: Any])!
        } catch {
            print(error.localizedDescription)
            return [:]
        }
    }
}
