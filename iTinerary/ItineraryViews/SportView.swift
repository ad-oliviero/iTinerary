//
//  SportView.swift
//  iTravel
//
//  Created by Franklyn Chiemeka Ekoh on 01/05/24.
//

import SwiftUI

struct MyButtonStyle: ButtonStyle {
  var isClicked: Bool

  func makeBody(configuration: Configuration) -> some View {
    configuration.label
      .foregroundColor(isClicked ? .blue : .primary)
      .background(isClicked ? Color.blue.opacity(0.2) : Color.clear)
      .cornerRadius(8)
  }
}
struct SportView: View {
  @State var prize: String = "Prize"
  @State var event: String = "Location to visit"
  @State var typeOfSport: String = "Football"
  var myData = sharedData
  var body: some View {
    NavigationStack {
      Text("Pick the places you’d like to visit:").padding(.leading, -120).padding(.top)
      List {
        ForEach(Array(myData.sports.enumerated()), id: \.element.id) {
          index, sport in

          Section {
            HStack {
              Button(action: {
                print("Clicked", index)
                sharedData.sports[index].isClicked.toggle()

              }) {

                //INSERTING: The name
                Image(systemName: sport.isClicked ? "circle.fill" : "circle")

              }
              Image(sport.image)

              VStack(alignment: .leading) {
                Text(sport.name)
                  .font(.headline)  // You can adjust font size and style as needed
                Text(sport.time)
                  .font(.subheadline)  // You can adjust font size and style as needed
                  .foregroundColor(.gray)  // You can adjust color as needed
              }  //MARK: END VSTACK
              Spacer()  // Add spacer to push the trailing text to the right edge
              Text(sport.prize)
                .font(.caption)  // You can adjust font size and style as needed
                .foregroundColor(.blue)  // You can adjust color as needed

            }
          }  //MARK: END  SECTION 1
        }  //MARK: END ForEach

      }  //MARK: END List

      .navigationTitle("Sport")
      .navigationBarItems(
        /*leading: NavigationLink(destination: StartOrganizingView()){
                        HStack {
                            Image(systemName: "chevron.left")
                            Text("Back")
                        }
                    }*/
        trailing: NavigationLink(destination: ArchitectureView()) {
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
  SportView()
}