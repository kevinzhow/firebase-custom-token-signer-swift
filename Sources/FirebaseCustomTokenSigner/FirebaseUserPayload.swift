import Foundation
import JWTKit

struct FireabseUserPayload: JWTPayload {
    enum CodingKeys: String, CodingKey {
        case issuedAt = "iat"
        case issuer = "iss"
        case audience = "aud"
        case subject = "sub"
        case expiration = "exp"
        case claims = "claims"
        case uid = "uid"
    }
    
    var issuedAt: IssuedAtClaim
    var issuer: IssuerClaim
    var audience: AudienceClaim
    var subject: SubjectClaim
    var expiration: ExpirationClaim
    var claims: ClaimValueDictionary
    var uid: String
    
    func verify(using signer: JWTSigner) throws {
        try self.expiration.verifyNotExpired()
    }
    
    public init(
        issuer: IssuerClaim,
        audience: AudienceClaim = AudienceClaim(value: "https://identitytoolkit.googleapis.com/google.identity.identitytoolkit.v1.IdentityToolkit"),
        subject: SubjectClaim,
        expiration: ExpirationClaim = ExpirationClaim(value: Date().addingTimeInterval(3600)),
        claims: ClaimValueDictionary?,
        uid: String,
        issuedAt: IssuedAtClaim = IssuedAtClaim(value: Date())
    ) {
        self.issuer = issuer
        self.subject = subject
        self.audience = audience
        self.issuedAt = issuedAt
        self.expiration = expiration
        self.claims = claims ?? [:]
        self.uid = uid
    }
}