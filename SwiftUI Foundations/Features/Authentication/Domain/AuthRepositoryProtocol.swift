protocol AuthRepositoryProtocol {
    func login(email: String, password: String) async throws -> User?
    func saveUser(_ user: User) async throws
    func getCurrentUser() async throws -> User?
    func logout() async throws
    
}
