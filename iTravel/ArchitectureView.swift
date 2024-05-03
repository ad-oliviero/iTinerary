//
//  ArchitectureView.swift
//  iTravel
//
//  Created by Franklyn Chiemeka Ekoh on 01/05/24.
//

import SwiftUI

struct ArchitectureView: View {
  @State var prize: String = "Prize"
  @State var event: String = "Location to visit"
  @State var time: String = "time"
  var myData = sharedData
  var body: some View {
    NavigationStack {
      Text("Pick the places you’d like to visit:").padding(.leading, -120).padding(.top)
      List {
        ForEach(Array(myData.monuments.enumerated()), id: \.element.id) {
          index, monument in

          Section {
            HStack {
              Button(action: {
                print("Clicked")
                sharedData.monuments[index].isClicked.toggle()

              }) {

                //INSERTING: The name
                Image(systemName: monument.isClicked ? "circle.fill" : "circle")

              }
              Image(monument.image)

              VStack(alignment: .leading) {
                Text(monument.name)
                  .font(.headline)  // You can adjust font size and style as needed
                Text(monument.time)
                  .font(.subheadline)  // You can adjust font size and style as needed
                  .foregroundColor(.gray)  // You can adjust color as needed
              }  //MARK: END VSTACK
              Spacer()  // Add spacer to push the trailing text to the right edge
              Text(monument.prize)
                .font(.caption)  // You can adjust font size and style as needed
                .foregroundColor(.blue)  // You can adjust color as needed

            }
          }  //MARK: END  SECTION 1
        }  //MARK: END  SECTION ForEach

      }

      .navigationTitle("Architecture")
      .navigationBarItems(
        /*leading: NavigationLink(destination: StartOrganizingView()){
                        HStack {
                            Image(systemName: "chevron.left")
                            Text("Back")
                        }
                    }*/
        trailing: NavigationLink(destination: RecapView()) {
          HStack {
            Text("Next")
            Image(systemName: "chevron.right")
          }
        }
      )

    }  // MARK: END NAVSTACK
  }
}

#Preview {
  ArchitectureView()
}