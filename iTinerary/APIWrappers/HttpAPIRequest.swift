//
//  HttpAPIRequest.swift
//  iTravel
//
//  Created by Adriano Oliviero on 07/05/24.
//

import Foundation

class HttpAPIRequest {
  internal var data: Data = Data()
  private(set) var json: [String: Any]
  private(set) var string: String
  public var url: String = ""

  private func findInFeature(feature: [String: Any], path: [String], idx: Int) -> String? {
    for f in feature {
      if f.key == path[idx] {
        if let value = f.value as? String ?? (f.value as? Int)?.description {
          return value
        } else {
          if idx + 1 < path.count {
            if let value = f.value as? [String: Any] {
              return findInFeature(feature: value, path: path, idx: idx + 1)
            } else if let value = f.value as? [[String: Any]] {
              return findInFeature(feature: value[Int(path[idx]) ?? 0], path: path, idx: idx + 1)
            }
          }
        }
      }
    }
    return nil
  }

  /// path is a string like: "properties/city" (DO NOT include "features/")
  public func getFromJson(path: String, index: Int) -> String {
    let splitPath = path.split(separator: "/").map { String($0) }
    if let features = json[splitPath.first!] as? [[String: Any]] {
      if features.count < index {
        return "feature[\(index)] does not exist"
      }
      let feature: [String: Any] = features[index]
      if splitPath.count < 1 {
        return "\(path) not found"
      }
      let newFeature: Any = feature[String(splitPath[1])] ?? "\(splitPath[1]) not found"
      if type(of: newFeature) == String.self {
        return newFeature as! String
      }
      if splitPath.count < 2 {
        return "\(path) not found"
      }
      return findInFeature(feature: newFeature as! [String: Any], path: splitPath, idx: 2)
        ?? "\(path) not found"
    } else if let feature = json[splitPath.first!] as? [String: Any] {
      if splitPath.count < 1 {
        return "\(path) not found"
      }
      return findInFeature(feature: feature, path: splitPath, idx: 1) ?? "\(path) not found"
    }
    return "\(path) not found"
  }

  init(url: String) async throws {
    self.url = url
    do {
      data = try await URLSession.shared.data(for: URLRequest(url: URL(string: self.url)!)).0
    } catch {
      throw error
    }
    json = try JSONSerialization.jsonObject(with: data) as! [String: Any]
    string = String(decoding: data, as: UTF8.self)
  }
}