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
    init(placeId: String!) {
        self.placeId = placeId
        super.init()
        super.apiVersion = "v2/"
        apiType = "place-details?"
        parameters = "id=\(self.placeId!)"
    }
    init(lat: String!, lon: String!) {
        self.lat = lat
        self.lon = lon
        super.init()
        super.apiVersion = "v2/"
        apiType = "place-details?"
        parameters = "lat=\(self.lat!)&lon=\(self.lon!)"
    }
//    public func responseToJson() async throws -> AutocompleteData {
//        do {
//            return try JSONDecoder().decode(AutocompleteData.self, from: response!)
//        } catch {
//            throw APIError.responseUninitialized
//        }
//    }
}
