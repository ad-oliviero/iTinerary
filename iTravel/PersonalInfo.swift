import SwiftUI

struct PersonalInfo: View {
    @State var name = ""
    @State var birth = ""
    @State var selectedGender = ""
    @State var city = ""
    @State var country = ""
    @State private var isBirthPickerPresented = false
    @State private var isGenderPickerPresented = false
    
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
                            HStack{
                                Text("Gender").foregroundColor(.black)
                                Text(selectedGender).foregroundColor(.gray)
                            }
                        }
                        
                        HStack {
                            Text("Country")
                            TextField("Country", text: $country)
                        }
                        
                        HStack {
                            Text("City")
                            TextField("City", text: $city)
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
                        HStack{
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
}

#Preview {
    PersonalInfo()
}
