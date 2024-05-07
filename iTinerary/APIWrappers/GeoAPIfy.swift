//
//  GeoAPIfy.swift
//  iTravel
//
//  Created by Adriano Oliviero on 02/05/24.
//

import Foundation

class GeoRequest: HttpAPIRequest {
  override func getFromJson(path: String, index: Int) -> String {
    super.getFromJson(path: "features/" + path, index: index)
  }
  init(apiType: String, apiVersion: String? = "v1/", parameters: String) async throws {
    let apiKey = "95db4ee1c9da4c189181b24afc86e0db"
    try await super.init(
      url: "https://api.geoapify.com/" + apiVersion! + apiType + parameters
        + "&lang=en&apiKey=\(apiKey)")
  }
}