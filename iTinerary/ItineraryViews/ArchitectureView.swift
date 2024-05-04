import SwiftUI

struct ArchitectureView: View {
  @State var prize: String = "Prize"
  @State var event: String = "Location to visit"
  @State var time: String = "time"
  var myData = sharedData
  @State private var selectedMonumentIndices: [Int] = []
  @State private var selectedMonuments: [Monument] = []

  var body: some View {
    NavigationStack {
      Text("Pick the places you’d like to visit:")
        .padding(.leading, -120)
        .padding(.top)
      List {
        ForEach(Array(myData.monuments.enumerated()), id: \.element.id) {
          index, monument in

          Section {
            HStack {
              Button(action: {
                toggleSelection(for: index, monument: monument)
              }) {
                Image(
                  systemName: isMonumentSelected(index: index) ? "checkmark.circle.fill" : "circle")
              }
              .buttonStyle(PlainButtonStyle())

              Spacer()

              NavigationLink(destination: VaticanView()) {
                Image(monument.image)
                VStack(alignment: .leading) {
                  Text(monument.name)
                    .font(.headline)
                  Text(monument.time)
                    .font(.subheadline)
                    .foregroundColor(.gray)
                }
              }

            }
          }
        }
      }
      .navigationTitle("Architecture")
      .navigationBarItems(
        trailing: NavigationLink(destination: RecapView()) {
          HStack {
            Text("Next")
            Image(systemName: "chevron.right")
          }
        }
      )
    }
  }

  private func isMonumentSelected(index: Int) -> Bool {
    selectedMonumentIndices.contains(index)
  }

  private func toggleSelection(for index: Int, monument: Monument) {
    if let selectedIndex = selectedMonumentIndices.firstIndex(of: index) {
      selectedMonumentIndices.remove(at: selectedIndex)
      selectedMonuments.removeAll { $0.id == monument.id }
    } else {
      selectedMonumentIndices.append(index)
      selectedMonuments.append(monument)
    }
  }
}

struct ArchitectureView_Previews: PreviewProvider {
  static var previews: some View {
    ArchitectureView()
  }
}