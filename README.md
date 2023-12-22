# FirebaseCustomTokenSigner-Swift

[Firebase Custom Token](https://firebase.google.com/docs/auth/admin/create-custom-tokens) Signer for Swift

## Usage

```swift
let signer = FirebaseCustomTokenSigner(serviceAccountEmail: "serviceAccountEmail", serviceAccountPrivateKey: "serviceAccountPrivateKey")
let customToken = try signer.createCustomToken(uid: "uid", customClaims: ["premium_account": ClaimValue.bool(true)])
```
