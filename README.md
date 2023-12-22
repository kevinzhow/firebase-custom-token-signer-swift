# FirebaseCustomTokenSigner-Swift

Firebase Custom Token Signer for Swift

## Usage

```swift
let signer = FirebaseCustomTokenSigner(serviceAccountEmail: "serviceAccountEmail", serviceAccountPrivateKey: "serviceAccountPrivateKey")
let customToken = try signer.createCustomToken(uid: "uid", customClaims: ["premium_account": ClaimValue.bool(true)])
```
