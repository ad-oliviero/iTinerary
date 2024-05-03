import SwiftUI

struct MainPageView: View {
  @State private var isModalPresented = false

  var Done = sharedCity.done

  var ToDo = sharedCity.toDo

  var body: some View {
    NavigationStack {
      ScrollView(.vertical, showsIndicators: false) {

        VStack(alignment: .leading, spacing: 20) {
          if !ToDo.isEmpty {
            Text("To do")
              .font(.headline)
              .padding(.top)
              .padding(.leading, 20)
              .multilineTextAlignment(.leading)
          }

          VStack(spacing: 20) {
            ForEach(ToDo) { city in
              ZStack(alignment: .bottomLeading) {

                Image(city.image.lowercased())
                  .resizable()
                  .scaledToFill()
                  .frame(width: 360, height: 150)
                  .cornerRadius(10)
                  .overlay(
                    Color.black.opacity(0.5)
                  )
                  .overlay(
                    Text(city.name)
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
              ForEach(Done) { city in
                ZStack(alignment: .bottomLeading) {

                  Image(city.image.lowercased())
                    .resizable()
                    .scaledToFill()
                    .frame(width: 360, height: 150)
                    .overlay(
                      Color.black.opacity(0.5)
                    )
                    .cornerRadius(10)
                    .overlay(
                      Text(city.name)
                        .foregroundColor(.white)
                        .font(.headline)
                        .fontWeight(.bold)
                        .padding()

                        .cornerRadius(10)
                        .padding(.bottom, 5),
                      alignment: .bottomLeading
                    )
                }

                .frame(width: 360)  // Larghezza fissa per ogni card
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
      StartOrganizingView()
    }
  }
}

struct MainPageView_Previews: PreviewProvider {
  static var previews: some View {
    MainPageView()
  }
}