import Foundation

enum AppRoute: Hashable {
    case login
    case home
    case items
    case itemDetail(id: String)
    case profile
}
