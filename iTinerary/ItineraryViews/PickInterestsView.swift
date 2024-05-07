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
            ForEach(selectedCategories.keys.sorted { $0.rawValue < $1.rawValue }, id: \.self) {
              category in
              let selected = selectedCategories[category] ?? false
              Button(action: {
                selectedCategories[category]?.toggle()
                saveSelectedCategories()
              }) {
                Text(category.rawValue)
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
        trailing: NavigationLink(
          destination: CategoryDetailView(
            selectedCategories: selectedCategories,
            categoryName: selectedCategories.filter { $0.value }.keys.sorted {
              $0.rawValue < $1.rawValue
            }.first?.rawValue ?? "", index: 0)
        ) {
          HStack {
            Text("Next")
            Image(systemName: "chevron.right")
              .font(.system(size: 15))
              .font(.title)
          }
        }.disabled(selectedCategories.filter { $0.value }.count < 3)
      )
    }
  }

  private func saveSelectedCategories() {
    do {
      let data = try JSONEncoder().encode(selectedCategories)
      try data.write(to: selectedCategories_JSON)
    } catch {
      print(error.localizedDescription)
    }
  }
}

struct PickInterestsView_Previews: PreviewProvider {
  static var previews: some View {
    PickInterestsView()
  }
}