//
//  TestAPIView.swift
//  iTravel
//
//  Created by Adriano Oliviero on 30/04/24.
//

import SwiftUI

struct TestAPIView: View {
  var body: some View {
    NavigationStack {
      VStack {
        Button {
          Task {
            do {
              let request = try await AutoCompleteAPIRequest(text: "Roma")
              for feature in request.json["features"] as! [[String: Any]] {
                print((feature["properties"]! as! [String: Any])["city"]!)
              }
            } catch {
              print(error.localizedDescription)
            }

            //                      do {
            //                        let request = PlacesAPIRequest(placeId: "51063374ce77842c40592316a919526d4440f00102f901a0c72b110000000092030f4d7573656f2044696f636573616e6f",categories: Category.allCases.map { $0 }, limit: 10, offset: 0)
            //                        try await request.sendRequest()
            //
            //                      } catch {
            //                        print(error.localizedDescription)
            //                      }

            //                        do {
            //                          let request = PlacesDetailsAPI(
            //                            placeId:
            //                              "51a8c64b3789792c40597fdfbf79716e4440c00206e2031e77686f736f6e66697273743a6c6f63616c6974793a313031373532353535"
            //                          )
            //                          try await request.sendRequest()
            //                          print(try await request.responseToJson())
            //                        } catch {
            //                          print(error.localizedDescription)
            //                        }
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