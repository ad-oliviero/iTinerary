//
//  GeoAPIfy.swift
//  iTravel
//
//  Created by Adriano Oliviero on 02/05/24.
//

import Foundation

class GeoRequest {
    private let apiKey = "2fd2e15f4fb94d7f90bd4f809e76c302"; // TODO: Make this shit secure
    private var url: String = "https://"; // this will be updated in the functions below
    private var response: Data? = nil;
    private let httpUtils = CommonAPIUtils();
    
    public func sendRequest() async throws -> Void { response = try await httpUtils.responseRawData(url); }
}

class IsolinesAPI: GeoRequest {
    
}

class PlacesAPI: GeoRequest {
    
}

class PlacesDetailsAPI: GeoRequest {
    
}
