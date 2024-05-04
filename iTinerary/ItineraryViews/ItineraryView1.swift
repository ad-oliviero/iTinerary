import SwiftUI

struct ItineraryView1: View {
  var itinerary = CalculatedItinerary()
  @State private var selectedActivityIndex = 0

  var body: some View {
    NavigationStack {
      VStack {
        Text(" ")
        Text(" ")
        Text(" ")
        Text(" ")

        Text("Day \(currentDayIndex() + 1)")
          .font(.headline)
          .padding(.top)

        VStack {
          HStack {
            Button(action: {
              if selectedActivityIndex > 0 {
                selectedActivityIndex -= 1
              }
            }) {
              Image(systemName: "chevron.left")
            }
            .disabled(selectedActivityIndex == 0)

            Spacer()

            // Bordi rotondi
            ZStack(alignment: .bottomLeading) {

              Image("rome")
                .resizable()
                .scaledToFill()
                .frame(width: 300, height: 200)
                .cornerRadius(10).padding(.bottom)

            }
            Spacer()

            Button(action: {
              if selectedActivityIndex < totalActivitiesCount() - 1 {
                selectedActivityIndex += 1
              }
            }) {
              Image(systemName: "chevron.right")
            }
            .disabled(selectedActivityIndex == totalActivitiesCount() - 1)
          }

          Text(currentActivity().place)
            .font(.headline)
          Text("Arriving at: \(currentActivity().starttime)")
          Text("Duration: \(currentActivity().endtime)")
          Text("Address: \(currentActivity().address)")
        }
        .padding()

        Spacer()
      }
      .navigationTitle("Your Itinerary")
    }
  }

  // Restituisce l'indice del giorno corrente
  private func currentDayIndex() -> Int {
    var count = 0
    var dayIndex = 0
    for activities in itinerary.activitiesPerDay {
      count += activities.count
      if selectedActivityIndex < count {
        return dayIndex
      }
      dayIndex += 1
    }
    return dayIndex
  }

  // Restituisce l'indice dell'attività corrente all'interno del giorno corrente
  private func currentActivityIndex() -> Int {
    let dayStartIndex = dayStartIndexes()[currentDayIndex()]
    return selectedActivityIndex - dayStartIndex
  }

  // Restituisce l'attività corrente
  private func currentActivity() -> Activity {
    let dayIndex = currentDayIndex()
    let activityIndex = currentActivityIndex()
    return itinerary.activitiesPerDay[dayIndex][activityIndex]
  }

  // Restituisce un array contenente gli indici di inizio di ciascun giorno nell'elenco delle attività
  private func dayStartIndexes() -> [Int] {
    var indexes = [0]
    var count = 0
    for activities in itinerary.activitiesPerDay {
      count += activities.count
      indexes.append(count)
    }
    return indexes
  }

  // Restituisce il numero totale di attività
  private func totalActivitiesCount() -> Int {
    return itinerary.activitiesPerDay.flatMap { $0 }.count
  }
}

struct ItineraryView1_Previews: PreviewProvider {
  static var previews: some View {
    ItineraryView1()
  }
}