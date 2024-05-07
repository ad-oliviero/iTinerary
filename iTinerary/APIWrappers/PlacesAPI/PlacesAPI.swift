//
//  PlacesAPI.swift
//  iTravel
//
//  Created by Adriano Oliviero on 02/05/24.
//

import Foundation

class PlacesAPIRequest: GeoRequest {
  /// Id of the city
  var placeId: String
  /// Categories of places to search (accommodation, activity, ...)
  var category: Category
  /// Additional filter (internet_available, wheelchair, vegan, ...)
  var conditions: [Condition: Int]
  /// Max amount of results
  var limit: Int
  /// Kind of like page 1, 2, etc...
  var offset: Int
  init(
    placeId: String!, category: Category!, conditions: [Condition: Int] = [:], limit: Int = 20,
    offset: Int = 0
  ) async throws {
    self.placeId = placeId
    self.category = category
    self.conditions = conditions
    self.limit = limit
    self.offset = offset
    var parameters = "filter=place:\(self.placeId)"
    parameters +=
      "&categories=\(self.category)"
    if conditions.count > 0 {
      parameters +=
        "&conditions=\(self.conditions.filter{$0.value != 0}.map { $0.value == 1 ? $0.key.rawValue.value.requestValue : ($0.value == 2 ? $0.key.rawValue.notValue.requestValue : "")}.joined(separator: ","))"
    }
    parameters += "&limit=\(self.limit)&offset=\(self.offset)"
    try await super.init(apiType: "places?", apiVersion: "v2/", parameters: parameters)
  }
}