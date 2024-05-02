//
//  GeoAPIfy.swift
//  iTravel
//
//  Created by Adriano Oliviero on 02/05/24.
//

import Foundation


class GeoRequest {
    internal var baseUrl: String = "https://api.geoapify.com/v1/"
    internal var apiType: String = ""
    internal var parameters : String = ""
    internal var response: Data?, Decodable = Data()
    private let apiKey = "2fd2e15f4fb94d7f90bd4f809e76c302" // TODO: Make this shit secure
    private let httpUtils = CommonAPIUtils()
    private let lang = "en" // TODO: Make this dynamic
    
    public func sendRequest() async throws -> Void {
        response = try await httpUtils.httpsRequest(url: baseUrl + apiType + parameters + "&lang=\(lang)&apiKey=\(apiKey)")
    }
    
    public func responseToString() async throws -> String { String(decoding: response ?? Data(), as: UTF8.self) }
}

class PlacesAPI: GeoRequest {
}

class PlacesDetailsAPI: GeoRequest {
    
}
