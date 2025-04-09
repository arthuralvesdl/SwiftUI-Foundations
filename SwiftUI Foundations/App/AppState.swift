import Foundation

final class AppState: ObservableObject {
    // Estado de navegação
    @Published var route: AppRoute = .login
    // Estado do usuário
    @Published var currentUser: User?
    // Estado global da aplicação
    @Published var isLoading: Bool = false
    
}
