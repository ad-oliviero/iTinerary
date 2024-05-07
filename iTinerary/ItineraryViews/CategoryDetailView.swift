import SwiftUI

struct CategoryDetailView: View {
    var selectedCategories: [Category: Bool]
    let category: Category
    let index: Int
    @State var isLoading = false
    @State var activityList = selected
    @State var selectedActivities: Set<Activity> = []

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
                  ForEach(selected.list.indices, id: \.self) { index in
                        let activity = selected.list[index]
                        HStack {
                            Button(action: {
                                toggleSelection(for: activity)
                            }) {
                                Image(systemName: selectedActivities.contains(activity) ? "checkmark.circle.fill" : "circle")
                            }
                            Text(activity.place)
                                .onTapGesture {
                                  ActivityView(activity: activity)
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
        .onAppear {
            self.fetchPlaceId(for: sharedCity.creating.name)
        }
    }

    private func fetchPlaceId(for city: String) {
        Task {
            isLoading = true
            do {
                let request = try await PlacesAPIRequest(
                    placeId: sharedCity.creating.placeId, category: category, limit: 10, offset: 0)
                var activities: [Activity] = []
                for idx in 0..<(request.json["features"]! as AnyObject).count {
                    let placeNames = request.getFromJson(path: "properties/name", index: idx).components(separatedBy: "\n")
                  let placeLat = request.getFromJson(path: "properties/lat", index: idx).components(separatedBy: "\n")
                  let placeLon = request.getFromJson(path: "properties/lon", index: idx).components(separatedBy: "\n")
                  
                    for name in placeNames {
                        activities.append(Activity(place: name))
                    }
                  for (i,lat) in placeLat.enumerated(){
                    activities[i].lat = lat
                  }
                  for (i,lon) in placeLon.enumerated(){
                    activities[i].lon = lon
                  }
                  
                }
              activityList.list.append(contentsOf: activities)
            } catch {
                print("Error fetching place ID: \(error)")
            }
            isLoading = false
        }
    }


    private func toggleSelection(for activity: Activity) {
        if selectedActivities.contains(activity) {
            selectedActivities.remove(activity)
        } else {
            selectedActivities.insert(activity)
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
