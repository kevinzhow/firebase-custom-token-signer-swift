import XCTest
import JWTKit
@testable import FirebaseCustomTokenSigner

final class FirebaseCustomTokenSignerTests: XCTestCase {
    func testSign() throws {

        let demoPrivateKey = 
"""
-----BEGIN PRIVATE KEY-----
MIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQDcNUqqUXpm0Xqq
XivqlDcJkBtogQhaaeUk3alMLlaZJil0HFdYjbm1yt4w07ctJM33Z/1FzndECgJE
/HTkDujTgB7vuauMps81RXM8VJwJ0uezZPpBd/2gbVyCEpz/3ztWPYq6bOBoIG67
C8qQbLNquevatLRRhTzH9IGjouy1dSC7XNHtFcO6cJpKNZuimpPEfawU+5DCLuU1
sZnHAiOjkuRYqZ5uMCwBK0TmTQhnsJlw2ptiEXcB/BR8fabJdZmwL4UAz+5B55Vh
3utbf1hAN9kGckVeOoe+4Od5Jf0uaN0K7PjbPBfxXOngLqvPDFrp18YQEmz26NrW
i7dojBklAgMBAAECggEAZxMo3n1iCoOuY9XNv7Fd68OBGNMhKlUcFbwN9WNRVMGI
sNldR02bqo0JoRhQyzhJkq+h3Y2NxRLcShdTzbZu5CU6FeM2ehFQt3JJROmj2nNW
0mGHRKLaXMAkB5yX0atXtn/7ElVJW2QnALW9vQmsl93sGQTxzKDNuRjpn8NxAmQx
PNMaFWeXP3MYWlWpmrjUKbC6MnR1pZaafIqGPjAl3C6QR/vyMARtaOwA36zvuiE2
awM0Oix4NYDE+w/7/CrOvoxdtY3N5S2AWO8UITcR2oUf2nlnYxEojgRgQSl2sLEW
+iXywv9ZubfZanj/JuPFY04zFEhYlYD0tX9A9VkhhwKBgQDxtooOcM516NCGg0wp
KsxjJknsif1vZP6MrgCV+x0i7oK3Gb9mYoRAsygbpIAgca2ljqL50+q2MZuyOcyj
pO0Cg0lLXXscYfCuFQDycfEwDEGPRc3OJpr+64vPmJOj7DjgwYbTb2UHKv6AR9si
Li4V3ROddDbpyAp5SU1rjvEDkwKBgQDpOVpqMCk0t19t1IGKzJrwayfg0EO1CQR/
8WdP8KSwwgtyAmgRCEYs+mg9RGfbASx2B1CNRw/DZaNWTJSr9884byEyu6ppiz/h
s4JFZsoP58M+/Id+E8WkPwgD4+l+f1rlFL7zrA4appo0USBQZOV+iwtZD5fCX7Ih
Dn9dIclTZwKBgQDPRN5hv63rQfb+QbyfWInnQ8AES9e9G/eDnvn1ol27xJbmd/e+
zh/mczqjaY5NQ+3Jl+R9IpGUJjoCvLmUYiqzCu1g6QpWrk16mZw0SiyuLPRS7WKr
skMa8dTz8Tw5RqkHYixBRrZ1TRLr4bIxPzRZnzfgvvUPx2/jzU3MO8jEbQKBgC3T
LBXDQsVt5l1BLPblvufQVjSRF0yh6fVtrFwDr4hfiDotiN8X3hoGVab8It/gOiky
xLwNo2ZEOTTCtU+Y0GmJRF+gihpU1wd06vrR+I/pfO6KVeEK54GfNOb2yDEnuuda
DS75toe8Bn6TFiNVv9X+YgtsyefSP8DJBXN6KQGvAoGBAI8gGREl4AsV9DuMmGCl
VVYLjdZfjidtZdT6oOEc2KcCaOCA3QgRie3nbYiGNZQYoNMHzhvz2OZ8FYpOm+q/
EtcXiXcOAc6Lyx96CeLvbRszqagpYNzIxBlFUSSq4wL290lPH7iF84//hIdjWLfr
qXrIx5o0xevfOYFMfA2YMhPa
-----END PRIVATE KEY-----
"""

        let signer = try FirebaseCustomTokenSigner(
            serviceAccountEmail: "demo@google.com",
            serviceAccountPrivateKey: demoPrivateKey
        )

        let token = try signer.createCustomToken(
            uid: "1234567890",
            customClaims: ["premium_account": ClaimValue.bool(true)]
        )

        print(token)

        let payload = try signer.verify(token: token)

        print("payload: \(payload)")
        
    }
}
