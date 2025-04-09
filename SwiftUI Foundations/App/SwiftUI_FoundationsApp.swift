import SwiftUI

@main
struct SwiftUI_FoundationsApp: App {
    @StateObject private var themeManager = ThemeManager()
    @StateObject private var appState = AppState()
    
    var body: some Scene {
        WindowGroup {
            Group{
                if appState.isLoading {
                    ProgressView()
                } else {
                    switch appState.route {
                    case .login:
                        LoginView()
                    case .home:
                        HomeView()
                    }
                }
            }
            .environmentObject(themeManager)
            .environmentObject(appState)
            .preferredColorScheme(themeManager.colorScheme)
        }
    }
}
