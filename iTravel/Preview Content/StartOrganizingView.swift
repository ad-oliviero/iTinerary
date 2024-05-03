import SwiftUI

struct StartOrganizingView: View {
    @State var combinedText = ""
    @State var city = ""
    @State var state = ""
    @State var country = ""
    @State private var isFetchingData = false
    @State private var isErrorOccurred = false

    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                Text("Give us your information")
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
                }.listStyle(InsetGroupedListStyle())
                .navigationTitle("Start organizing")
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



#Preview {
    StartOrganizingView()
}
