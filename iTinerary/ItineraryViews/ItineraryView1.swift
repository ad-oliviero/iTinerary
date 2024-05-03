import SwiftUI

struct ItineraryView1: View {
  var myData = sharedData
  @State private var selectedDate = Date()  // State variable to store selected date
  @State var activity: String = "Rome"
  @State var image: String = "Rectangle 3"
  @State var destination: String = "Roma Fiumicino"
  @State var Title2: String = "Arriving at"
  @State var Title = "Airport"
  @State var duration: String = "12 PM"
  @State var street: String = "Via del Pellegrino, 11/12"
  @State var counter: Int = 0
  @State var shifter: String = "Frame 1"

  var body: some View {
    NavigationView {
      VStack {
        RoundedRectangle(cornerRadius: 10)
          .foregroundColor(Color.white)
          .frame(height: 30)
          .overlay(
            HStack {
              Text(activity).font(.headline)
              Text(selectedDate, style: .date).font(.headline)
              Text(selectedDate, style: .time).font(.headline)
            }
            .padding(.bottom, 10)
          )

        HStack {
          if counter >= 1 {
            Button(
              action: {
                if counter > 2 {
                  counter = 2
                }
                counter -= 1

                if counter <= 0 {
                  activity = "Rome"
                  image = "Rectangle 3"  // Update image
                  destination = "Roma Fiumicino"  // Update airport name
                  shifter = "Frame 1"
                  Title = "Airport"
                  Title2 = "Arriving at"
                }
                if counter == 1 {
                  activity = "Colosseum"
                  image = "Rectangle 4"  // Update image
                  destination = "2PM"  // Update airport name

                  shifter = "Frame 2"
                  Title = "Arriving at"
                  Title2 = "Duration"
                  duration = "1h 30min"

                }
                if counter >= 2 {
                  activity = "Lunch Time"
                  image = "Rectangle 5"  // Update image
                  destination = "3:30 PM"  // Update airport name
                  Title = "Arriving at"
                  Title2 = "Duration"
                  shifter = "Frame 3"
                }

              },
              label: {
                Image(systemName: "chevron.left")

              })

          }
          Image(image).padding(.leading, 20)

          Button(action: {
            counter += 1

            // Update image and other display content
            if counter <= 0 {
              activity = "Rome"
              image = "Rectangle 3"  // Update image
              destination = "Roma Fiumicino"  // Update airport name
              shifter = "Frame 1"
              Title = "Airport"
              Title2 = "Arriving at"

            }
            if counter == 1 {
              activity = "Colosseum"
              image = "Rectangle 4"  // Update image
              destination = "2PM"  // Update airport name

              shifter = "Frame 2"
              Title = "Arriving at"
              Title2 = "Duration"
              duration = "1h 30min"

            }
            if counter >= 2 {
              activity = "Lunch Time"
              image = "Rectangle 5"  // Update image
              destination = "3:30 PM"  // Update airport name
              Title = "Arriving at"
              Title2 = "Duration"
              shifter = "Frame 3"
            }
          }) {

            if counter <= 1 {
              Image(systemName: "chevron.right")
            }
          }
          .padding(.leading, 7)
        }
        .padding(.top, 20)

        VStack {
          Image(shifter)
        }.padding(.top, 50)
        Section {
          VStack {
            HStack {
              if counter <= 0 {
                Text(Title)
                  .font(.headline)
                  .fontWeight(.medium)
                Text(destination)
                  .font(.subheadline)
                  .foregroundColor(.gray)
                  .padding(.leading, 50)

                Spacer()
              }

              if counter == 1 {
                Text(Title)
                  .font(.headline)
                  .fontWeight(.medium)

                Text(destination)
                  .font(.subheadline)
                  .foregroundColor(.gray)
                  .padding(.leading, 20)

                Spacer()
              }

              if counter >= 2 {
                Text(Title)
                  .font(.headline)
                  .fontWeight(.medium)
                Text(destination)
                  .font(.subheadline)
                  .foregroundColor(.gray)
                  .padding(.leading, 20)

                Spacer()
              }

            }
            HStack {
              Text(Title2)
                .font(.headline)
                .fontWeight(.medium).padding(.top)
              Text(duration)
                .font(.subheadline)
                .foregroundColor(.gray)
                .padding(.leading, 30).padding(.top)

              Spacer()
            }
            if counter >= 2 {
              HStack {
                Text("Street")
                  .font(.headline)
                  .fontWeight(.medium).padding(.top)
                Text(street)
                  .font(.subheadline)
                  .foregroundColor(.gray)
                  .padding(.leading, 45).padding(.top)

                Spacer()
              }
            }
          }
          .padding(.top, 40)
          .padding(.leading, 40)
        }

        Spacer()
      }
      .padding().padding(.top, 40)
      .navigationTitle("Your itinerary")
    }
    .ignoresSafeArea()
  }
}

struct ItineraryView1_Previews: PreviewProvider {
  static var previews: some View {
    ItineraryView1()
  }
}