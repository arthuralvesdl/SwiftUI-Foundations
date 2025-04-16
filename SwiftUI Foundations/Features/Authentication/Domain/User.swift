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

//extension User: Codable {
//    enum CodingKeys: String, CodingKey {
//        case id
//        case name
//        case email
//        case token
//        case isAdmin
//        case isOwner
//        case phone
//        case isDisabled
//    }
//    
//    init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        id = try container.decode(String.self, forKey: .id)
//        name = try container.decode(String.self, forKey: .name)
//        email = try container.decode(String.self, forKey: .email)
//        token = try container.decode(String.self, forKey: .token)
//        isAdmin = try container.decode(Bool.self, forKey: .isAdmin)
//        isOwner = try container.decode(Bool.self, forKey: .isOwner)
//        phone = try container.decodeIfPresent(String.self, forKey: .phone)
//        isDisabled = try container.decode(Bool.self, forKey: .isDisabled)
//    }
//}
