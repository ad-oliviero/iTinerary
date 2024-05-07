import SwiftUI

struct OnboardingView: View {
  @State var isOnboardingCompleted: Bool? = false
  @State var hasAppOpenedBefore: Bool? = false
  @State private var currentSlideIndex = 0
  @State private var isNavigationActive = false  // Aggiunto stato per la navigazione

  var body: some View {
    VStack(alignment: .center) {
      TabView(selection: $currentSlideIndex) {

        // Slide 1: Descrizione dell'app
        VStack {
          Text("Welcome to iTinerary")
            .font(.title)
            .fontWeight(.bold)
            .padding()
          Image(uiImage: UIImage(named: "AppIcon") ?? UIImage())
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 150, height: 150)
          Text("Plan and store your journeys with iTinerary. Start exploring today!")
            .multilineTextAlignment(.center)
            .padding()
        }
        .tag(0)

        VStack {
          Text("Organizing a trip has never been easier!").multilineTextAlignment(.center)
            .font(.title)
            .fontWeight(.bold)
            .padding()

          HStack {
            Image(systemName: "gym.bag.fill")
            Text("Start organizing your trip")
          }.padding(.top)

          HStack {
            Image(systemName: "theatermask.and.paintbrush")
            Text("Pick your interests")
          }.padding(.top)

          HStack {
            Image(systemName: "heart")
            Text("Choose between the options")
          }.padding(.top)
        }
        .tag(1)

        VStack {
          Text("Make it concrete!").multilineTextAlignment(.center)
            .font(.title)
            .fontWeight(.bold)
            .padding()
          HStack {
            Image(systemName: "list.bullet.rectangle.portrait")
            Text("Revise your itinerary")
          }.padding(.top)

          HStack {
            Image(systemName: "square.and.pencil")
            Text("Modify what you dislike")
          }.padding(.top)

          HStack {
            Image(systemName: "airplane")
            Text("Save to have it whenever you want")
          }.padding(.top)
        }
        .tag(2)

        // Slide 3: Funzionalità 2
        VStack {
          PersonalPreferencesView()
        }
        .tag(3)

      }
      .tabViewStyle(PageTabViewStyle())
      .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
      .navigationBarHidden(true)

      // Pulsante "Get Started"
      Button(action: {
        self.isOnboardingCompleted = true
        self.isNavigationActive = true  // Imposta la navigazione attiva quando viene premuto il pulsante
      }) {
        Text("Get Started")
          .foregroundColor(.white)
          .padding()
          .background(Color.blue)
          .cornerRadius(8)
      }
      .padding()
      .opacity(currentSlideIndex == 3 ? 1.0 : 0.0)  // Mostra il pulsante solo alla fine dell'onboarding
      .fullScreenCover(isPresented: $isNavigationActive) {
        // Naviga alla MainPageView quando la variabile di navigazione è attiva
        UserDefaults.standard.set(true, forKey: "KeyOnBoardingViewShown")
        return MainPageView()
      }
    }
  }
}

// Preview
struct OnboardingView_Previews: PreviewProvider {
  static var previews: some View {
    OnboardingView()
  }
}