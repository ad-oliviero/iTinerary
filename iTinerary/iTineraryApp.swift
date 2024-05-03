//
//  iTineraryApp.swift
//  iTravel
//
//  Created by Adriano Oliviero on 03/05/24.
//

import SwiftUI


@main
struct iTineraryApp: App {
    var body: some Scene {
        WindowGroup {
            PersonalInfo()
        }
    }
}

struct ContentView: View {
    var body: some View {
        PersonalInfo()
    }
}

#Preview {
    ContentView()
}