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
                    
                    Section{
                        HStack{
                            Image(systemName: "dollarsign.circle")
                                .padding(0.0)
                            Text("Budget")
                                .padding(0.0)
                            
                            
                            
                            TextField("value", text: $Budget).padding(.leading)
                            
                            
                        }//MARK: END HSTACK
                    }//MARK: END  SECTION 1
                    
                    Section{
                        HStack{
                            Image(systemName: "calendar")
                                .padding(0.0)
                            Text("Dates")
                                .padding(.trailing, 10)
                            
                            
                            
                            TextField("value", text: $Dates).padding(.leading)
                            
                            
                        }//MARK: END HSTACK
                    }//MARK: END  SECTION 2
                    
                    Section{
                        HStack{
                            Image(systemName: "location.north.fill")
                                .padding(0.0)
                            Text("City")
                                .padding(.trailing, 25)
                            
                            
                            
                            TextField("value", text: $City).padding(.leading)
                            
                            
                        }//MARK: END HSTACK
                    }//MARK: END  SECTION 3
                    
                }.listStyle(InsetGroupedListStyle())
                
                //MARK: END  LIST
                // Remove padding from the list
                    .navigationTitle("Start organizing")
                    .navigationBarItems(
                        /*
                         leading: NavigationLink(destination: PreviousView()){
                         HStack {
                         Image(systemName: "chevron.left")
                         Text("Back")
                         }
                         }*/
                        trailing: NavigationLink(destination: ArtView()) {
                            HStack {
                                Text("Next")
                                Image(systemName: "chevron.right")
                            }
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


