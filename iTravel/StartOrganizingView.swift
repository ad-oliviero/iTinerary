import SwiftUI

struct StartOrganizingView: View {
    var myCity = SharedCity()
    @State var Dates: Set<DateComponents> = []
    @State var Budget: String = ""
    @State var city: String = ""
    @State private var isNextViewActive = false // Stato per controllare la navigazione
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                Text("Give us your information")
                    .padding(.top).padding(.leading)
                List {
                    Section(header: Text("City")) {
                        TextField("Enter the city you want to visit", text: $city)
                    }
                    
                    Section(header: Text("Dates")) {
                        MultiDatePicker("Dates Available", selection: $Dates)
                    }
                    Section(header: Text("Budget")) {
                        TextField("Enter your budget", text: $Budget)
                    }
                }
                .listStyle(InsetGroupedListStyle())
                .navigationTitle("Start Organizing")
                .navigationBarItems(
                    trailing: NavigationLink(destination: ArtView(), isActive: $isNextViewActive) {
                        Button(action: {
                            // Aggiungi direttamente la città al modello condiviso
                            myCity.creating = [City(name: city, image: city)]
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
}

struct StartOrganizingView_Previews: PreviewProvider {
    static var previews: some View {
        StartOrganizingView()
    }
}


