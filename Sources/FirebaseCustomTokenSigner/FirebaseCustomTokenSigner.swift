import JWTKit

public struct FirebaseCustomTokenSigner {
    let serviceAccountEmail: String
    let serviceAccountPrivateKey: String
    
    let signer: JWTSigner

    init(serviceAccountEmail: String, serviceAccountPrivateKey: String) throws {
        self.serviceAccountEmail = serviceAccountEmail
        self.serviceAccountPrivateKey = serviceAccountPrivateKey
        self.signer = JWTSigner.rs256(key: try .private(pem: serviceAccountPrivateKey.data(using: .utf8)!))
    }

    public func createCustomToken(uid: String, customClaims: ClaimValueDictionary? = nil) throws -> String {
        let payload = FireabseUserPayload(
            issuer: IssuerClaim(value: serviceAccountEmail),
            subject: SubjectClaim(value: serviceAccountEmail),
            claims: customClaims,
            uid: uid
        )
        let jwt = try signer.sign(payload)
        return jwt
    }

    public func verify(token: String) throws -> FireabseUserPayload {
        let payload = try signer.verify(token, as: FireabseUserPayload.self)
        return payload
    }
}