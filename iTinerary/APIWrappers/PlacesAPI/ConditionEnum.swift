//
//  ConditionEnum.swift
//  iTravel
//
//  Created by Adriano Oliviero on 02/05/24.
//

import Foundation

enum Condition: String, CaseIterable {
    case access = "access"
    case dogs = "dogs"
    case no_dogs = "no_dogs"
    case dogs_yes = "dogs.yes"
    case gluten_free = "gluten_free"
    case vegan = "vegan"
    case vegan_only = "vegan.only"
    case wheelchair_limited = "wheelchair.limited"
    case wheelchair_yes = "wheelchair.yes"
}
