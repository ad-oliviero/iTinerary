//
//  GeoAPIfy.swift
//  iTravel
//
//  Created by Adriano Oliviero on 02/05/24.
//

import Foundation

class GeoRequest {
  internal var data: Data = Data()
  private(set) var json: [String: Any]
  private(set) var string: String
  public var url: String = "https://api.geoapify.com/"
  private let apiKey = "95db4ee1c9da4c189181b24afc86e0db"  // TODO: Make this shit secure
  private let lang = "en"  // TODO: Make this dynamic
  
  /// path is a string like: "properties/city"
  /// WARNING: DO NOT PUT "features/" IN PATH!
  public func getFromJson(path: String, index: Int) -> String {
    let splitPath = path.split(separator: "/")
    var feature: [String: Any] = (json["features"] as! [[String : Any]])[index]
    for i in 0..<splitPath.count {
      let newFeature: Any = feature[String(splitPath[i])] ?? "\(splitPath[i]) not found"
      if type(of: newFeature) == String.self {
        return newFeature as! String
      }
      for f in newFeature as! [String: Any] {
        if f.key == splitPath[i+1] {
          return f.value as! String
        }
      }
    }
    return "\(path) not found"
  }
  
  init(apiType: String, apiVersion: String? = "v1/", parameters: String) async throws {
    do {
      self.url += apiVersion! + apiType + parameters + "&lang=\(lang)&apiKey=\(apiKey)"
      data = try await URLSession.shared.data(for: URLRequest(url: URL(string: url)!)).0
    } catch {
      throw error
    }
    json = try JSONSerialization.jsonObject(with: data) as! [String: Any]
    string = String(decoding: data, as: UTF8.self)
  }
}
