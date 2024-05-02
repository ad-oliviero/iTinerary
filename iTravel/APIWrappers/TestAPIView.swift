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
                            let request = IsoLinesRequest(lat: "40.8358846", lon: "14.2487679", isoType: .isochrone, mode: .car, range: 300)
                            try await request.sendRequest()
                            print(try await request.responseToString())
                            //print(try await request.responseToJson())
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
