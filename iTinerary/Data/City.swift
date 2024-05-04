//
//  CIty.swift
//  iTravel
//
//  Created by Daniela Landolfo on 02/05/24.
//

import Foundation
import SwiftUI

struct City: Identifiable {
  var id = UUID()
  var name: String
  var image: String
  var date: Date = Date()
  var budget: Int = 0
  var durata: Int = 0
  var isDone: Bool = false
}