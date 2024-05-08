import SwiftUI

struct CategoryDetailView: View {
  var selectedCategories: [Category: Bool]
  let category: Category
  let index: Int
  @State var isLoading = false
  @State var selectedPlaces: [(Place, Bool)] = []

  init(selectedCategories: [Category: Bool], category: Category, index: Int) {
    self.selectedCategories = selectedCategories
    self.category = category
    self.index = index
  }

  var body: some View {
    VStack {
      if isLoading {
        ProgressView().padding()
      } else {
        List {
          ForEach(selectedPlaces.indices, id: \.self) { idx in
            let place = selectedPlaces[idx].0
            HStack {
              Button(action: {
                if sharedData.itineraries[sharedData.currentIdx].allPlaces.contains(
                  selectedPlaces[idx].0)
                {
                  selectedPlaces[idx].1 = false
                  sharedData.itineraries[sharedData.currentIdx].allPlaces.removeAll(where: {
                    $0 == selectedPlaces[idx].0
                  })
                } else {
                  selectedPlaces[idx].1 = true
                  sharedData.itineraries[sharedData.currentIdx].allPlaces.append(
                    selectedPlaces[idx].0)
                }
              }) {
                Image(
                  systemName: selectedPlaces[idx].1 ? "checkmark.circle.fill" : "circle")
              }
              Text(place.name)
                .onTapGesture {
                  //                            ActivityView(activity: activity)
                }
            }
          }
        }
        .padding()
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
    .onAppear { self.fetchPlaceId() }
  }

  private func fetchPlaceId() {
    Task {
      isLoading = true
      do {
        let request = try await PlacesAPIRequest(
          placeId: sharedData.itineraries[sharedData.currentIdx].city.placeId, category: category,
          limit: 10, offset: 0)
        if request.json["features"] == nil {
          isLoading = false
          return
        }
        for idx in 0..<(request.json["features"]! as AnyObject).count {
          let placeName = request.getFromJson(path: "properties/name", index: idx)
          let placeId = request.getFromJson(path: "properties/place_id", index: idx)
          selectedPlaces.append(
            (Place(name: placeName, image: "", placeId: placeId, category: category), false))
        }
      } catch {
        print("Error fetching place ID: \(error)")
      }
      isLoading = false
    }
  }
}

struct CategoryDetailView_Previews: PreviewProvider {
  static var previews: some View {
    CategoryDetailView(selectedCategories: [:], category: .camping, index: 0)
  }
}