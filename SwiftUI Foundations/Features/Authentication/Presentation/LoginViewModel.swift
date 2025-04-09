import Foundation

@MainActor // Garante as atualizações da UI na thread principal
class LoginViewModel: ObservableObject /* Permite que a View observe mudanças nesta classe e se atualize */ {
    // Inputs
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var showPassword: Bool = false
    // Outputs
    @Published var isLoading: Bool = false
    @Published var user: User?
    @Published var errorMessage: String?
    
    private let repository: AuthRepositoryProtocol // Integrar com a camda de dados (API, Banco de dados, Firebase, etc.)
    
    init(repository: AuthRepositoryProtocol = AuthRepository()){
        self.repository = repository // Injetar o repositório
    }
    
    func togglePasswordVisibility() {
        showPassword.toggle()
    }
    
    func login() async {
        isLoading = true
        errorMessage = nil
        
        do {
          user = try await repository.login(email: email, password: password)
        } catch {
            errorMessage = "Login falhou. Verifique seus dados e tente novamente."
        }
        isLoading = false
    }
}
