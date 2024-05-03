//
//  GeoAPIfy.swift
//  iTravel
//
//  Created by Adriano Oliviero on 02/05/24.
//

import Foundation

class GeoRequest {
  internal var baseUrl = "https://api.geoapify.com/"
  internal var apiVersion = "v1/"
  internal var apiType: String = ""
  internal var parameters: String = ""
  internal var response: Data?, Decodable = Data()
  private let apiKey = "2fd2e15f4fb94d7f90bd4f809e76c302"  // TODO: Make this shit secure
  private let httpUtils = CommonAPIUtils()
  private let lang = "en"  // TODO: Make this dynamic

  public func sendRequest() async throws {
    response = try await httpUtils.httpsRequest(
      url: baseUrl + apiVersion + apiType + parameters + "&lang=\(lang)&apiKey=\(apiKey)")
  }

  public func responseToString() async throws -> String {
    String(decoding: response ?? Data(), as: UTF8.self)
  }
  public func responseToJson() async throws -> GeoAPIfyData {
    do {
      return try JSONDecoder().decode(GeoAPIfyData.self, from: response!)
    } catch {
      throw APIError.responseUninitialized
    }
  }
}