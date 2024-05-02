//
//  TestAPIView.swift
//  iTravel
//
//  Created by Adriano Oliviero on 30/04/24.
//

import SwiftUI

struct TestAPIView: View {
    let utils = CommonAPIUtils()
    var body: some View {
        NavigationStack {
            VStack {
                Button {
                    Task {
                        do {
                            let response = try await utils.responseToDict("https://api.geoapify.com/v2/place-details?id=51068d4fb7a2fb2840594e25034015f24440f00103f901d535815700000000c00201920308436f6c6f7373656f&apiKey=2fd2e15f4fb94d7f90bd4f809e76c302")
                            print(response)
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
