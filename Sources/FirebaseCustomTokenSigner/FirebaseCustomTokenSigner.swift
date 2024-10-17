import JWTKit
import Foundation

public struct FirebaseCustomTokenSigner {
    let serviceAccountEmail: String
    let serviceAccountPrivateKey: String
    
    let signer = JWTKeyCollection()

    public init(fromServiceAccountFilePath path: String) async throws {
        let fileManager = FileManager.default
        guard fileManager.fileExists(atPath: path) else {
            throw NSError(domain: "FirebaseCustomTokenSigner", code: 1, userInfo: [NSLocalizedDescriptionKey: "File not found at path \(path)"])
        }
        let data = fileManager.contents(atPath: path)!
        let serviceAccount = try JSONDecoder().decode(ServiceAccount.self, from: data)
        try await self.init(serviceAccountEmail: serviceAccount.clientEmail, serviceAccountPrivateKey: serviceAccount.privateKey)
    }

    public init(serviceAccountEmail: String, serviceAccountPrivateKey: String) async throws {
        self.serviceAccountEmail = serviceAccountEmail
        self.serviceAccountPrivateKey = serviceAccountPrivateKey
        let key = try Insecure.RSA.PrivateKey(pem: serviceAccountPrivateKey.data(using: .utf8)!)
        await self.signer.add(rsa: key, digestAlgorithm: .sha256)
    }

    public func createCustomToken(uid: String, customClaims: ClaimValueDictionary? = nil) async throws -> String {
        let payload = FireabseUserPayload(
            issuer: IssuerClaim(value: serviceAccountEmail),
            subject: SubjectClaim(value: serviceAccountEmail),
            claims: customClaims,
            uid: uid
        )
        let jwt = try await signer.sign(payload)
        return jwt
    }

    public func verify(token: String) async throws -> FireabseUserPayload {
        let payload = try await signer.verify(token, as: FireabseUserPayload.self)
        return payload
    }
}
