//
//  PreviousView.swift
//  iTravel
//
//  Created by Franklyn Chiemeka Ekoh on 01/05/24.
//

import SwiftUI

struct PreviousView: View {
  var body: some View {
    NavigationStack {

      Text("HEY")
        .navigationTitle("Previous View")
        .navigationBarItems(
          /*leading: NavigationLink(destination: StartOrganizingView()){
                        HStack {
                            Image(systemName: "chevron.left")
                            Text("Back")
                        }
                    }*/
          trailing: NavigationLink(destination: StartOrganizingView()) {
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
  PreviousView()
}