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

        Button(action: {
          sharedCity.toDo.append(sharedCity.creating)
          isNextViewActive = true
        }) {
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