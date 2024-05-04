//
//  CategoryEnum.swift
//  iTravel
//
//  Created by Adriano Oliviero on 02/05/24.
//

import Foundation

/// The rawvalue is a tuple in the following format: ("displayName", "apiRequest"). You only want to use the first one
/// If the displayName is missing, it means that the category is not meant to be displayed
enum Category: CaseIterable {
  typealias RawValue = (String, String)
  case sport
  case adult
  case beach
  case tourism
  case camping
  case catering
  case entertainment
  case man_made
  case natural
  var rawValue: (String, String) {
    switch self {
    case .sport:
      return ("Sport", "sport,ski,activity.sport_club,building.sport")
    case .tourism:
      return ("Tourism", "tourism,building.historic")
    case .adult:
      return ("Adult", "adult")
    case .beach:
      return ("Beach", "beach")
    case .camping:
      return ("Camping", "camping")
    case .catering:
      return (
        "Catering",
        "catering.bar,catering.biergarten,catering.cafe,catering.fast_food,catering.ice_cream,catering.pub,catering.restaurant"
      )
    case .entertainment:
      return (
        "Entertainment",
        "entertainment.activity_park.climbing,entertainment.activity_park.trampoline,entertainment.amusement_arcade,entertainment.aquarium,entertainment.cinema,entertainment.culture,entertainment.escape_game,entertainment.miniature_golf,entertainment.museum,entertainment.planetarium,entertainment.theme_park,entertainment.water_park,entertainment.zoo"
      )
    case .man_made:
      return ("Man made", "man_made,man_made.bridge,man_made.pier,man_made.tower,man_made.windmill")
    case .natural:
      return ("Natural", "natural,national_park")
    }
  }
}