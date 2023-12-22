import JWTKit

public struct FirebaseCustomTokenSigner {
    let serviceAccountEmail: String
    let serviceAccountPrivateKey: String

    public func createCustomToken(uid: String, customClaims: ClaimValueDictionary? = nil) throws -> String {
        let signer = JWTSigner.rs256(key: try .private(pem: serviceAccountPrivateKey.data(using: .utf8)!))
        let payload = FireabseUserPayload(
            issuer: IssuerClaim(value: serviceAccountEmail),
            subject: SubjectClaim(value: serviceAccountEmail),
            claims: customClaims,
            uid: uid
        )
        let jwt = try signer.sign(payload)
        return jwt
    }
}