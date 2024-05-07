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

  private func findInFeature(feature: [String: Any], path: [String], idx: Int) -> String? {
    for f in feature {
      if f.key == path[idx] {
        if let value = f.value as? String {
          return value
        } else {
          if idx + 1 < path.count {
            return findInFeature(feature: f.value as! [String: Any], path: path, idx: idx+1)
          }
        }
      }
    }
    return nil
  }

  /// path is a string like: "properties/city"
  /// WARNING: DO NOT PUT "features/" IN PATH!
  public func getFromJson(path: String, index: Int) -> String {
    let splitPath = path.split(separator: "/").map { String($0) }
    if let features = json["features"] as? [[String: Any]] {
      if features.count < index{
        return "feature[\(index)] does not exist"
      }
      let feature: [String: Any] = features[index]
      let newFeature: Any = feature[String(splitPath[0])] ?? "\(splitPath[0]) not found"
      if type(of: newFeature) == String.self {
        return newFeature as! String
      }
      return findInFeature(feature: newFeature as! [String: Any], path: splitPath, idx: 1) ?? "\(path) not found"
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
