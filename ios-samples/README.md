# Kiip SDK - iOS Samples

A collection of iOS sample projects for using the Kiip SDK.


## Contents

### SimpleSample

Sample app that shows how to do all the basics: save moments, attach listeners, and more.


## Instructions

1. Create an account & set your application up at http://app.kiip.me
1. Download the latest Kiip SDK from http://docs.kiip.me/en/downloads
1. Copy `KiipSDK.framework` into the root directory of this repository
1. Open one of the sample projects in Xcode
1. Modify the `KP_APP_KEY` and `KP_APP_SECRET` in the project's `*-Prefix.pch` file to your credentials, as given by the Developer Console.
1. Compile and run


### Add Kiip to an existing project

1. Add `KiipSDK.framework` to your project
1. Add `KiipResources.bundle` from `KiipSDK.framework/Resources/` to your project
1. Use `#import <KiipSDK/KiipSDK.h>`

## Frameworks

Frameworks are already linked that are required, but for reference, the following are required:

* CoreTelephony
* QuartzCore
* SystemConfiguration
* AdSupport
* PassKit
* MediaPlayer

## Support

For integration and reference, see our docs at http://docs.kiip.me
