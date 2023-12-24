struct ServiceAccount: Codable {
    enum CodingKeys: String, CodingKey {
        case clientEmail = "client_email"
        case privateKey = "private_key"
    }
    
    let clientEmail: String
    let privateKey: String
}