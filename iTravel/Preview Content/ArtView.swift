import SwiftUI

struct ArtView: View {
    @State var prize: String = "Prize"
    @State var place:String  = "Location to visit"
    @State var time: String  = "time"
    var myData = sharedData
    @State private var selectedArtIndices: [Int] = []
    @State private var selectedArts: [Art] = []
    
    var body: some View {
        NavigationStack{
            Text("Pick the places you’d like to visit:")
                .padding(.leading, -120 )
                .padding(.top)
            List{
                ForEach(Array(myData.arts.enumerated()), id: \.element.id){ index, art in
                    Section{
                        HStack{
                            
                            Button(action:{
                                toggleSelection(for: index, art: art)
                            }) {
                                Image(systemName: isArtSelected(index: index) ? "checkmark.circle.fill" : "circle")
                            }
                            .buttonStyle(PlainButtonStyle())
                            
                            Spacer()
                            
                            NavigationLink(destination: VaticanView()) {
                                Image(art.image)
                                VStack(alignment: .leading) {
                                    Text(art.name)
                                        .font(.headline)
                                    Text(art.time)
                                        .font(.subheadline)
                                        .foregroundColor(.gray)
                                }
                            }
                            
                        }
                    }
                }
            }
            .navigationTitle("Art")
            .navigationBarItems(
                trailing: NavigationLink(destination: SportView()) {
                    HStack {
                        Text("Next")
                        Image(systemName: "chevron.right")
                    }
                }
            )
        }
    }
    
    private func isArtSelected(index: Int) -> Bool {
        selectedArtIndices.contains(index)
    }
    
    private func toggleSelection(for index: Int, art: Art) {
        if let selectedIndex = selectedArtIndices.firstIndex(of: index) {
            selectedArtIndices.remove(at: selectedIndex)
            selectedArts.removeAll { $0.id == art.id }
        } else {
            selectedArtIndices.append(index)
            selectedArts.append(art)
        }
    }
}

struct ArtView_Previews: PreviewProvider {
    static var previews: some View {
        ArtView()
    }
}

