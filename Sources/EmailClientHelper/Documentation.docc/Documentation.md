# ``EmailClientHelper``

Helper package to send an email using 3rd party apps

## Overview

A simple helper package to send an email using 3rd party email clients. Supported clients include Gmail, Outlook and Yahoo Mail.

Currently, the package supports iOS, macOS, Mac Catalyst and visionOS.

You will also need to add this in your app's `Info.plist`:

```
<key>LSApplicationQueriesSchemes</key>
<array>
  <string>googlegmail</string>
  <string>ms-outlook</string>
  <string>ymail</string>
</array>
```

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
