[![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Finfinitepower18%2FEmailClientHelper%2Fbadge%3Ftype%3Dswift-versions)](https://swiftpackageindex.com/infinitepower18/EmailClientHelper)
![GitHub](https://img.shields.io/github/license/infinitepower18/emailclienthelper)

# EmailClientHelper
A simple helper package to send an email using 3rd party email clients. Supported clients include Gmail, Outlook and Yahoo Mail.

Currently, the package only supports iOS and visionOS.

You will also need to add this in your app's `Info.plist`:

```
<key>LSApplicationQueriesSchemes</key>
<array>
  <string>googlegmail</string>
  <string>ms-outlook</string>
  <string>ymail</string>
</array>
```

[![ko-fi](https://ko-fi.com/img/githubbutton_sm.svg)](https://ko-fi.com/F1F1K06VY)

## Usage

To check if the Gmail app is available on the user's device:

``` swift
if EmailClientHelper.isClientAvailable(.gmail) {
    return true
} else {
    return false
}
```

To send an email using the Gmail app:

``` swift
EmailClientHelper.sendEmail(client: .gmail, to: "example@example.com")
```
