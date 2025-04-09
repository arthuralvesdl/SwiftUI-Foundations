import Foundation
struct AuthRepository: AuthRepositoryProtocol {
 
    
    private let keychain: KeychainHelperProtocol
    
    init(keychain: KeychainHelperProtocol = KeychainHelper.shared) {
        self.keychain = keychain
    }
    
    //MARK: - Autenticação
    func login(email: String, password: String) async throws -> User {
        try await Task.sleep(nanoseconds: 1_000_000_000) // 1 segundo de delay
            
            if email == "user@example.com" && password == "123456" {
                return User(id: "1", name: "Usuário", email: "user@example.com", token: "toke_123", isAdmin: false, isOwner: true, phone: nil, isDisabled: false)
            } else {
                throw NSError(domain: "AuthError", code: 401)
            }
    }
    
    //MARK: - Gerenciamente de Sessão
    func saveUser(_ user: User) async throws {
        let data = try JSONEncoder().encode(user)
        try keychain.save(data, service: "auth", account: "currentUser")

    }
    func getCurrentUser() async throws -> User? {
        guard let data = try keychain.read(service: "auth", account: "currentUser") else {
            return nil
        }
        return try JSONDecoder().decode(User.self, from: data)
        
    }
    func logout() async throws {
        try keychain.delete(service: "auth", account: "currentUser")
    }
    
    
    
}
