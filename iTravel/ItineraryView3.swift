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
                    NavigationLink(destination: ItineraryView2()) {
                        Image(systemName: "chevron.left")
            
                    }.padding(.leading, -25)
                    Image("Rectangle 5")
                        .aspectRatio(contentMode: .fit)
               
                }
                Image("Frame 3").padding(.top, 40)
                Section{
                    VStack
                    {
                        HStack{
                                Text("Arriving at")
                                .font(.headline)
                            
                            Spacer()
                            
                        }
                    }//MARK: END VSTACK
                       
                    VStack{
                        HStack{
                            Text("Duration")
                                .font(.headline)
                                .fontWeight(.medium) // You can adjust font size and style as needed
                            Text("1h 30min")
                                .font(.subheadline) // You can adjust font size and style as needed
                                .foregroundColor(.gray).padding(.leading, 40) // You can adjust color as needed
                            
                            Spacer() // Add spacer to push the trailing text to the right edge
                            
                        }
                    }
                    //MARK: END VSTACK
                    HStack{
                        
                            Text("Street")
                            .font(.headline)
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
