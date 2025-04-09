import SwiftUI

struct AppTheme {
    static let boxShadow = Color(.sRGB, red: 25/255, green: 25/255, blue: 28/255, opacity: 0.08)
    static let errorColor = Color(red: 229/255, green: 57/255, blue: 53/255)
    static let successColor = Color(red: 76/255, green: 175/255, blue: 80/255)
}

struct ThemeColors {
    let container: Color
    let containerTitle: Color
    let containerBorder: Color
    let containerDisabled: Color
    let containerTitleDisabled: Color
    let snackBarError: Color
    let snackBarAlert: Color
    let snackBarSuccess: Color
    let snackBarInfo: Color
    let snackBarNotify: Color
    
    static let light = ThemeColors(
        container: Color(red: 1, green: 223/255, blue: 217/255),
        containerTitle: Color(red: 200/255, green: 57/255, blue: 31/255),
        containerBorder: Color(red: 217/255, green: 217/255, blue: 217/255),
        containerDisabled: Color.white,
        containerTitleDisabled: Color(red: 217/255, green: 217/255, blue: 217/255),
        snackBarError: AppTheme.errorColor,
        snackBarAlert: Color(red: 251/255, green: 140/255, blue: 0),
        snackBarSuccess: AppTheme.successColor,
        snackBarInfo: Color(red: 8/255, green: 126/255, blue: 139/255),
        snackBarNotify: Color(red: 77/255, green: 77/255, blue: 77/255)
    )
    
    static let dark = ThemeColors(
        container: Color(red: 228/255, green: 72/255, blue: 43/255),
        containerTitle: Color(red: 1, green: 239/255, blue: 236/255),
        containerBorder:Color(red: 128/255, green: 128/255, blue: 128/255),
        containerDisabled: Color(red: 51/255, green: 51/255, blue: 51/255),
        containerTitleDisabled: Color(red: 92/255, green: 92/255, blue: 92/255),
        snackBarError: Color(red: 234/255, green: 97/255, blue: 93/255),
        snackBarAlert: Color(red: 251/255, green: 140/255, blue: 0),
        snackBarSuccess: AppTheme.successColor,
        snackBarInfo: Color(red: 118/255, green: 197/255, blue: 206/255),
        snackBarNotify: Color(red: 179/255, green: 179/255, blue: 179/255)
    )
    
    static func getThemeColors(for scheme: ColorScheme) -> ThemeColors {
        return scheme == .dark ? .dark : .light
    }
}

struct ThemeFonts {
    static let bodySmall = Font.custom("Inter", size: 10)
    static let labelSmall = Font.custom("Inter", size: 12)
    static let bodyMedium = Font.custom("Inter", size: 14)
    static let bodyLarge = Font.custom("Inter", size: 16).weight(.regular)
    static let titleSmall = Font.custom("Inter", size: 18)
    static let titleMedium = Font.custom("Roboto", size: 20)
    static let titleLarge = Font.custom("Roboto", size: 24).weight(.bold)
    static let headlineSmall = Font.custom("Roboto", size: 32).weight(.bold)
    static let headlineMedium = Font.custom("Roboto", size: 40)
    static let headlineLarge = Font.custom("Roboto", size: 48)
    static let displaySmall = Font.custom("Roboto", size: 56)
}

class ThemeManager: ObservableObject {
    @AppStorage("theme") private var selectedTheme: String = "system"
    
    var colorScheme: ColorScheme? {
        switch selectedTheme {
        case "light": return .light
        case "dark": return .dark
        default: return UITraitCollection.current.userInterfaceStyle == .dark ? .dark : .light
        }
    }
    
    var colors: ThemeColors {
        return ThemeColors.getThemeColors(for: colorScheme ?? .light)
    }
    
    func setTheme(_ theme: String) {
        selectedTheme = theme
        objectWillChange.send()
    }
}

