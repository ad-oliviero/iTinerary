//
//  ProfileStepsView.swift
//  iTravel
//
//  Created by Daniela Landolfo on 30/04/24.
//

import SwiftUI

struct ProfileStepsView: View {
    @State private var action: Int? = 0
    var body: some View {
        NavigationStack{
            VStack {
                
                Image("Image")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .clipShape(Circle())
                    .frame(width: 300, height: 300)
                    .shadow(color: .gray, radius: 10, x: 0, y: 2)
                
                Text("Let's make your experience unforgettable!")
                
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.cyan.opacity(0.2))
                        .frame(width: 300, height: 300)
                    
                    VStack(alignment: .leading){
                        HStack{
                            Image(systemName: "theatermask.and.paintbrush")
                            Text("Pick your interests")
                        }
                        HStack{
                            Image(systemName: "car")
                            Text("Express your travel preferences")
                        }.padding(.top)
                        HStack{
                            Image(systemName: "gym.bag.fill")
                            Text("Start organizing your trip")
                        }.padding(.top)
                        HStack{
                            Image(systemName: "heart")
                            Text("Choose between the options")
                        }.padding(.top)
                        HStack{
                            Image(systemName: "square.and.pencil")
                            Text("Revise and modify your itinerary")
                        }
                        .padding(.top)
                    }
                }
                .padding(.horizontal, 30)
            }
            .navigationBarTitle("Hello!")
            
            
            .navigationBarItems(
                
                trailing: NavigationLink(destination: PickInterestsView()) {
                   
                        HStack{
                            Text("Next")
                            Image(systemName: "chevron.right")
                                .font(.system(size: 15))
                                .font(.title)
                        
                }
                    
                    
                }
            )
            
            
        }
    }
    
}

#Preview {
    ProfileStepsView()
}


