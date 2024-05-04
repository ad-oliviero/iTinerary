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
        .onChange(of: startDate, perform: { _ in
            calculateDuration()
        })
        .onChange(of: endDate, perform: { _ in
            calculateDuration()
        })
        .onAppear {
            calculateDuration()
        }
    }
    
    private func calculateDuration() {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.day], from: startDate, to: endDate)
        if let days = components.day {
            onDurationChanged(days + 1) // Include anche l'ultimo giorno nel conteggio
        } else {
            onDurationChanged(0)
        }
    }
}

struct StartOrganizingView: View {
    var myCity = SharedCity()
    @State var combinedText = ""
    @State var city = ""
    @State var state = ""
    @State var country = ""
    @State var startDate = Date()
    @State var endDate = Date()
    @State var duration = 0
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
                        HStack{
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
                        MultiDatePicker(title: "Select Travel Dates", startDate: $startDate, endDate: $endDate) { calculatedDuration in
                            self.duration = calculatedDuration
                        }
                    }
                    
                    Section(header: Text("Budget")) {
                        TextField("Enter your budget", value: $budget, formatter: NumberFormatter())
                            .keyboardType(.numberPad)
                    }
                }.listStyle(InsetGroupedListStyle())
                .navigationTitle("Start organizing!")
                .navigationBarItems(
                    trailing: NavigationLink(destination: ArtView(), isActive: $isNextViewActive) {
                        Button(action: {
                            // Aggiungi direttamente la città al modello condiviso
                            myCity.creating = [City(name: city, image: city, budget: budget, durata: duration)]
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
        print("Fetching data for city: \(city)")

        isFetchingData = true
        
        Task {
            do {
                let request = AutoCompleteAPIRequest(text: city)
                try await request.sendRequest()
                if let firstFeature = try? await request.responseToJson().features?.first {
                    DispatchQueue.main.async {
                        self.city = firstFeature.properties?.city ?? ""
                        self.state = firstFeature.properties?.state ?? ""
                        self.country = firstFeature.properties?.country ?? ""
                        self.combinedText = "\(self.city), \(self.state), \(self.country)"
                    }
                }
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

#Preview{
        StartOrganizingView()
}

