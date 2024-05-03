//
//  GenderSelection.swift
//  iTravel
//
//  Created by Antonella Loffredo on 02/05/24.
//

import SwiftUI

struct GenderSelectionView: View {
  @State var selectedGender: String = "Male"

  var body: some View {
    VStack(alignment: .leading) {
      Text("Select Gender")
        .font(.headline)
        .padding(.bottom)

      Button(action: {
        self.selectedGender = "Female"
      }) {
        Text("Female")
          .foregroundColor(.blue)
        if self.selectedGender == "Female" {
          Image(systemName: "checkmark")
            .foregroundColor(.blue)
        }
      }
      .padding(.bottom)

      Button(action: {
        self.selectedGender = "Male"
      }) {
        Text("Male")
          .foregroundColor(.blue)
        if self.selectedGender == "Male" {
          Image(systemName: "checkmark")
            .foregroundColor(.blue)
        }
      }
      .padding(.bottom)

      Button(action: {
        self.selectedGender = "Other"
      }) {
        Text("Other")
          .foregroundColor(.blue)
        if self.selectedGender == "Other" {
          Image(systemName: "checkmark")
            .foregroundColor(.blue)
        }
      }
      Spacer()
    }
    .padding()
  }
}

#Preview {
  GenderSelectionView()
}