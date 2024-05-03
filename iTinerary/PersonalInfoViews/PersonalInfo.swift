import SwiftUI

struct PersonalInfo: View {
  @State var name = ""
  @State var birth = ""
  @State var selectedGender = ""
  @State var city = ""
  @State var state = ""
  @State var country = ""
  @State private var isBirthPickerPresented = false
  @State private var isGenderPickerPresented = false
  @State private var isFetchingData = false
  @State private var isErrorOccurred = false
  @State private var combinedText = ""

  var body: some View {

    NavigationView {
      VStack {
        Circle()
          .fill(Color.gray)
          .frame(width: 150, height: 150)
          .shadow(color: Color.black.opacity(0.3), radius: 10, x: 0, y: 5)
          .padding()
        Button(action: {

        }) {
          Text("Add photo")
            .foregroundColor(.white)
            .padding()
            .background(Color.blue)
            .cornerRadius(10)
        }

        Form {
          Section(header: Text("Personal Informations")) {
            HStack {
              Text("Name")
              TextField("Name", text: $name)
            }

            Button(action: {
              self.isBirthPickerPresented = true
            }) {
              Text("Birth").foregroundColor(.black)
            }

            Button(action: {
              self.isGenderPickerPresented = true
            }) {
              HStack {
                Text("Gender").foregroundColor(.black)
                Text(selectedGender).foregroundColor(.gray)
              }
            }

            if isFetchingData {
              Text("Fetching data...")
            } else if isErrorOccurred {
              Text("An error occurred while fetching data.")
                .foregroundColor(.red)
            } else {
              // Mostriamo i dati solo se non ci sono errori e non c'è caricamento dei dati in corso
              HStack {
                TextField("City", text: $combinedText)
                  .onChange(of: combinedText) { newValue in
                    if newValue.count > 2 {
                      fetchCityData(city: newValue)
                    }
                  }
              }
            }
          }
        }
        .navigationTitle("Personal Info")
        .sheet(isPresented: $isBirthPickerPresented) {
          BirthDateSelection()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .presentationDetents([.medium, .large])
        }
        .sheet(isPresented: $isGenderPickerPresented) {
          GenderSelectionView()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .presentationDetents([.height(180), .medium, .large])
        }

        .navigationBarItems(
          trailing: NavigationLink(destination: ProfileStepsView()) {
            HStack {
              Text("Next")
              Image(systemName: "chevron.right")
                .font(.system(size: 15))
                .font(.title)
            }
          }
        )
      }
      .padding()
    }
  }

  // Function to fetch city data
  private func fetchCityData(city: String) {
    print("Fetching data for city: \(city)")

    isFetchingData = true

    Task {
      do {
        let request = AutoCompleteAPIRequest(text: city)
        try await request.sendRequest()
        if let firstFeature = try? await request.responseToJson().features?.first {
          self.city = firstFeature.properties?.city ?? ""
          self.state = firstFeature.properties?.state ?? ""
          self.country = firstFeature.properties?.country ?? ""
          self.combinedText = "\(self.city), \(self.state), \(self.country)"
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

struct PersonalInfo_Previews: PreviewProvider {
  static var previews: some View {
    PersonalInfo()
  }
}