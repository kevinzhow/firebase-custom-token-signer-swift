import JWTKit

struct FirebaseCustomTokenSigner {
    let serviceAccountEmail: String
    let privateKey: String

    func sign(uid: String) throws -> String {
        let signer = JWTSigner.rs256(key: try .private(pem: privateKey.data(using: .utf8)!))
        let payload = FireabseUserPayload(
            issuer: IssuerClaim(value: serviceAccountEmail),
            subject: SubjectClaim(value: serviceAccountEmail),
            uid: uid
        )
        let jwt = try signer.sign(payload)
        return jwt
    }
}