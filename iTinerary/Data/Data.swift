//
//  ArchitectureData.swift
//  iTravel
//
//  Created by Franklyn Chiemeka Ekoh on 01/05/24.
//

import Observation
import SwiftUI

@Observable
class SharedData {
  var cost: String = "Prize"
  var event: String = "Location to visit"
  var duration: String = "time"
  var monuments = [
    Monument(
      name: "Colosseum", time: "duration", prize: "prize", image: "Colosseum", isClicked: false),
    Monument(
      name: "Trajan’s Market", time: "duration", prize: "prize", image: "Trajan’s Market",
      isClicked: false),
    Monument(
      name: "Imperial Fora", time: "duration", prize: "prize", image: "Imperial Fora",
      isClicked: false),
    Monument(
      name: "Circus Maximus", time: "duration", prize: "prize", image: "Circus Maximus",
      isClicked: false),

  ]
  var arts = [
    Art(
      name: "Vatican Museum", time: "duration", prize: "prize", image: "Vatican Museum",
      isClicked: false),
    Art(
      name: "Liberation Museum", time: "duration", prize: "prize", image: "Liberation Museum",
      isClicked: false),
    Art(
      name: "Capitoline Museum", time: "duration", prize: "prize", image: "Capitoline Museum",
      isClicked: false),
    Art(
      name: "Galleria Borghese", time: "duration", prize: "prize", image: "Galleria Borghese",
      isClicked: false),

  ]
  var sports = [
    Sport(
      name: "Roma-Inter", time: "duration", prize: "prize", image: "Roma-Inter", isClicked: false),
    Sport(
      name: "Roma-Novara", time: "duration", prize: "prize", image: "Roma-Novara", isClicked: false),
    Sport(
      name: "Roma-Novara", time: "duration", prize: "prize", image: "Roma-Novara", isClicked: false),
    Sport(
      name: "ATP Qualification", time: "duration", prize: "prize", image: "ATP Qualification",
      isClicked: false),

  ]
  var recaps = [
    Recap(
      Airport: "Airport", transportation: "Roma Fiumicino", Lunch: "Lunch", meal: "Fortunata",
      Visit: "Colosseum", Architecture: "Architecture", time: "time"),
    Recap(
      Airport: "Airport", transportation: "Roma Fiumicino", Lunch: "Lunch", meal: "Fortunata",
      Visit: "Colosseum", Architecture: "Architecture", time: "time"),
    Recap(
      Airport: "Airport", transportation: "Roma Fiumicino", Lunch: "Lunch", meal: "Fortunata",
      Visit: "Colosseum", Architecture: "Architecture", time: "time"),

  ]
}

var sharedData = SharedData()