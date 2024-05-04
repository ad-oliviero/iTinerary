import SwiftUI

struct PersonalPreferencesView: View {
  @State private var userPreferences = preferences

  var allChoicesMade: Bool {
    !userPreferences.choices.contains(where: { $0.selectedIndex == nil })
  }

  var body: some View {
    NavigationStack {
      VStack(spacing: 20) {
        Text("Pick one per category")
          .frame(maxWidth: .infinity, alignment: .leading)

        ForEach(userPreferences.choices.indices, id: \.self) { index in
          HStack {
            ForEach(userPreferences.choices[index].options.indices, id: \.self) { optionIndex in
              Button(action: {
                toggleSelection(for: index, optionIndex: optionIndex)
              }) {
                Text(userPreferences.choices[index].options[optionIndex])
                  .foregroundColor(
                    userPreferences.choices[index].selectedIndex == optionIndex ? .white : .blue
                  )
                  .padding()
                  .background(
                    userPreferences.choices[index].selectedIndex == optionIndex
                      ? Color.blue : Color.blue.opacity(0.2)
                  )
                  .cornerRadius(10)
              }
              .buttonStyle(PlainButtonStyle())

              if optionIndex == 0 {
                Text("or")
              }
            }
          }
        }

        Spacer()
      }
      .padding()
      .navigationBarTitle("Personal Preferences")
      .navigationBarItems(
        trailing: Group {
          if allChoicesMade {
            NavigationLink(destination: MainPageView()) {
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
    }
  }

  func toggleSelection(for index: Int, optionIndex: Int) {
    if userPreferences.choices[index].selectedIndex == optionIndex {
      userPreferences.choices[index].selectedIndex = nil
    } else {
      userPreferences.choices[index].selectedIndex = optionIndex
    }
  }
}

#Preview {
  PersonalPreferencesView()
}