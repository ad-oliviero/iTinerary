import PhotosUI
import SwiftUI

struct PersonalInfo: View {
  @State private var selectedImageItem: PhotosPickerItem? = nil
  @State private var selectedImageData: Data? = nil
  @State var name = ""
  @State var birth = Date()
  @State var selectedGender = "Your gender"
  @State var city = ""
  @State var state = ""
  @State var country = ""
  @State private var isGenderPickerPresented = false
  @State private var isFetchingData = false
  @State private var isErrorOccurred = false
  @State private var combinedText = ""

  var body: some View {

    NavigationStack {
      VStack {
        if selectedImageData != nil {
          let uiImage = UIImage(data: selectedImageData!)!
          Image(uiImage: uiImage)
            .resizable()
            .aspectRatio(contentMode: .fill)
            .shadow(color: .black.opacity(0.4), radius: 10, x: 0, y: 5)
            .clipShape(Circle())
            .frame(width: 150, height: 150)
        } else {
          Circle()
            .fill(
              LinearGradient(
                colors: [Color.white, Color.black.opacity(0)], startPoint: .top, endPoint: .bottom)
            )
            .frame(width: 150, height: 150)
        }
        PhotosPicker(
          selection: $selectedImageItem,
          matching: .images,
          photoLibrary: .shared()
        ) {
          Text(selectedImageData == nil ? "Add photo" : "Change photo")
            .foregroundColor(.blue)
            .padding()
        }
        .onChange(of: selectedImageItem) { newItem, oldItem in
          Task {
            if let data = try? await newItem?.loadTransferable(type: Data.self) {
              selectedImageData = data
            }
          }
        }

        Form {
          Section(header: Text("Personal Informations")) {
            HStack {
              Text("Name")
              TextField("Your name", text: $name)
            }

            DatePicker(
              "Birth", selection: $birth, in: ...Date(),
              displayedComponents: .date
            ).fixedSize()

            HStack {
              Text("Gender")
              Text(selectedGender).onTapGesture(perform: {
                self.isGenderPickerPresented = true
              }).foregroundStyle(selectedGender == "Your gender" ? .tertiary : .primary)
            }
            if isFetchingData {
              Text("Fetching data...")
            } else if isErrorOccurred {
              Text("An error occurred while fetching data.")
                .foregroundColor(.red)
            } else {
              // Mostriamo i dati solo se non ci sono errori e non c'è caricamento dei dati in corso
              HStack {
                Text("City")
                TextField("Your city", text: $combinedText)
                //                  .onChange(of: combinedText) { newValue in
                //                    if newValue.count > 2 {
                //                      fetchCityData(city: newValue)
                //                    }
                //                  }
              }
            }
          }
        }
        .navigationTitle("Personal Info")
        .confirmationDialog(
          "Select Your Gender", isPresented: $isGenderPickerPresented,
          actions: {
            Button("Male") { self.selectedGender = "Male" }
            Button("Female") { self.selectedGender = "Female" }
            Button("Other") { self.selectedGender = "Other" }
          }
        )
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