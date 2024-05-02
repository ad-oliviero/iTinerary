//
//  Isolines.swift
//  iTravel
//
//  Created by Adriano Oliviero on 02/05/24.
//

import Foundation

// MARK: - IsoLines Class
class IsoLinesRequest: GeoRequest {
    enum IsoType: String {
        case isochrone = "time"
        case isodistance = "distance"
    }
    enum Mode: String {
        case car = "drive"
        case bus = "bus"
        case walk = "walk"
        case publicTransport = "public"
    }
    /// Latitude
    var lat: String
    /// Longitude
    var lon: String
    /// IsoLine type
    var isoType: IsoType
    /// Navigation mode (car, bus, ...)
    var mode: Mode
    /// In seconds or meters
    var range: Int
    init(lat: String, lon: String, isoType: IsoType, mode: Mode, range: Int) {
        self.lat = lat
        self.lon = lon
        self.isoType = isoType
        self.mode = mode
        self.range = range
        super.init()
        super.apiType = "isoline?"
        super.parameters = "&traffic=approximated&lat=\(self.lat)&lon=\(self.lon)&range=\(self.range)&type=\(self.isoType.rawValue)&mode=\(self.mode.rawValue)"
    }
    // TODO: Implement this ADT
//    public func responseToJson() async throws -> ISOLinesData {
//        do {
//            return try JSONDecoder().decode(ISOLinesData.self, from: response!)
//        } catch {
//            throw APIError.responseUninitialized
//        }
//    }
}

