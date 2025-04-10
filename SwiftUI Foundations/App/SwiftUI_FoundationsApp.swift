import SwiftUI

@main
struct SwiftUI_FoundationsApp: App {
    @StateObject private var themeManager = ThemeManager()
    @StateObject private var appState = AppState()
    
    var body: some Scene {
        WindowGroup {
            RootView()
                .environmentObject(appState)
                .environmentObject(themeManager)
                .preferredColorScheme(themeManager.colorScheme)
        }
    }
}
