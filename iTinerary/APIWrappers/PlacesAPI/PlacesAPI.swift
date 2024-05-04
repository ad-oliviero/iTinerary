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
  var categories: [Category]
  /// Additional filter (internet_available, wheelchair, vegan, ...)
  var conditions: [Condition]
  /// Max amount of results
  var limit: Int
  /// Kind of like page 1, 2, etc...
  var offset: Int
  init(
    placeId: String!, categories: [Category]!, conditions: [Condition] = [], limit: Int = 20,
    offset: Int = 0
  ) {
    self.placeId = placeId
    self.categories = categories
    self.conditions = conditions
    self.limit = limit
    self.offset = offset
    super.init()
    super.apiVersion = "v2/"
    apiType = "places?"
    parameters =
      "filter=place:\(self.placeId)&categories=access,\(self.categories.map { $0.rawValue.1 }.joined(separator: ","))&conditions=\(self.conditions.map { $0.rawValue.1 }.joined(separator: ","))&limit=\(self.limit)&offset=\(self.offset)"
  }
  //    public func responseToJson() async throws -> AutocompleteData {
  //        do {
  //            return try JSONDecoder().decode(AutocompleteData.self, from: response!)
  //        } catch {
  //            throw APIError.responseUninitialized
  //        }
  //    }
}