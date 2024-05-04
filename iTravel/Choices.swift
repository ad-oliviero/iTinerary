//
//  choices.swift
//  iTravel
//
//  Created by Daniela Landolfo on 04/05/24.
//

import Foundation

class Categories: ObservableObject {
    @Published var activity: Bool = false
    @Published var adult: Bool = false
    @Published var beach: Bool = false
    @Published var building: Bool = false
    @Published var camping: Bool = false
    @Published var catering: Bool = false
    @Published var commercial: Bool = false
    @Published var education: Bool = false
    @Published var entertainment: Bool = false
    @Published var heritage: Bool = false
    @Published var highway: Bool = false
    @Published var leisure: Bool = false
    @Published var manMade: Bool = false
    @Published var natural: Bool = false
    @Published var pet: Bool = false
    @Published var production: Bool = false
    @Published var railway: Bool = false
    @Published var religion: Bool = false
    @Published var ski: Bool = false
    @Published var sport: Bool = false
    @Published var tourism: Bool = false
    
    var selectedCategories: Set<String> {
        var selected: Set<String> = []
        if activity { selected.insert("activity") }
        if adult { selected.insert("adult") }
        if beach { selected.insert("beach") }
        if building { selected.insert("building") }
        if camping { selected.insert("camping") }
        if catering { selected.insert("catering") }
        if commercial { selected.insert("commercial") }
        if education { selected.insert("education") }
        if entertainment { selected.insert("entertainment") }
        if heritage { selected.insert("heritage") }
        if highway { selected.insert("highway") }
        if leisure { selected.insert("leisure") }
        if manMade { selected.insert("manMade") }
        if natural { selected.insert("natural") }
        if pet { selected.insert("pet") }
        if production { selected.insert("production") }
        if railway { selected.insert("railway") }
        if religion { selected.insert("religion") }
        if ski { selected.insert("ski") }
        if sport { selected.insert("sport") }
        if tourism { selected.insert("tourism") }
        return selected
    }
    
    func toggleCategory(_ category: String) {
        switch category {
            case "activity": activity.toggle()
            case "adult": adult.toggle()
            case "beach": beach.toggle()
            case "building": building.toggle()
            case "camping": camping.toggle()
            case "catering": catering.toggle()
            case "commercial": commercial.toggle()
            case "education": education.toggle()
            case "entertainment": entertainment.toggle()
            case "heritage": heritage.toggle()
            case "highway": highway.toggle()
            case "leisure": leisure.toggle()
            case "manMade": manMade.toggle()
            case "natural": natural.toggle()
            case "pet": pet.toggle()
            case "production": production.toggle()
            case "railway": railway.toggle()
            case "religion": religion.toggle()
            case "ski": ski.toggle()
            case "sport": sport.toggle()
            case "tourism": tourism.toggle()
            default: break
        }
    }
}


var categories = Categories()




struct Choice {
    let options: [String]
    var selectedIndex: Int? = nil
}

struct UserPreferences {
    var choices: [Choice] = [
        Choice(options: ["Adventure", "Relax"]),
        Choice(options: ["Public transport", "Private transport"]),
        Choice(options: ["Local cuisine", "International cuisine"]),
        Choice(options: ["Animals", "No Animals"]),
        Choice(options: ["Wheelchair", "No Wheelchair"]),
        Choice(options: ["No vegan", "Vegan"]),
        Choice(options: ["Gluten Free", "With Gluten"])
    ]
}

var preferences = UserPreferences()
