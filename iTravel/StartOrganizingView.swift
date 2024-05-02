//
//  StartOrganizingView.swift
//  iTravel
//
//  Created by Franklyn Chiemeka Ekoh on 30/04/24.
//

import SwiftUI

struct StartOrganizingView: View {
    @State var Dates: String = ""
    @State var Budget: String = ""
    @State var City: String = ""
    var body: some View {
        NavigationStack{
                Text("Give use your information").padding(.leading, -155 ).padding(.top)
                List {
                    
                    Section{
                        HStack{
                            Image(systemName: "dollarsign.circle")
                                .padding(0.0)
                            Text("Budget")
                                .padding(0.0)
                            
                            
                            
                            TextField("value", text: $Budget).padding(.leading)
                            
                            
                        }//MARK: END HSTACK
                    }//MARK: END  SECTION 1
                    
                    Section{
                        HStack{
                            Image(systemName: "calendar")
                                .padding(0.0)
                            Text("Dates")
                                .padding(.trailing, 10)
                            
                            
                            
                            TextField("value", text: $Dates).padding(.leading)
                            
                            
                        }//MARK: END HSTACK
                    }//MARK: END  SECTION 2
                    
                    Section{
                        HStack{
                            Image(systemName: "calendar")
                                .padding(0.0)
                            Text("City")
                                .padding(.trailing, 25)
                            
                            
                            
                            TextField("value", text: $City).padding(.leading)
                            
                            
                        }//MARK: END HSTACK
                    }//MARK: END  SECTION 3
                    
                }.listStyle(InsetGroupedListStyle())
                
                //MARK: END  LIST
                // Remove padding from the list
                    .navigationTitle("Start organizing")
                    .navigationBarItems(
                        /*
                         leading: NavigationLink(destination: PreviousView()){
                         HStack {
                         Image(systemName: "chevron.left")
                         Text("Back")
                         }
                         }*/
                        trailing: NavigationLink(destination: ArtView()) {
                            HStack {
                                Text("Next")
                                Image(systemName: "chevron.right")
                            }
                        }
                        
                    )
                
        }// MARK: END NAVSTACK
    }
}

#Preview {
    StartOrganizingView()
}
