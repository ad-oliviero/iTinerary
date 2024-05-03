import SwiftUI

struct RecapView: View {
    var myCity = sharedCity
    var itplaces = [
        ["Vatican Museums", "Fortunata Restaurant", "Imperial fora"],
        ["10am : 12am", "10am : 12am", "10am : 12am"],
        ["Vatican Museums", "Fortunata Restaurant", "Imperial fora"],
        ["10am : 12am", "10am : 12am", "10am : 12am"],
        ["Vatican Museums", "Fortunata Restaurant", "Imperial fora"],
        ["10am : 12am", "10am : 12am", "10am : 12am"]
    ]
    
    @State private var isNextViewActive = false 
    
    
    var body: some View {
        NavigationStack{
            VStack{
            List {
                ForEach(0..<(itplaces.count/2), id: \.self) { dayIndex in
                    Section(header: Text("Day \(dayIndex + 1)")) {
                        ForEach(0..<itplaces[dayIndex].count, id: \.self) { activityIndex in
                            HStack {
                                Text(itplaces[dayIndex * 2][activityIndex]) // Attività
                                Spacer()
                                Text(itplaces[dayIndex * 2 + 1][activityIndex])
                                Image(systemName: "chevron.right").foregroundColor(.gray)
                            }
                        }
                    }
                }
            }
            
                Button(action: {
                    myCity.toDo.append(myCity.creating[0])
                    isNextViewActive = true
                }) {
                    HStack{
                        Text("Save")
                        Image(systemName: "square.and.arrow.down")
                    }
                }
                
            }
            
            .listStyle(InsetGroupedListStyle())
            .navigationTitle("Recap of your itinerary")
            .fullScreenCover(isPresented: $isNextViewActive) {
                MainPageView()
            }
        }
    }
}

struct RecapView_Previews: PreviewProvider {
    static var previews: some View {
        RecapView()
    }
}

