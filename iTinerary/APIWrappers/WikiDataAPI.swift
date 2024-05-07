//
//  WikiDataAPI.swift
//  iTravel
//
//  Created by Adriano Oliviero on 07/05/24.
//

import Foundation

class WikiDataRequest: HttpAPIRequest {
  private var id: String
  public var imageName: String? = ""
  override func getFromJson(path: String, index: Int) -> String {
    super.getFromJson(path: "entities/\(self.id)/" + path, index: index)
  }
  public func getImage() async throws {
    self.imageName = self.getFromJson(path: "claims/P18/mainsnak/datavalue/value", index: 0)
    let imageUrl = "https://commons.wikimedia.org/wiki/Special:FilePath/\(self.imageName!)"
    var imageData: Data?
    do {
      imageData = try await URLSession.shared.data(for: URLRequest(url: URL(string: imageUrl)!)).0
      try imageData!.write(
        to: (FileManager.default.urls(
          for: .documentDirectory, in: .userDomainMask
        ).first?.appendingPathComponent(self.imageName!))!)
    } catch {
      throw error
    }
  }
  init(id: String) async throws {
    self.id = id
    try await super.init(
      url:
        "https://www.wikidata.org/w/api.php?action=wbgetentities&format=json&languages=en&ids=\(self.id)"
    )
  }
}