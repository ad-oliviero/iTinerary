//
//  SharedCity.swift
//  iTravel
//
//  Created by Daniela Landolfo on 02/05/24.
//

import SwiftUI
import Observation

@Observable
class SharedCity{
    var done = [City(name: "Barcelona", image: "barcelona"), City(name: "Paris", image: "paris"), City(name: "Milan", image: "milan"), City(name: "London", image: "london"),]
    
    var toDo: [City] = []
    
    var creating: [City] = [City(name: "Rome", image: "rome"),]

}

var sharedCity = SharedCity()
