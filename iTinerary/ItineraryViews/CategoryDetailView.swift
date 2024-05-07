// CategoryDetailView.swift
import SwiftUI

struct CategoryDetailView: View {
  var selectedCategories: [Category: Bool]
  let category: Category
  let index: Int
  @State var isLoading = false

  init(selectedCategories: [Category: Bool], category: Category, index: Int) {
    self.selectedCategories = selectedCategories
    self.category = category
    self.index = index
  }

  var body: some View {
    NavigationStack {
      VStack {
        if isLoading {
          ProgressView().padding()
        }
        Spacer()
      }
      .navigationTitle(category.rawValue.displayName)
      .navigationBarItems(
        trailing: NavigationLink(
          destination: (selectedCategories.filter { $0.value }.keys.count > index + 1)
            ? AnyView(
              CategoryDetailView(
                selectedCategories: selectedCategories,
                category: selectedCategories.filter { $0.value }.keys.sorted {
                  $0.rawValue.displayName < $1.rawValue.displayName
                }[index + 1], index: index + 1)) : AnyView(RecapView())
        ) {
          HStack {
            Text("Next")
            Image(systemName: "chevron.right")
              .font(.system(size: 15))
              .font(.title)
          }
        }
      )
      .onAppear {
        self.fetchPlaceId(for: sharedCity.creating.name)
      }
    }
  }

  private func fetchPlaceId(for city: String) {
    Task {
      isLoading = true
      do {
        // TODO: va aggiunto un qualcosa da mostrare se la api non ha trovato niente
        let request = try await PlacesAPIRequest(
          placeId: sharedCity.creating.placeId, category: category, limit: 10, offset: 0)
        for idx in 0..<(request.json["features"]! as AnyObject).count {
          print(request.getFromJson(path: "properties/name", index: idx))
        }
      } catch {
        print("Error fetching place ID: \(error)")
      }
      isLoading = false
    }
  }

}

#if DEBUG
  struct CategoryDetailView_Previews: PreviewProvider {
    static var previews: some View {
      CategoryDetailView(selectedCategories: [:], category: .camping, index: 0)
    }
  }
#endif
