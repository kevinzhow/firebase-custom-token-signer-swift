import FirebaseCustomTokenSigner
import ArgumentParser

@main
struct FirebaseCustomTokenSignerCLI: ParsableCommand {
    @Option(help: "User id")
    public var uid: String

    @Option(name: .shortAndLong, help: "Firebase Service account file path")
    public var serviceAccountFilePath: String

    public func run() throws{
        let signer = try FirebaseCustomTokenSigner(fromServiceAccountFilePath: serviceAccountFilePath)

        let token = try signer.createCustomToken(
            uid: uid
        )

        print(token)
    }
}