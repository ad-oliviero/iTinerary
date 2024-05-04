//
//  ContentView.swift
//  iTravel
//
//  Created by Franklyn Chiemeka Ekoh on 01/05/24.
//

import SwiftUI

struct ContentView: View {
    
 var myData = sharedData
    
    var body: some View {
        Text("Hello world")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        PersonalInfo()
    }
}
