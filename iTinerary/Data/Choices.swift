//
//  choices.swift
//  iTravel
//
//  Created by Daniela Landolfo on 04/05/24.
//

import Foundation

struct Choice {
  let options: [String]
  var selectedIndex: Int? = nil
}

struct UserPreferences {
  var choices: [Choice] = [
    Choice(options: ["Adventure", "Relax"]),
    Choice(options: ["Public transport", "Private transport"]),
    Choice(options: ["Local cuisine", "International cuisine"]),
    Choice(options: ["Animals", "No Animals"]),
    Choice(options: ["Wheelchair", "No Wheelchair"]),
    Choice(options: ["No vegan", "Vegan"]),
    Choice(options: ["Gluten Free", "With Gluten"]),
  ]
}

var preferences = UserPreferences()