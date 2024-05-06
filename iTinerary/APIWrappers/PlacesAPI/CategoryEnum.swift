//
//  CategoryEnum.swift
//  iTravel
//
//  Created by Adriano Oliviero on 02/05/24.
//

enum Category: CaseIterable {
  case sport
  case adult
  case beach
  case tourism
  case camping
  case catering
  case entertainment
  case man_made
  case natural
  var rawValue: DisplayableRequest {
    switch self {
    case .sport:
      return DisplayableRequest("Sport", "sport,ski,activity.sport_club,building.sport")
    case .tourism:
      return DisplayableRequest("Tourism", "tourism,building.historic")
    case .adult:
      return DisplayableRequest("Adult", "adult")
    case .beach:
      return DisplayableRequest("Beach", "beach")
    case .camping:
      return DisplayableRequest("Camping", "camping")
    case .catering:
      return DisplayableRequest(
        "Catering",
        "catering.bar,catering.biergarten,catering.cafe,catering.fast_food,catering.ice_cream,catering.pub,catering.restaurant"
      )
    case .entertainment:
      return DisplayableRequest(
        "Entertainment",
        "entertainment.activity_park.climbing,entertainment.activity_park.trampoline,entertainment.amusement_arcade,entertainment.aquarium,entertainment.cinema,entertainment.culture,entertainment.escape_game,entertainment.miniature_golf,entertainment.museum,entertainment.planetarium,entertainment.theme_park,entertainment.water_park,entertainment.zoo"
      )
    case .man_made:
      return DisplayableRequest(
        "Man made", "man_made,man_made.bridge,man_made.pier,man_made.tower,man_made.windmill")
    case .natural:
      return DisplayableRequest("Natural", "natural,national_park")
    }
  }
}