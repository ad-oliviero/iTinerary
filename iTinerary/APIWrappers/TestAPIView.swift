//
//  TestAPIView.swift
//  iTravel
//
//  Created by Adriano Oliviero on 30/04/24.
//

import SwiftUI

struct TestAPIView: View {
  @State var savedImage: UIImage? = nil
  @State var loadedImage: Bool = false
  var body: some View {
    NavigationStack {
      VStack {
        if loadedImage {
          Image(uiImage: savedImage!)
            .resizable()
            .frame(width: 300, height: 300)
        }
        Button {
          Task {
            //            do {
            //              let request = try await AutoCompleteAPIRequest(text: "Naples")
            //              for idx in 0..<(request.json["features"]! as AnyObject).count {
            //                print(
            //                  "\(request.getFromJson(path: "properties/city", index: idx)), \(request.getFromJson(path: "properties/country", index: idx)), \(request.getFromJson(path: "properties/state", index: idx)), \(request.getFromJson(path: "properties/wikidata", index: idx))"
            //                )
            //              }
            //            } catch {
            //              print(error.localizedDescription)
            //            }

            do {
              let request = try await PlacesDetailsAPIRequest(
                placeId:
                  "51ba9520bc96802c40596aa27af9426d4440f00101f90193593a00000000009203264d7573656f2061726368656f6c6f6769636f206e617a696f6e616c65206469204e61706f6c69"
              )
              for idx in 0..<(request.json["features"]! as AnyObject).count {
                let wikidataID = request.getFromJson(
                  path: "properties/wiki_and_media/wikidata", index: idx)
                let wikidata = try await WikiDataRequest(id: wikidataID)
                try await wikidata.getImage()
                if let imageData = FileManager.default.urls(
                  for: .documentDirectory, in: .userDomainMask
                ).first?.appendingPathComponent(wikidata.imageName!) {
                  print(wikidata.imageName!)
                  self.savedImage = UIImage(data: try Data(contentsOf: imageData))
                }
                loadedImage = true
                print(
                  "\(request.getFromJson(path: "properties/name", index: idx)), \(request.getFromJson(path: "properties/city", index: idx)), \(request.getFromJson(path: "properties/state", index: idx))"
                )
              }
            } catch {
              print(error.localizedDescription)
            }
          }
        } label: {
          Text("Request")
        }
      }
    }
  }
}

#Preview {
  TestAPIView()
}