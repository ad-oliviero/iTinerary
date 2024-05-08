import SwiftUI

struct MultiDatePicker: View {
  var title: String
  @Binding var startDate: Date
  @Binding var endDate: Date
  var onDurationChanged: (Int) -> Void

  var body: some View {
    VStack {
      Text(title)
        .font(.headline)

      DatePicker("Start Date", selection: $startDate, displayedComponents: .date)

      DatePicker("End Date", selection: $endDate, displayedComponents: .date)
    }
    .onChange(of: startDate) { _, _ in calculateDuration() }
    .onChange(of: endDate) { _, _ in calculateDuration() }
    .onAppear { calculateDuration() }
  }

  private func calculateDuration() {
    let calendar = Calendar.current
    let components = calendar.dateComponents([.day], from: startDate, to: endDate)
    onDurationChanged((components.day ?? 0) + 2)
    print("Duration: \((components.day ?? 0) + 2)")

  }
}

struct StartOrganizingView: View {
  @State var combinedText = ""
  @State var startDate = Date()
  @State var endDate = Date()
  @State var dayCount = 0
  @State var budget = 0
  @State private var isFetchingData = false
  @State private var isErrorOccurred = false
  @State private var isNextViewActive = false

  var body: some View {
    NavigationStack {
      VStack(alignment: .leading) {
        Text("Let's give some information to start organizing your trip")
          .padding(.top).padding(.leading)
        List {
          Section(header: Text("City")) {
            HStack {
              TextField("Enter the city you want to visit", text: $combinedText)
              Button(action: {
                if combinedText.count > 2 {
                  fetchCityData(city: combinedText)
                }
              }) {
                Image(systemName: "magnifyingglass")
              }
              .disabled(combinedText.count <= 2)
            }
          }

          Section(header: Text("Dates")) {
            MultiDatePicker(title: "Select Travel Dates", startDate: $startDate, endDate: $endDate)
            { calculatedDuration in
              self.dayCount = calculatedDuration
            }
          }

          //          Section(header: Text("Budget")) {
          //            TextField("Enter your budget", value: $budget, formatter: NumberFormatter())
          //              .keyboardType(.numberPad)
          //          }
        }.listStyle(InsetGroupedListStyle())
          .navigationTitle("Start organizing!")
          .navigationBarItems(
            trailing: NavigationLink(destination: PickInterestsView(), isActive: $isNextViewActive)
            {
              Button(action: {
                sharedData.itineraries[sharedData.currentIdx].budget = budget
                sharedData.itineraries[sharedData.currentIdx].dayCount = dayCount
                isNextViewActive = true
              }) {
                Text("Next")
                Image(systemName: "chevron.right")
              }
            }
          )
      }
    }
  }

  private func fetchCityData(city: String) {
    isFetchingData = true
    Task {
      do {
        let request = try await AutoCompleteAPIRequest(text: city)
        sharedData.itineraries[sharedData.currentIdx].city.name = request.getFromJson(
          path: "properties/city", index: 0)
        sharedData.itineraries[sharedData.currentIdx].city.placeId = request.getFromJson(
          path: "properties/place_id", index: 0)
        self.combinedText =
          "\(sharedData.itineraries[sharedData.currentIdx].city.name), \(request.getFromJson(path: "properties/state", index: 0)), \(request.getFromJson(path: "properties/country", index: 0))"
        isFetchingData = false
        isErrorOccurred = false
      } catch {
        print(error.localizedDescription)
        isFetchingData = false
        isErrorOccurred = true
      }
    }
  }
}

#Preview {
  StartOrganizingView()
}