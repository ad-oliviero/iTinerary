//
//  AutoComplete.swift
//  iTravel
//
//  Created by Adriano Oliviero on 02/05/24.
//

import Foundation

// MARK: - AutoComplete Class
class AutoComplete: GeoRequest {
    var text: String
    init(text: String!) {
        self.text = text
        super.init()
        url.append("geocode/autocomplete?text=\(self.text)&type=city")
    }
    public func responseToJson() async throws -> AutocompleteData {
        do {
            print(response == nil)
            return try JSONDecoder().decode(AutocompleteData.self, from: response!)
        } catch {
            throw APIError.responseUninitialized
        }
    }
    public func responseToString() async throws -> String {
        String(decoding: response ?? Data(), as: UTF8.self)
    }
}

// MARK: - AutocompleteData
struct AutocompleteData: Codable {
    let type: String
    let features: [Feature]
    let query: Query
}

// MARK: - Feature
struct Feature: Codable {
    let type: String
    let properties: Properties
    let geometry: Geometry
    let bbox: [Double]
}

// MARK: - Geometry
struct Geometry: Codable {
    let type: String
    let coordinates: [Double]
}

// MARK: - Properties
struct Properties: Codable {
    let country, countryCode, state, county: String
    let city: String
    let datasource: Datasource
    let stateCode: String
    let lon, lat: Double
    let population: Int
    let resultType, formatted, addressLine1, addressLine2: String
    let countyCode: String?
    let category: String
    let timezone: Timezone
    let plusCode, plusCodeShort: String
    let rank: Rank
    let placeID: String
    let postcode: String?

    enum CodingKeys: String, CodingKey {
        case country
        case countryCode = "country_code"
        case state, county, city, datasource
        case stateCode = "state_code"
        case lon, lat, population
        case resultType = "result_type"
        case formatted
        case addressLine1 = "address_line1"
        case addressLine2 = "address_line2"
        case countyCode = "county_code"
        case category, timezone
        case plusCode = "plus_code"
        case plusCodeShort = "plus_code_short"
        case rank
        case placeID = "place_id"
        case postcode
    }
}

// MARK: - Datasource
struct Datasource: Codable {
    let sourcename, attribution, license: String
    let url: String
}

// MARK: - Rank
struct Rank: Codable {
    let confidence, confidenceCityLevel: Int
    let matchType: String

    enum CodingKeys: String, CodingKey {
        case confidence
        case confidenceCityLevel = "confidence_city_level"
        case matchType = "match_type"
    }
}

// MARK: - Timezone
struct Timezone: Codable {
    let name, offsetSTD: String
    let offsetSTDSeconds: Int
    let offsetDST: String
    let offsetDSTSeconds: Int
    let abbreviationSTD, abbreviationDST: String

    enum CodingKeys: String, CodingKey {
        case name
        case offsetSTD = "offset_STD"
        case offsetSTDSeconds = "offset_STD_seconds"
        case offsetDST = "offset_DST"
        case offsetDSTSeconds = "offset_DST_seconds"
        case abbreviationSTD = "abbreviation_STD"
        case abbreviationDST = "abbreviation_DST"
    }
}

// MARK: - Query
struct Query: Codable {
    let text: String
    let parsed: Parsed
}

// MARK: - Parsed
struct Parsed: Codable {
    let city, expectedType: String

    enum CodingKeys: String, CodingKey {
        case city
        case expectedType = "expected_type"
    }
}
