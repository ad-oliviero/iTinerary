//
//  SharedData.swift
//  iTravel
//
//  Created by Adriano Oliviero on 07/05/24.
//

import Foundation

class SharedData: ObservableObject {
  @Published var itineraries: [Itinerary]
  var currentIdx: Int

  private var itinerariesURL: URL? =
    (FileManager.default.urls(
      for: .documentDirectory, in: .userDomainMask
    ).first?.appendingPathComponent("itineraries.json"))
  init() {
    var tempItineraries: [Itinerary] = []
    var tempCurrentIdx: Int = -1

    if let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?
      .appendingPathComponent("itineraries.json")
    {
      do {
        tempItineraries = try JSONDecoder().decode([Itinerary].self, from: Data(contentsOf: url))
        tempCurrentIdx = tempItineraries.count
      } catch {
        print("Error decoding itineraries: \(error)")
      }
    }

    itineraries = tempItineraries
    currentIdx = tempCurrentIdx
  }
  public func save() {
    try! JSONEncoder().encode(itineraries).write(to: itinerariesURL!)
  }
}

var sharedData = SharedData()