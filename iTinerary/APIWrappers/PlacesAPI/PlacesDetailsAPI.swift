//
//  PlacesDetailsAPI.swift
//  iTravel
//
//  Created by Adriano Oliviero on 02/05/24.
//

import Foundation

class PlacesDetailsAPI: GeoRequest {
  /// Id of the city
  var placeId: String? = nil
  /// Latitude
  var lat: String? = nil
  /// Longitude
  var lon: String? = nil
  init(placeId: String!) async throws {
    self.placeId = placeId
    try await super.init(
      apiType: "place-details?", apiVersion: "v2/", parameters: "id=\(self.placeId!)")
  }
  init(lat: String!, lon: String!) async throws {
    self.lat = lat
    self.lon = lon
    try await super.init(
      apiType: "place-details?", apiVersion: "v2/", parameters: "lat=\(self.lat!)&lon=\(self.lon!)")
  }
}