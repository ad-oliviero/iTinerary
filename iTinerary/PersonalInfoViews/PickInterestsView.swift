//
//  PickInterestsView.swift
//  iTravel
//
//  Created by Daniela Landolfo on 01/05/24.
//

import SwiftUI

struct PickInterestsView: View {
  @State var selectedCategories: [Category: Bool]
  let selectedCategories_JSON: URL =
    (FileManager.default.urls(
      for: .documentDirectory, in: .userDomainMask
    ).first?.appendingPathComponent("selectedCategories.json"))!

  init() {
    do {
      let data = try Data(contentsOf: selectedCategories_JSON)
      self.selectedCategories = try JSONDecoder().decode([Category: Bool].self, from: data)
      print(selectedCategories)
    } catch {
      print(error.localizedDescription)
      self.selectedCategories = Category.allCases.reduce(into: [:]) {
        result, category in
        result[category] = false
      }
    }
  }

  var body: some View {
    NavigationStack {
      VStack {
        Text("Select at least 3 categories")
          .frame(maxWidth: .infinity, alignment: .leading)
          .padding()

        ScrollView {
          LazyVGrid(columns: [GridItem(.adaptive(minimum: 100))], spacing: 32) {
            ForEach(Array(selectedCategories.enumerated()), id: \.element.key) { index, pair in
              let category = pair.key
              let selected = pair.value
              Button(action: {
                selectedCategories[category]?.toggle()
                do {
                  let data = try JSONEncoder().encode(selectedCategories)
                  try data.write(to: selectedCategories_JSON)
                } catch {
                  print(error.localizedDescription)
                }

              }) {
                Text(category.rawValue.displayName)
                  .padding()
                  .background(selected ? Color.blue : Color.blue.opacity(0.2))
                  .foregroundColor(selected ? .white : .blue)
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
          }.disabled(selectedCategories.filter { $0.1 }.count < 3)
      )
    }
  }
}

#Preview {
  PickInterestsView()
}