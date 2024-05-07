//
//  SharedCity.swift
//  iTravel
//
//  Created by Daniela Landolfo on 02/05/24.
//

import Observation
import SwiftUI

@Observable
class SharedCity {
  var done = [
    City(name: "Barcelona", image: "barcelona"), City(name: "Paris", image: "paris"),
    City(name: "Milan", image: "milan"), City(name: "London", image: "london"),
  ]

  var toDo: [City] = []

  var creating: City = City()

}

var sharedCity = SharedCity()