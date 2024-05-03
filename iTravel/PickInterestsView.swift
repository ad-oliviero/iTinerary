//
//  PickInterestsView.swift
//  iTravel
//
//  Created by Daniela Landolfo on 01/05/24.
//

import SwiftUI

struct PickInterestsView: View {
  @State private var selectedCategories: Set<String> = []

  let categories = [
    "activity",
    "adult",
    "beach",
    "building",
    "camping",
    "catering",
    "commercial",
    "education",
    "entertainment",
    "heritage",
    "highway",
    "leisure",
    "man made",
    "natural",
    "pet",
    "production",
    "railway",
    "religion",
    "ski",
    "sport",
    "tourism",
  ]

  var body: some View {
    NavigationStack {
      VStack {
        Text("Select at least 3 categories")
          .frame(maxWidth: .infinity, alignment: .leading).padding()

        ScrollView {
          LazyVGrid(columns: [GridItem(.adaptive(minimum: 100))], spacing: 16) {
            ForEach(categories, id: \.self) { category in
              Button(action: {
                toggleSelection(for: category)
              }) {
                Text(category)
                  .foregroundColor(selectedCategories.contains(category) ? .white : .blue)
                  .padding()
                  .background(
                    selectedCategories.contains(category) ? Color.blue : Color.blue.opacity(0.2)
                  )
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
          Group {
            if selectedCategories.count >= 3 {
              NavigationLink(destination: PersonalPreferencesView()) {
                HStack {
                  Text("Next")
                  Image(systemName: "chevron.right")
                    .font(.system(size: 15))
                    .font(.title)
                }
              }
            } else {

              HStack {
                Text("Next").foregroundColor(.gray)
                Image(systemName: "chevron.right")
                  .font(.system(size: 15))
                  .font(.title).foregroundColor(.gray)
              }
            }
          }
      )

    }  //end nav stack
  }  //end body

  func toggleSelection(for category: String) {
    if selectedCategories.contains(category) {
      selectedCategories.remove(category)
    } else {
      selectedCategories.insert(category)
    }
  }

}

#Preview {
  PickInterestsView()
}