# Kiip SDK - Unity Samples

A Unity sample project for using the Kiip SDK.


## Contents

### Kiip SDK

It contains Kiip SDK and Unity Wrapper for commnuication with Kiip sdk. 

A library project that is used by all the samples which you can also use in your app! It provides code that simplifies the Kiip integration.


### Unity sample scene

Sample scene in kiip/testsupport that shows how to do all the basics: save moments, attach listeners, and more.
It also provides examples on how to customize the Kiip experience in your app.

Notification types:
* Default: A basic notification displayed by Kiip.
* Custom: A notification that uses a custom view defined by the developer, but displayed and managed by Kiip.


## Instructions

1. Set up your application in the Developer Console. For more information:

    http://app.kiip.me
1. Launch Unity
1. Select *Open Project*
1. Select the unity-samples directory of this repository
1. Configure your Kiip application information in the inspector for the Kiip GameObject
1. (Android only) before building your apk select the "Generate AndroidManifest.xml file" from the Kiip menu to create an AndroidManifest.xml file
1. Build and run on your device and watch the logs for relevant information

**Note, this repo currently contains SDK version 2.2.0**


### Integration instructions for an existing project

1. Import the unitypackage into your project
1. Drag the Kiip prefab into your loading scene (this should be placed in a scene that is only visited once so that only one will ever exist)
1. Configure your Kiip application information in the inspector for the Kiip GameObject
1. Start calling any methods on the Kiip class wherever relevant for your game
1. (Android only) before building your apk select the "Generate AndroidManifest.xml file" from the Kiip menu to create an AndroidManifest.xml file


## Support

For integration and reference, see our docs at http://docs.kiip.me