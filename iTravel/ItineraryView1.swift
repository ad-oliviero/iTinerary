//
//  ItineraryView1.swift
//  iTravel
//
//  Created by Franklyn Chiemeka Ekoh on 02/05/24.
//

import SwiftUI

struct ItineraryView1: View {
    var myData = sharedData
    @State var selectedDate = Date()// State variable to store selected date
    @State var city: String = "Rome"
    var body: some View {
        NavigationStack {
            VStack {
                RoundedRectangle(cornerRadius: 10)
                    .foregroundColor(Color.white) // Background color of the rectangle
                    .frame(height: 30) // Adjust height of the rectangle
                    .overlay(
                        HStack {
                            Text(city) .font(.headline) // Adjust font size and style
                            Text(selectedDate, style: .date).font(.headline) // Display only date
                            Text(selectedDate, style: .time) // Display only time
                                .font(.headline) // Adjust font size and style
                            
                        }
                            .padding(.bottom, 100) // Add padding to the content inside the rectangle
                    )
                
                HStack{
                    Image("Rectangle 3")
                        .aspectRatio(contentMode: .fit)
                    
                    NavigationLink(destination: ItineraryView2()) {
                        Image(systemName: "chevron.right")
            
                    }
                    .padding(.leading, 5) // Add padding to separate the NavigationLink from the image
                    .padding(.trailing,-70) // Add trailing padding to the NavigationLink
                }
                Image("Frame 1").padding(.top, 60)
                Section{
                    VStack
                    {
                        HStack{
                                Text("Airport")
                                .font(.headline)
                                .fontWeight(.medium) // You can adjust font size and style as needed
                                Text("Roma Fiumicino")
                                    .font(.subheadline) // You can adjust font size and style as needed
                                    .foregroundColor(.gray).padding(.leading, 30) // You can adjust color as needed
                            
                            Spacer() // Add spacer to push the trailing text to the right edge
                            
                        }
                    }//MARK: END VSTACK
                    HStack{
                        
                            Text("Arriving at")
                            .font(.headline)
                            .fontWeight(.medium) // You can adjust font size and style as needed
                            Text("12 PM")
                                .font(.subheadline) // You can adjust font size and style as needed
                                .foregroundColor(.gray).padding(.leading, 30) // You can adjust color as needed

                        Spacer() // Add spacer to push the trailing text to the right edge
                        
                    }
                }.padding(.top, 20).padding(.leading, 40) //MARK: END  SECTION 1
            }.padding(.top, -70)
                  .navigationTitle("Your itinerary")
                  .padding() // Add padding to the entire VStack
              }
              .ignoresSafeArea() // Ignore safe area to cover the entire screen
    }
}

#Preview {
    ItineraryView1()
}
