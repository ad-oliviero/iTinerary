import SwiftUI

struct PersonalPreferencesView: View {
  @State var selectedConditions: [ConditionStruct: Int]
  let selectedConditions_JSON: URL =
    (FileManager.default.urls(
      for: .documentDirectory, in: .userDomainMask
    ).first?.appendingPathComponent("selectedConditions.json"))!

  init() {
    do {
      let data = try Data(contentsOf: selectedConditions_JSON)
      self.selectedConditions = try JSONDecoder().decode([ConditionStruct: Int].self, from: data)
    } catch {
      print(error.localizedDescription)
      self.selectedConditions = Condition.allCases.reduce(into: [:]) {
        result, category in
        result[category.rawValue] = 0
      }
    }
  }

  var body: some View {
    NavigationStack {
      VStack(spacing: 20) {
        Spacer()
        Text("Express your preferences before starting").font( /*@START_MENU_TOKEN@*/
          .title /*@END_MENU_TOKEN@*/
        ).bold().multilineTextAlignment(.center)
        Text("Pick one per category")
          .frame(maxWidth: .infinity)

        ForEach(Array(selectedConditions.enumerated()), id: \.element.key) { index, pair in
          let condition = pair.key
          let selected = pair.value
          HStack {
            Button(action: {
              selectedConditions[condition] = (selected == 0 || selected == 2) ? 1 : 0
              do {
                let data = try JSONEncoder().encode(selectedConditions)
                try data.write(to: selectedConditions_JSON)
              } catch {
                print(error.localizedDescription)
              }
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
              do {
                let data = try JSONEncoder().encode(selectedConditions)
                try data.write(to: selectedConditions_JSON)
              } catch {
                print(error.localizedDescription)
              }
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

    }
  }
}

#Preview {
  PersonalPreferencesView()
}