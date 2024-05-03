//
//  BirthDateSelection.swift
//  iTravel
//
//  Created by Antonella Loffredo on 02/05/24.
//

import SwiftUI

struct BirthDateSelection: View {
    @State private var selectedDate = Date()
    
    var body : some View {
        VStack {
                    DatePicker("Select your birth date", selection: $selectedDate, in: ...Date(), displayedComponents: .date)
                        .datePickerStyle(GraphicalDatePickerStyle())
                        .padding()
                    
                    
                }
        
        
    }
        
}

#Preview {
    BirthDateSelection()
}
