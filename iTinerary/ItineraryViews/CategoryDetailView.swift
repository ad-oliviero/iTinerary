import SwiftUI

struct CategoryDetailView: View {
    var selectedCategories: [Category: Bool]
    let categoryName: String
    let index: Int
    
    var body: some View {
        NavigationStack {
            VStack {
              //let request = PlacesAPIRequest(placeId: "yourPlaceId", categories: selectedCategories.keys, conditions: [:], limit: 10, offset: 0)
            }
            .navigationTitle(" \(categoryName.capitalized)")
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
        }
    }
}

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

