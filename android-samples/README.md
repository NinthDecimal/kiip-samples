# Kiip SDK - Android Samples

A collection of Android sample projects for using the Kiip SDK.


## Contents

### BaseKiipUtils

A library project that is used by all the samples which you can also use in your app! It provides code that simplifies the Kiip integration.


### SimpleSample

Sample app that shows how to do all the basics: save moments, attach listeners, and more.


### CustomSample

Sample that that provides examples on how to customize the Kiip experience in your app.

Notification types:
* Default: A basic notification displayed by Kiip.
* Custom: A notification that uses a custom view defined by the developer, but displayed and managed by Kiip.
* Integrated: A completely custom integration that the developer defines themselves.


## Instructions

1. Set up your application in the Developer Console. For more information:

    http://app.kiip.me
1. Download the latest Kiip SDK from http://docs.kiip.me/en/downloads
1. Copy the `KiipSDK` library project into `libprojects/`
1. Launch Android Studio
1. Select *Open Project*
1. Select the top-level directory of this repository
1. Modify the `APP_KEY` and `APP_SECRET` in the project's `Application` class to your credentials, as given by the Developer Console.
1. Compile and run


### Add Kiip to an existing project

1. Create `libprojects` directory in your project
1. Copy `libprojects/BaseKiipUtils` and `KiipSDK` to `libprojects/`
1. Add `BaseKiipUtils` and `KiipSDK` as dependencies to your project:

	dependencies {
	    compile project(':libprojects:BaseKiipUtils')
	    compile project(':libprojects:KiipSDK')
	}


## Support

For integration and reference, see our docs at http://docs.kiip.me
