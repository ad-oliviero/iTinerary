//
//  ConditionEnum.swift
//  iTravel
//
//  Created by Adriano Oliviero on 02/05/24.
//

struct ConditionStruct: Codable, Hashable {
  var value: DisplayableRequest
  var notValue: DisplayableRequest

  enum CodingKeys: String, CodingKey {
    case value
    case notValue
  }
  
  func hash(into hasher: inout Hasher) {
    hasher.combine(value)
    hasher.combine(notValue)
  }

  init(value: (String, String), notValue: (String, String)) {
    self.value = DisplayableRequest(value.0, value.1)
    self.notValue = DisplayableRequest(notValue.0, notValue.1)
  }
  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    value = try container.decode(DisplayableRequest.self, forKey: .value)
    notValue = try container.decode(DisplayableRequest.self, forKey: .notValue)
  }

  func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    try container.encode(value, forKey: .value)
    try container.encode(notValue, forKey: .notValue)
  }
}

enum Condition: CaseIterable {
  case dogs
  case gluten_free
  case vegan
  case wheelchair
  var rawValue: ConditionStruct {
    switch self {
    case .dogs:
      return ConditionStruct(value: ("Pets", "dogs,dogs_yes"), notValue: ("No Pets", "no_dogs"))
    case .gluten_free:
      return ConditionStruct(value: ("Gluten Free", "gluten_free"), notValue: ("With gluten", ""))
    case .vegan:
      return ConditionStruct(value: ("Vegan", "vegan,vegan.only"), notValue: ("Not vegan", ""))
    case .wheelchair:
      return ConditionStruct(
        value: ("Wheelchair", "wheelchair.yes"), notValue: ("No Wheelchair", ""))
    }
  }
}
