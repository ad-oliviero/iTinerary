//
//  CalculatedItinerary.swift
//  iTravel
//
//  Created by Daniela Landolfo on 04/05/24.
//

import Foundation
import SwiftUI
@Observable
class CalculatedItinerary: ObservableObject {
    var activitiesPerDay: [[Activity]] = []
    
    init() {
        
        for _ in 1...3 { // Il 3 andrebbe cambiato con la data del viaggio dell'utente
            activitiesPerDay.append([])
        }
        
        // Aggiungi attività di esempio
        activitiesPerDay[0].append(Activity(place: "Vatican Museums", starttime: "10am", endtime: "12am", address: "Vatican City"))
        activitiesPerDay[0].append(Activity(place: "Fortunata Restaurant", starttime: "1pm", endtime: "3pm", address: "Rome"))
        activitiesPerDay[0].append(Activity(place: "Imperial Fora", starttime: "4pm", endtime: "6pm", address: "Rome"))
        
        activitiesPerDay[1].append(Activity(place: "Colosseum", starttime: "10am", endtime: "12am", address: "Rome"))
        activitiesPerDay[1].append(Activity(place: "Pantheon", starttime: "1pm", endtime: "3pm", address: "Rome"))
        
        activitiesPerDay[2].append(Activity(place: "Trevi Fountain", starttime: "10am", endtime: "12am", address: "Rome"))
        activitiesPerDay[2].append(Activity(place: "Spanish Steps", starttime: "1pm", endtime: "3pm", address: "Rome"))
        activitiesPerDay[2].append(Activity(place: "Piazza Navona", starttime: "4pm", endtime: "6pm", address: "Rome"))
    }
}


var Itinerary = CalculatedItinerary()
