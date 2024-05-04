//
//  ConditionEnum.swift
//  iTravel
//
//  Created by Adriano Oliviero on 02/05/24.
//

import Foundation

enum Condition: CaseIterable {
  typealias RawValue = (String, String)
  case dogs
  case no_dogs
  case gluten_free
  case vegan
  case wheelchair_limited
  case wheelchair_yes
  var rawValue: (String, String) {
    switch self {
    case .dogs:
      return ("Pets", "dogs,dogs_yes")
    case .no_dogs:
      return ("No Pets", "no_dogs")
    case .gluten_free:
      return ("Gluten Free", "gluten_free")
    case .vegan:
      return ("Vegan", "vegan,vegan.only")
    case .wheelchair_limited:
      return ("No Wheelchair", "wheelchair.limited")
    case .wheelchair_yes:
      return ("Wheelchair", "wheelchair.yes")
    }
  }
}