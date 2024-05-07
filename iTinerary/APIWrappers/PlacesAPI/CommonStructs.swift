//
//  CommonStructs.swift
//  iTravel
//
//  Created by Adriano Oliviero on 03/05/24.
//

import Foundation

// MARK: - DisplayableRequest
struct DisplayableRequest: Codable, Hashable {
  var displayName: String
  var requestValue: String

  enum CodingKeys: String, CodingKey {
    case displayName
    case requestValue
  }

  func hash(into hasher: inout Hasher) {
    hasher.combine(displayName)
    hasher.combine(requestValue)
  }

  init(_ displayName: String, _ requestValue: String) {
    self.displayName = displayName
    self.requestValue = requestValue
  }

  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    displayName = try container.decode(String.self, forKey: .displayName)
    requestValue = try container.decode(String.self, forKey: .requestValue)
  }

  func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    try container.encode(displayName, forKey: .displayName)
    try container.encode(requestValue, forKey: .requestValue)
  }
}
