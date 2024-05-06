import SwiftUI

struct PersonalPreferencesView: View {
  @State var selectedConditions: [ConditionStruct: Int] = Condition.allCases.reduce(into: [:]) {
    result, category in
    result[category.rawValue] = 0
  }

  var body: some View {
    NavigationStack {
      VStack(spacing: 20) {
        Text("Pick one per category")
          .frame(maxWidth: .infinity, alignment: .leading)

        ForEach(Array(selectedConditions.enumerated()), id: \.element.key) { index, pair in
          let condition = pair.key
          let selected = pair.value
          HStack {
            Button(action: {
              selectedConditions[condition] = (selected == 0 || selected == 2) ? 1 : 0
            }) {
              Text(condition.value.displayName)
                .foregroundColor(selected == 1 ? .white : .blue)
                .padding()
                .background(selected == 1 ? Color.blue : Color.blue.opacity(0.2))
                .cornerRadius(10)
            }
            .buttonStyle(PlainButtonStyle())
            Text("or")
            Button(action: {
              selectedConditions[condition] = (selected == 0 || selected == 1) ? 2 : 0
            }) {
              Text(condition.notValue.displayName)
                .foregroundColor(selected == 2 ? .white : .blue)
                .padding()
                .background(selected == 2 ? Color.blue : Color.blue.opacity(0.2))
                .cornerRadius(10)
            }
            .buttonStyle(PlainButtonStyle())
          }
        }

        Spacer()
      }
      .padding()
      .navigationBarTitle("Personal Preferences")
      .navigationBarItems(
        trailing: Group {
          NavigationLink(destination: MainPageView()) {
            HStack {
              Text("Next")
              Image(systemName: "chevron.right")
                .font(.system(size: 15))
                .font(.title)
            }
          }.disabled(!selectedConditions.values.allSatisfy { $0 != 0 })
        }
      )
    }
  }
}

#Preview {
  PersonalPreferencesView()
}