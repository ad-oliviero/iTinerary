//
//  Activity.swift
//  iTravel
//
//  Created by Daniela Landolfo on 04/05/24.
//

import Foundation
import SwiftUI

struct Activity: Identifiable, Hashable {
    var id = UUID()
  
    var place: String = ""
    var starttime: String = ""
    var endtime: String = ""
    var address: String = ""
    var lat: String = ""
    var lon: String = ""
    
    // Metodo per impostare solo il nome del luogo
    mutating func setPlace(_ name: String) {
        self.place = name
    }
}
