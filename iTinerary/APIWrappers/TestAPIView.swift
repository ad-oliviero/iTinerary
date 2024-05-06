//
//  TestAPIView.swift
//  iTravel
//
//  Created by Adriano Oliviero on 30/04/24.
//

import SwiftUI

struct TestData: Codable {
  var name: String
  var id: String
}

struct TestAPIView: View {
  var body: some View {
    NavigationStack {
      VStack {
        Button {
          guard let data = UserDefaults.standard.data(forKey: "testdata") else {
            return
          }
          do {
            let testdata = try JSONDecoder().decode(TestData.self, from: data)
            print(testdata)
          } catch {
            print(error.localizedDescription)
          }
        } label: {
          Text("GET")
        }
        Button {
          do {
            UserDefaults.standard.set(
              try JSONEncoder().encode(TestData(name: "qwertyuiopè", id: "1348t6847y13")),
              forKey: "testdata")
          } catch {
            print(error.localizedDescription)
          }

          //          Task {
          //                        do {
          //                          let request = IsoLinesAPIRequest(
          //                            lat: "40.8358846", lon: "14.2487679", isoType: .isochrone, mode: .car, range: 300)
          //                          try await request.sendRequest()
          //                          print(try await request.responseToJson())
          //                        } catch {
          //                          print(error.localizedDescription)
          //                        }

          //            do {
          //              let request = AutoCompleteAPIRequest(text: "Roma")
          //              try await request.sendRequest()
          //              print(try await request.responseToJson())
          //            } catch {
          //              print(error.localizedDescription)
          //            }

          //            do {
          //              let request = PlacesAPIRequest(
          //                placeId:
          //                  "51a8c64b3789792c40597fdfbf79716e4440c00206e2031e77686f736f6e66697273743a6c6f63616c6974793a313031373532353535",
          //                categories: Category.allCases.map { $0 }, limit: 10, offset: 0)
          //              try await request.sendRequest()
          //              print(try await request.responseToJson())
          //            } catch {
          //              print(error.localizedDescription)
          //            }

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
          //          }
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