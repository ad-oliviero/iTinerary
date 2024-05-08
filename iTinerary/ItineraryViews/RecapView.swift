import SwiftUI

struct RecapView: View {
  @State private var isNextViewActive = false

  init() {
    sharedData.itineraries[sharedData.currentIdx].splitPlacesInDays()
  }

  var body: some View {
    NavigationStack {
      VStack {
        List {
          ForEach(0..<sharedData.itineraries[sharedData.currentIdx].dayCount, id: \.self) { idx in
            Section(header: Text("Day \(idx + 1)")) {
              ForEach(
                sharedData.itineraries[sharedData.currentIdx].days[idx].sorted {
                  $0.key.name < $1.key.name
                }, id: \.key
              ) { place in
                NavigationLink(destination: ItineraryView1()) {
                  HStack {
                    Text(place.key.name)
                    //                    Spacer()
                    //                    VStack(alignment: .trailing) {
                    //                      Text(String(place.key.durata))
                    //                    }
                  }
                }
              }
            }
          }
        }
        .listStyle(InsetGroupedListStyle())

        Button {
          isNextViewActive = true
          // Getting the city image
          Task {
            let request = try await PlacesDetailsAPIRequest(
              placeId: sharedData.itineraries[sharedData.currentIdx].city.placeId)
            for idx in 0..<(request.json["features"]! as AnyObject).count {
              let wikidataID = request.getFromJson(
                path: "properties/wiki_and_media/wikidata", index: idx)
              let wikidata = try await WikiDataRequest(id: wikidataID)
              try await wikidata.getImage()
              sharedData.itineraries[sharedData.currentIdx].city.image = wikidata.imageName!
              sharedData.save()
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