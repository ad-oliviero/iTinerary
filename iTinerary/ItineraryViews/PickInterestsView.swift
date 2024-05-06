import SwiftUI

struct PickInterestsView: View {
    @State var selectedCategories: [String: Bool]
    let selectedCategories_JSON: URL =
        (FileManager.default.urls(
            for: .documentDirectory, in: .userDomainMask
        ).first?.appendingPathComponent("selectedCategories.json"))!

    init() {
        do {
            let data = try Data(contentsOf: selectedCategories_JSON)
            self.selectedCategories = try JSONDecoder().decode([String: Bool].self, from: data)
        } catch {
            print(error.localizedDescription)
            self.selectedCategories = Category.allCases.reduce(into: [:]) {
                result, category in
                result[category.rawValue] = false
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
                            }) {
                                Text(category)
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
                trailing: NavigationLink(destination: SelectedViews(selectedCategories: selectedCategories)) {
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

struct SelectedViews: View {
    var selectedCategories: [String: Bool]

    var body: some View {
        VStack {
          CategoryDetailView(selectedCategories: selectedCategories, categoryName:  selectedCategories.filter { $0.value }.keys.sorted()[0], index: 0)

        }
    }
}


#if DEBUG
struct PickInterestsView_Previews: PreviewProvider {
    static var previews: some View {
        PickInterestsView()
    }
}
#endif
