import SwiftUI

struct MainPageView: View {
  @State private var isModalPresented = false
  @State var itineraries = sharedData.itineraries

  var body: some View {
    NavigationStack {
      ScrollView(.vertical, showsIndicators: false) {

        VStack(alignment: .leading, spacing: 20) {
          //          if !(sharedData.itineraries.isEmpty) {
          //                      Text("To do")
          //                        .font(.headline)
          //                        .padding(.top)
          //                        .padding(.leading, 20)
          //                        .multilineTextAlignment(.leading)
          //                    }

          VStack(spacing: 20) {
            ForEach(itineraries) { itinerary in
              ZStack(alignment: .bottomLeading) {
                {
                  var imageLoaded = false
                  if let imageFile = FileManager.default.urls(
                    for: .documentDirectory, in: .userDomainMask
                  ).first?.appendingPathComponent(itinerary.city.image) {
                    do {
                      let imageData = try Data(contentsOf: imageFile)
                      imageLoaded = true
                      return ZStack {
                        Image(uiImage: UIImage(data: imageData)!)
                          .resizable()
                          .scaledToFill()
                          .frame(width: 360, height: 150)
                          .cornerRadius(10)
                          .overlay(Color.black.opacity(0.5))
                        if !imageLoaded { ProgressView() }
                      }
                    } catch {
                      print(error.localizedDescription)
                    }
                  }
                  return ZStack {
                    Image(uiImage: UIImage())
                      .resizable()
                      .scaledToFill()
                      .frame(width: 360, height: 150)
                      .cornerRadius(10)
                      .overlay(Color.gray.opacity(1))
                    if !imageLoaded { ProgressView() }
                  }
                }()
                Text(itinerary.city.name)
                  .foregroundColor(.white)
                  .font(.headline)
                  .fontWeight(.bold)
                  .padding()
                  .cornerRadius(10)
                  .padding(.bottom, 5)
              }
              .frame(width: 360)
            }
            .cornerRadius(10)
          }
          .padding(.horizontal, 20)
        }

        VStack(alignment: .leading, spacing: 20) {
          //          Text("Done")
          //            .font(.headline)
          //            .padding(.top, 30).padding(.leading, 20)

          ScrollView(.vertical, showsIndicators: false) {
            //            VStack(spacing: 20) {
            //              ForEach(Done) { city in
            //                ZStack(alignment: .bottomLeading) {
            //
            //                  Image(city.image.lowercased())
            //                    .resizable()
            //                    .scaledToFill()
            //                    .frame(width: 360, height: 150)
            //                    .overlay(
            //                      Color.black.opacity(0.5)
            //                    )
            //                    .cornerRadius(10)
            //                    .overlay(
            //                      Text(city.name)
            //                        .foregroundColor(.white)
            //                        .font(.headline)
            //                        .fontWeight(.bold)
            //                        .padding()
            //
            //                        .cornerRadius(10)
            //                        .padding(.bottom, 5),
            //                      alignment: .bottomLeading
            //                    )
            //                }
            //                .frame(width: 360)  // Larghezza fissa per ogni card
            //              }
            //              .cornerRadius(10)
            //            }
            //            .padding(.horizontal, 20)
          }

        }

        Spacer()
      }
      .toolbar {
        ToolbarItem(placement: .navigationBarTrailing) {
          Button(action: {
            sharedData.itineraries.append(Itinerary())
            sharedData.currentIdx += 1
            //            if selectedConditions.values.allSatisfy({ $0 == 0 || $0 == 1 }) {
            isModalPresented.toggle()
            //            } else {
            //              PersonalPreferencesView()
            //            }
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

#Preview {
  MainPageView()
}