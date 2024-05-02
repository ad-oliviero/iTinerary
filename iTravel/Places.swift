//
//  Places.swift
//  iTravel
//
//  Created by Franklyn Chiemeka Ekoh on 01/05/24.
//

import Foundation
import SwiftUI
struct Monument: Identifiable{
    var id = UUID()
    var name: String
    var time: String
    var prize: String
    var image: String
    var isClicked: Bool

}
struct Art: Identifiable{
    var id = UUID()
    var name: String
    var time: String
    var prize: String
    var image: String
    var isClicked: Bool

}

struct Sport: Identifiable{
    var id = UUID()
    var name: String
    var time: String
    var prize: String
    var image: String
    var isClicked: Bool
}
