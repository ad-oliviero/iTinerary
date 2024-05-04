//
//  PickInterestsView.swift
//  iTravel
//
//  Created by Daniela Landolfo on 01/05/24.
//

import SwiftUI

struct PickInterestsView: View {
  @ObservedObject var userCat = Categories()
  let allCategories = [
    "activity", "adult", "beach", "building", "camping", "catering", "commercial",
    "education", "entertainment", "heritage", "highway", "leisure", "manMade", "natural",
    "pet", "production", "railway", "religion", "ski", "sport", "tourism",
  ]

  var body: some View {
    NavigationStack {
      VStack {
        Text("Select at least 3 categories")
          .frame(maxWidth: .infinity, alignment: .leading)
          .padding()

        ScrollView {
          LazyVGrid(columns: [GridItem(.adaptive(minimum: 100))], spacing: 16) {
            ForEach(allCategories, id: \.self) { category in
              Button(action: {
                toggleSelection(for: category)
              }) {
                Text(category)
                  .padding()
                  .background(
                    userCat.selectedCategories.contains(category)
                      ? Color.blue : Color.blue.opacity(0.2)
                  )
                  .foregroundColor(userCat.selectedCategories.contains(category) ? .white : .blue)
                  .cornerRadius(10)
              }
              .buttonStyle(PlainButtonStyle())
            }
          }
          .padding()
        }

        Spacer()
      }
      .navigationBarTitle("Pick your interests")
      .navigationBarItems(
        trailing:
          NavigationLink(destination: PersonalPreferencesView()) {
            HStack {
              Text("Next")
              Image(systemName: "chevron.right")
                .font(.system(size: 15))
                .font(.title)
            }
          }
          .disabled(userCat.selectedCategories.count < 3)
      )
    }
  }

  func toggleSelection(for category: String) {
    userCat.toggleCategory(category)
  }
}

#Preview {
  PickInterestsView()
}