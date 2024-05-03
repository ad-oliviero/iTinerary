//
//  ItineraryView3.swift
//  iTravel
//
//  Created by Franklyn Chiemeka Ekoh on 02/05/24.
//

import SwiftUI

struct ItineraryView3: View {
    var myData = sharedData
    @State var selectedDate = Date()// State variable to store selected date
    @State var Lunch: String = "Lunch Time"
    var body: some View {
        NavigationStack {
            VStack {
                RoundedRectangle(cornerRadius: 10)
                    .foregroundColor(Color.white)
                    .frame(height: 30)
                    .overlay(
                        HStack {
                            Text(Lunch) .font(.headline)
                            Text(selectedDate, style: .date)
                                .font(.headline)
                            Text(selectedDate, style: .time)
                                .font(.headline)
                            
                        }
                            .padding(.bottom, 100)
                    )
                
                HStack{
                    Image("Rectangle 5")
                        .aspectRatio(contentMode: .fit)
               
                }
                Image("Frame 3").padding(.top, 40)
                Section{
                    VStack
                    {
                        HStack{
                                Text("Airport")
                                .font(.headline)
                                .fontWeight(.medium)
                                Text("Roma Fiumicino")
                                    .font(.subheadline)
                                    .foregroundColor(.gray).padding(.leading, 30)
                            
                            Spacer()
                            
                        }
                    }//MARK: END VSTACK
                    HStack{
                        
                            Text("Arriving at")
                            .font(.headline)
                            .fontWeight(.medium)
                            Text("12 PM")
                                .font(.subheadline)
                                .foregroundColor(.gray).padding(.leading, 30)

                        Spacer()
                        
                    }
                }.padding(.top, 20).padding(.leading, 40) //MARK: END  SECTION 1
            }.padding(.top, -70)
                  .navigationTitle("Your itinerary")
                  .padding()
            
              }
              .ignoresSafeArea()
        
    }
}

#Preview {
    ItineraryView3()
}
