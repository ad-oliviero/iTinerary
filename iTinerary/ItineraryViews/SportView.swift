import SwiftUI

struct MyButtonStyle: ButtonStyle {
  var isClicked: Bool

  func makeBody(configuration: Configuration) -> some View {
    configuration.label
      .foregroundColor(isClicked ? .blue : .primary)
      .background(isClicked ? Color.blue.opacity(0.2) : Color.clear)
      .cornerRadius(8)
  }
}

struct SportView: View {
  @State var prize: String = "Prize"
  @State var event: String = "Location to visit"
  @State var typeOfSport: String = "Football"
  var myData = sharedData
  @State private var selectedSportIndices: [Int] = []
  @State private var selectedSports: [Sport] = []
  @State private var isNavigationActive = false

  var body: some View {
    NavigationStack {
      Text("Pick the places you’d like to visit:")
        .padding(.leading, -120)
        .padding(.top)
      List {
        ForEach(Array(myData.sports.enumerated()), id: \.element.id) {
          index, sport in

          Section {
            HStack {
              Button(action: {
                toggleSelection(for: index, sport: sport)
              }) {
                Image(
                  systemName: isSportSelected(index: index) ? "checkmark.circle.fill" : "circle")
              }
              .buttonStyle(PlainButtonStyle())

              Spacer()

              NavigationLink(destination: VaticanView()) {
                Image(sport.image)
                VStack(alignment: .leading) {
                  Text(sport.name)
                    .font(.headline)
                  Text(sport.time)
                    .font(.subheadline)
                    .foregroundColor(.gray)
                }
              }
              .opacity(1)
              .buttonStyle(PlainButtonStyle())
            }
          }
        }
      }
      .navigationTitle("Sport")
      .navigationBarItems(
        trailing: NavigationLink(destination: ArchitectureView()) {
          HStack {
            Text("Next")
            Image(systemName: "chevron.right")
          }
        }
      )
    }
  }

  private func isSportSelected(index: Int) -> Bool {
    selectedSportIndices.contains(index)
  }

  private func toggleSelection(for index: Int, sport: Sport) {
    if let selectedIndex = selectedSportIndices.firstIndex(of: index) {
      selectedSportIndices.remove(at: selectedIndex)
      selectedSports.removeAll { $0.id == sport.id }
    } else {
      selectedSportIndices.append(index)
      selectedSports.append(sport)
    }
  }
}

struct SportView_Previews: PreviewProvider {
  static var previews: some View {
    SportView()
  }
}