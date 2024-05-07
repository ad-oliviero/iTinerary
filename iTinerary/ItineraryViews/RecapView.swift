import SwiftUI

struct RecapView: View {
  var itinerary = CalculatedItinerary()
  @State private var isNextViewActive = false
  var myCity = sharedCity.creating
  var duration = sharedCity.creating.durata

  var body: some View {
    NavigationStack {
      VStack {
        List {
          ForEach(0..<itinerary.activitiesPerDay.count, id: \.self) { dayIndex in
            Section(header: Text("Day \(dayIndex + 1)")) {
              ForEach(itinerary.activitiesPerDay[dayIndex], id: \.self) { activity in
                NavigationLink(destination: ItineraryView1()) {
                  HStack {
                    Text(activity.place)
                    Spacer()
                    VStack(alignment: .trailing) {
                      Text(activity.starttime)
                      Text(activity.endtime)
                    }
                  }
                }
              }
            }
          }
        }
        .listStyle(InsetGroupedListStyle())

        Button {
          sharedCity.toDo.append(sharedCity.creating)
          sharedCity.creating = City()

          isNextViewActive = true
          // Getting the city image
          Task {
            let request = try await PlacesDetailsAPIRequest(placeId: sharedCity.toDo.last!.placeId)
            for idx in 0..<(request.json["features"]! as AnyObject).count {
              let wikidataID = request.getFromJson(
                path: "properties/wiki_and_media/wikidata", index: idx)
              let wikidata = try await WikiDataRequest(id: wikidataID)
              try await wikidata.getImage()
              sharedCity.toDo[sharedCity.toDo.count - 1].image = wikidata.imageName!
            }
          }
        } label: {
          HStack {
            Text("Save")
            Image(systemName: "square.and.arrow.down")
          }
        }
        .navigationTitle("Recap of your itinerary")
        .fullScreenCover(isPresented: $isNextViewActive) {
          MainPageView()
        }
      }
    }
  }
}

struct RecapView_Previews: PreviewProvider {
  static var previews: some View {
    RecapView()
  }
}