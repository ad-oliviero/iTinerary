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
                            //let request = IsoLinesRequest(lat: "40.8358846", lon: "14.2487679", isoType: .isochrone, mode: .car, range: 300)
//                            let request = AutoCompleteAPIRequest(text: "Napoli, Naples, Napoli, Italy")
//                            let request = PlacesAPIRequest(placeId: "51a8c64b3789792c40597fdfbf79716e4440c00206e2031e77686f736f6e66697273743a6c6f63616c6974793a313031373532353535", categories: [.commercial, .activity])
                            let request = PlacesDetailsAPI(placeId: "51a8c64b3789792c40597fdfbf79716e4440c00206e2031e77686f736f6e66697273743a6c6f63616c6974793a313031373532353535")
                            try await request.sendRequest()
                            print(try await request.responseToString())
//                            print(try await request.responseToJson())
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
