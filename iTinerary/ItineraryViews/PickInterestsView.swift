import SwiftUI

struct PickInterestsView: View {
  @State var selectedCategories: [Category: Bool] = Dictionary(
    uniqueKeysWithValues: Category.allCases.map { ($0, false) })

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
        trailing: NavigationLink(
          destination: {
            sharedData.itineraries[sharedData.currentIdx].categories = selectedCategories
            return CategoryDetailView(
              selectedCategories: selectedCategories,
              category: selectedCategories.filter { $0.value }.count != 0
                ? selectedCategories.filter { $0.value }.keys.sorted {
                  $0.rawValue.displayName < $1.rawValue.displayName
                }[0] : .tourism, index: 0)
          }()
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
}

struct PickInterestsView_Previews: PreviewProvider {
  static var previews: some View {
    PickInterestsView()
  }
}