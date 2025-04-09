import SwiftUI

struct RootView: View {
    
    @EnvironmentObject var appState: AppState
    @EnvironmentObject var themeManager: ThemeManager

    var body: some View {
        if appState.isLoading {
            SplashView()
        } else {
            Group{
                switch appState.authState {
                case .checking:
                    SplashView()
                case .loggedIn:
                    HomeView(appState: appState, themeManager: themeManager)
                case .loggedOut:
                    LoginView(appState: appState)
                }
            }
        }
    }
}

