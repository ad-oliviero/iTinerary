import SwiftUI

@main
struct iTinerary: App {
  var body: some Scene {
    WindowGroup {
//      TestAPIView()
            ContentView()
    }
  }
}

struct ContentView: View {
  var body: some View {
    VStack {
      if UserDefaults.standard.bool(forKey: "KeyOnBoardingViewShown") == false {
        // show your onboarding view
        return AnyView(OnboardingView())
      } else {
        // show your main content view
        return AnyView(MainPageView())
      }
    }
  }
}
