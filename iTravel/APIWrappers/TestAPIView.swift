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
                            let request = AutoComplete(text: "Napo")
                            try await request.sendRequest()
                            //print(try await request.responseToString())
                            print(try await request.responseToJson())
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
