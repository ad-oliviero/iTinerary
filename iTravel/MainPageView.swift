import SwiftUI

struct MainPageView: View {
    @State private var isModalPresented = false
    
    var done = ["Barcelona", "Paris", "Milan", "London"]
    
    var toDo = ["London"]
    
    var body: some View {
        NavigationStack {
            ScrollView(.vertical, showsIndicators: false) {
                
                VStack(alignment: .leading, spacing: 20) {
                    Text("To do")
                        .font(.headline)
                        .padding(.top).padding(.leading, 20)
                    
                    
                    VStack(spacing: 20) {
                        ForEach(toDo, id: \.self) { city in
                            ZStack (alignment: .bottomLeading) {
                                
                                Image(city.lowercased())
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 360, height: 150)
                                    .cornerRadius(10)
                                    .overlay(
                                        Color.black.opacity(0.5)
                                    )
                                    .overlay(
                                        Text(city)
                                            .foregroundColor(.white)
                                            .font(.headline)
                                            .fontWeight(.bold)
                                            .padding()
                                        
                                            .cornerRadius(10)
                                            .padding(.bottom, 5),
                                        alignment: .bottomLeading
                                    )
                                
                            }
                            
                            
                            .frame(width: 360)
                            
                        }
                        .cornerRadius(10)
                    }
                    .padding(.horizontal, 20)
                }
                
                
                
                
                VStack(alignment: .leading, spacing: 20) {
                    Text("Done")
                        .font(.headline)
                        .padding(.top, 30).padding(.leading, 20)
                    
                    ScrollView(.vertical, showsIndicators: false) {
                        VStack(spacing: 20) {
                            ForEach(done, id: \.self) { city in
                                ZStack (alignment: .bottomLeading) {
                                    
                                    Image(city.lowercased())
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 360, height: 150)
                                        .overlay(
                                            Color.black.opacity(0.5)
                                        )
                                        .cornerRadius(10)
                                        .overlay(
                                            Text(city)
                                                .foregroundColor(.white)
                                                .font(.headline)
                                                .fontWeight(.bold)
                                                .padding()
                                            
                                                .cornerRadius(10)
                                                .padding(.bottom, 5),
                                            alignment: .bottomLeading
                                        )
                                }
                                
                                
                                .frame(width: 360) // Larghezza fissa per ogni card
                            }
                            .cornerRadius(10)
                        }
                        .padding(.horizontal, 20)
                    }
                    
                }
                
                
                
                Spacer()
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        isModalPresented.toggle()
                    }) {
                        Image(systemName: "plus")
                    }
                }
            }
            .navigationTitle("Your itineraries")
        }
        
        .fullScreenCover(isPresented: $isModalPresented) {
            //qualcosa
        }
    }
}

struct MainPageView_Previews: PreviewProvider {
    static var previews: some View {
        MainPageView()
    }
}

