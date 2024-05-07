//
//  AutoCompleteAPI.swift
//  iTravel
//
//  Created by Adriano Oliviero on 02/05/24.
//

import Foundation

class AutoCompleteAPIRequest: GeoRequest {
  init(text: String) async throws {
    try await super.init(apiType: "geocode/autocomplete?", parameters: "text=\(text)&type=city")
  }
}