//
//  GeoAPIfy.swift
//  iTravel
//
//  Created by Adriano Oliviero on 02/05/24.
//

import Foundation

class GeoRequest {
  internal var baseUrl = "https://api.geoapify.com/"
  internal var data: Data?, Decodable = Data()
  private(set) var json: [String: Any]
  private(set) var string: String
  private let apiKey = "95db4ee1c9da4c189181b24afc86e0db"  // TODO: Make this shit secure
  private let lang = "en"  // TODO: Make this dynamic

  init(apiType: String, apiVersion: String? = "v1/", parameters: String) async throws {
    let url = baseUrl + apiVersion! + apiType + parameters + "&lang=\(lang)&apiKey=\(apiKey)"
    do {
      self.data = try await URLSession.shared.data(for: URLRequest(url: URL(string: url)!)).0
      self.json = try JSONSerialization.jsonObject(with: data!) as! [String: Any]
    } catch {
      throw error
    }
    self.string = String(decoding: data!, as: UTF8.self)
  }
}