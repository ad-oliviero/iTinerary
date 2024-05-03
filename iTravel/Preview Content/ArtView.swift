//
//  ArtView.swift
//  iTravel
//
//  Created by Franklyn Chiemeka Ekoh on 01/05/24.
//

import SwiftUI

struct ArtView: View {
    @State var prize: String = "Prize"
    @State var place:String  = "Location to visit"
    @State var time: String  = "time"
    var myData = sharedData
    var body: some View {
        NavigationStack{
            Text("Pick the places you’d like to visit:").padding(.leading, -120 ).padding(.top)
            List{
                ForEach(Array(myData.arts.enumerated()), id: \.element.id){
                   index, art in
                    
                    Section{
                        HStack{
                            Button(action:{
                                sharedData.arts[index].isClicked.toggle()
                                            
                                
                            }){
                                //INSERTING: The name
                                Image(systemName: art.isClicked ? "circle.fill": "circle")
                            }
                            Image(art.image)
                            //NavigationLink(destination: VaticanView()) {}
                            VStack(alignment: .leading) {
                                Text(art.name)
                                    .font(.headline) // You can adjust font size and style as needed
                                Text(art.time)
                                    .font(.subheadline) // You can adjust font size and style as needed
                                    .foregroundColor(.gray) // You can adjust color as needed
                            } //MARK: END VSTACK
                            Spacer() // Add spacer to push the trailing text to the right edge
                            Text(art.prize)
                                .font(.caption) // You can adjust font size and style as needed
                                .foregroundColor(.blue) // You can adjust color as needed
                        }
                        
                    }//MARK: END  SECTION
                }
            } //MARK: End List
            
            
                .navigationTitle("Art")
                .navigationBarItems(
                    /*leading: NavigationLink(destination: StartOrganizingView()){
                        HStack {
                            Image(systemName: "chevron.left")
                            Text("Back")
                        }
                    }*/
                    trailing: NavigationLink(destination: SportView()) {
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
    ArtView()
}
