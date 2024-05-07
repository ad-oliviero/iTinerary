// CategoryDetailView.swift
import SwiftUI

struct CategoryDetailView: View {
    var selectedCategories: [Category: Bool]
    let categoryName: String
    let index: Int
    @State private var placeId: String = ""
    let myCity = SharedCity()
    
    init(selectedCategories: [Category: Bool], categoryName: String, index: Int) {
        self.selectedCategories = selectedCategories
        self.categoryName = categoryName
        self.index = index
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                // Visualizza il nome della categoria in maiuscolo
                Text(categoryName.capitalized)
                   .navigationTitle(categoryName.capitalized)
                Spacer()
            }
           .navigationBarItems(
                trailing: NavigationLink(destination: NextCategoryDetailView(selectedCategories: selectedCategories, currentIndex: index)) {
                    HStack {
                        Text("Next")
                        Image(systemName: "chevron.right")
                           .font(.system(size: 15))
                           .font(.title)
                    }
                }
            )
           .onAppear {
                self.fetchPlaceId(for: myCity.creating[0].name)
            }
        }
    }
    
  private func fetchPlaceId(for city: String) {
      Task {
          do {
              let request = AutoCompleteAPIRequest(text: city)
              try await request.sendRequest()

              if let firstFeature = try? await request.responseToJson().features?.first {
                  DispatchQueue.main.async {
                      self.placeId = firstFeature.properties?.id ?? ""
                  }
              }

              let request1 = PlacesAPIRequest(placeId: self.placeId, categories: Array(selectedCategories.filter { $0.value }.keys), conditions: [:], limit: 10, offset: 0)
            ///print(request1.response)
          } catch {
              print("Error fetching place ID: \(error)")
          }
      }
  }
  
}

// NextCategoryDetailView.swift
struct NextCategoryDetailView: View {
    var selectedCategories: [Category: Bool]
    let currentIndex: Int
    
    var body: some View {
        let categoryKeys = selectedCategories.filter { $0.value }.keys.sorted { $0.rawValue < $1.rawValue }
        let nextIndex = currentIndex + 1
        if nextIndex < categoryKeys.count {
            let nextCategory = categoryKeys[nextIndex]
            let nextCategoryName = nextCategory.rawValue.displayName
            return AnyView(CategoryDetailView(selectedCategories: selectedCategories, categoryName: nextCategoryName, index: nextIndex))
        } else {
            // Handle if there's no next category
            return AnyView(MainPageView())
        }
    }
}

#if DEBUG
struct CategoryDetailView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryDetailView(selectedCategories: [:], categoryName: "", index: 0)
    }
}
#endif
