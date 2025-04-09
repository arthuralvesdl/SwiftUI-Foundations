import Foundation

final class AppState: ObservableObject {
    // Estado de navegação
    @Published var route: AppRoute = .login
    // Estado do usuário
    @Published var currentUser: User?
    // Estado global da aplicação
    @Published var isLoading: Bool = true
    
    enum AuthState {
        case checking
        case loggedIn(User)
        case loggedOut
    }
    
    @Published var authState: AuthState = .checking
    private let authRepository: AuthRepositoryProtocol
    
    init(authRepository: AuthRepositoryProtocol = AuthRepository()){
        self.authRepository = authRepository
        checkAuthStatus()
    }
    //MARK: - Autenticação do usuário
    func checkAuthStatus() {
        Task { @MainActor in ///garantir que todo o bloco assíncrono dentro do Task seja executado na main thread
            defer { isLoading = false }
            do {
                let user: User? = try await authRepository.getCurrentUser()
                
                guard let user = user else {
                    authState = .loggedOut
                    return
                }
                authState = .loggedIn(user)
                
            } catch {
                authState = .loggedOut
            }
            
        }
    }
    
    //MARK: - Logout
    func logout() {
        Task { @MainActor in ///garantir que todo o bloco assíncrono dentro do Task seja executado na main thread
            do {
                try await authRepository.logout()
                authState = .loggedOut
            } catch {
                print("Loogout error: \(error)")
            }
            
        }
    }
    
}
