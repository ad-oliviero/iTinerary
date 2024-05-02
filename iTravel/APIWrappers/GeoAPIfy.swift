//
//  GeoAPIfy.swift
//  iTravel
//
//  Created by Adriano Oliviero on 02/05/24.
//

import Foundation


class GeoRequest {
    public var url: String = "https://api.geoapify.com/v1/" // this will be updated in the functions below
    public var response: Data?, Decodable = Data()
    private let apiKey = "2fd2e15f4fb94d7f90bd4f809e76c302" // TODO: Make this shit secure
    private let httpUtils = CommonAPIUtils()
    private let lang = "en" // TODO: Make this dynamic
    
    public func sendRequest() async throws -> Void { response = try await httpUtils.httpsRequest(url: url + "&lang=\(lang)&apiKey=\(apiKey)") }
}

class IsolinesAPI: GeoRequest {
    
}

class PlacesAPI: GeoRequest {
}

class PlacesDetailsAPI: GeoRequest {
    
}
