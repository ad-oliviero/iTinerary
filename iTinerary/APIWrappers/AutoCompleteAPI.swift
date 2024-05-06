//
//  AutoCompleteAPI.swift
//  iTravel
//
//  Created by Adriano Oliviero on 02/05/24.
//

import Foundation

//struct AutocompleteData: Codable {
//    let type: String
//    let features: [Feature]
//    let query: Query
//}

class AutoCompleteAPIRequest: GeoRequest {
  var text: String
  init(text: String!) async throws {
    self.text = text
    try await super.init(
      apiType: "geocode/autocomplete?", parameters: "text=\(self.text)&type=city")
  }
}