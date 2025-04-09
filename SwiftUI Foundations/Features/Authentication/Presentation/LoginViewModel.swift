import Foundation

@MainActor /// Garante as atualizações da UI na thread principal
class LoginViewModel: ObservableObject /* Permite que a View observe mudanças nesta classe e se atualize */ {
    // Inputs
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var showPassword: Bool = false
    // Outputs
    @Published var isLoading: Bool = false
    @Published var user: User?
    @Published var errorMessage: String?
    
    private let repository: AuthRepositoryProtocol /// Integrar com a camda de dados (API, Banco de dados, Firebase, etc.)
    private let appState: AppState
    
    init(repository: AuthRepositoryProtocol = AuthRepository(), appState:AppState){
        self.repository = repository /// Injetar o repositório
        self.appState = appState
    }

    func togglePasswordVisibility() {
        showPassword.toggle()
    }
    
    //MARK: - LOGIN
    func login() async {
        isLoading = true
        errorMessage = nil
        defer {isLoading = false} /// garante que será executado no escopo
        
        do {
            let user: User? = try await repository.login(email: email, password: password)
            
            guard let user = user else {
                errorMessage = "Usuário não encontrado"
                return
            }
            
            try await repository.saveUser(user)
            appState.currentUser = user
            appState.authState = .loggedIn(user)
            
        } catch {
            errorMessage = "Login falhou. Verifique seus dados e tente novamente."
        }
    }
}
