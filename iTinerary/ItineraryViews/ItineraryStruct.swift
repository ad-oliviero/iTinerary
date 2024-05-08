//
//  ItineraryStruct.swift
//  iTravel
//
//  Created by Adriano Oliviero on 07/05/24.
//

import Foundation

struct Place: Codable, Hashable {
  var name: String
  var image: String
  var budget: Int
  var durata: Int
  var placeId: String
  var category: Category

  init(
    name: String, image: String, budget: Int? = 0, durata: Int? = 0, placeId: String,
    category: Category
  ) {
    self.name = name
    self.image = image
    self.budget = budget!
    self.durata = durata!
    self.placeId = placeId
    self.category = category
  }

  init() {
    name = ""
    image = ""
    budget = 0
    durata = 0
    placeId = ""
    category = .tourism
  }

  func hash(into hasher: inout Hasher) {
    hasher.combine(name)
    hasher.combine(image)
    hasher.combine(budget)
    hasher.combine(durata)
    hasher.combine(placeId)
    hasher.combine(category)
  }

  enum CodingKeys: String, CodingKey {
    case name
    case image
    case budget
    case durata
    case placeId
    case category
  }
  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    name = try container.decode(String.self, forKey: .name)
    image = try container.decode(String.self, forKey: .image)
    budget = try container.decode(Int.self, forKey: .budget)
    durata = try container.decode(Int.self, forKey: .durata)
    placeId = try container.decode(String.self, forKey: .placeId)
    category = try container.decode(Category.self, forKey: .category)
  }
  func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    try container.encode(name, forKey: .name)
    try container.encode(image, forKey: .image)
    try container.encode(budget, forKey: .budget)
    try container.encode(durata, forKey: .durata)
    try container.encode(placeId, forKey: .placeId)
    try container.encode(category, forKey: .category)
  }
}

struct Itinerary: Codable, Hashable, Identifiable {
  var id = UUID()
  var city: Place
  var budget: Int
  var dayCount: Int
  var days: [[Place: Float]]
  var allPlaces: [Place]
  var categories: [Category: Bool]
  var isDone: Bool = false

  mutating func splitPlacesInDays() {
    days = Array(repeating: [:], count: dayCount)
    let placesPerDay = Int(ceil(Double(allPlaces.count) / Double(days.count)))
    for (index, place) in allPlaces.enumerated() {
      let dayIndex = index / placesPerDay
      days[dayIndex][place] = 0
    }
  }

  func hash(into hasher: inout Hasher) {
    hasher.combine(city)
    hasher.combine(budget)
    hasher.combine(dayCount)
    hasher.combine(days)
    hasher.combine(allPlaces)
    hasher.combine(categories)
    hasher.combine(isDone)
  }

  init() {
    city = Place()
    budget = 0
    dayCount = 0
    days = []
    allPlaces = []
    categories = [:]
    isDone = false
  }

  enum CodingKeys: String, CodingKey {
    case city
    case budget
    case dayCount
    case days
    case allPlaces
    case categories
    case isDone
  }
  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    city = try container.decode(Place.self, forKey: .city)
    budget = try container.decode(Int.self, forKey: .budget)
    dayCount = try container.decode(Int.self, forKey: .dayCount)
    days = try container.decode([[Place: Float]].self, forKey: .days)
    allPlaces = try container.decode([Place].self, forKey: .allPlaces)
    categories = try container.decode([Category: Bool].self, forKey: .categories)
    isDone = try container.decode(Bool.self, forKey: .isDone)
  }
  func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    try container.encode(city, forKey: .city)
    try container.encode(budget, forKey: .budget)
    try container.encode(dayCount, forKey: .dayCount)
    try container.encode(days, forKey: .days)
    try container.encode(allPlaces, forKey: .allPlaces)
    try container.encode(categories, forKey: .categories)
    try container.encode(isDone, forKey: .isDone)
  }
}