struct User: Codable {
    let id: String
    let name: String
    let email: String
    let token: String
    let isAdmin: Bool
    let isOwner: Bool
    let phone: String?
    let isDisabled: Bool
    
    init(id: String, name: String, email: String, token: String, isAdmin: Bool, isOwner: Bool, phone: String?, isDisabled: Bool) {
        self.id = id
        self.name = name
        self.email = email
        self.token = token
        self.isAdmin = isAdmin
        self.isOwner = isOwner
        self.phone = phone
        self.isDisabled = isDisabled
    }
}
