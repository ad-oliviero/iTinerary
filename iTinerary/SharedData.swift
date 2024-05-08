//
//  SharedData.swift
//  iTravel
//
//  Created by Adriano Oliviero on 07/05/24.
//

import Foundation

class SharedData: ObservableObject {
  var itineraries: [Itinerary]
  var currentIdx: Int

  private let itinerariesURL: URL? =
    (FileManager.default.urls(
      for: .documentDirectory, in: .userDomainMask
    ).first?.appendingPathComponent("itineraries.json"))
  init() {
    if itinerariesURL != nil {
      do {
        itineraries = try JSONDecoder().decode(
          [Itinerary].self, from: Data(contentsOf: itinerariesURL!))
        currentIdx = itineraries.count
      } catch {
        itineraries = []
        currentIdx = -1
      }
    } else {
      itineraries = []
      currentIdx = -1
    }
  }
  public func save() {
    try! JSONEncoder().encode(itineraries).write(to: itinerariesURL!)
  }
}

var sharedData = SharedData()