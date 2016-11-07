# Space Shooter

## Overview
This project searves as example how to integrate Kiip Corona Plugin.

This project shows you:

* How to init plugin
* How to set test mode and other properties
* How to save a moment
* How to show a poptart
* How to start a session
* How to end a session

## Set Up Account Requirements
1. Go to [Kiip Website](http://www.kiip.me/) to create an account and obtain a key and secret.
2. Go to [CoronaLab website](https://coronalabs.com/) and download Corona SDK and Corona enterprise SDK and follow the steps to setup.
3. Open main.lua from corona-samples/SpaceShooter/Corona/main.lua file and replace KIIP_KEY and KIIP_SECRET with the key and secret you obtain from step 1.
4. Clone this repository and you can find both android and ios project in /android and /ios directory. Simply open the app project in your IDE (Android Studio for Androi and Xcode for iOS) and run it.

## API docs
place kiip init in your main.lua
``` lua
local kiip = require( "plugin.kiip" )
kiip.init(YOUR_KEY, YOUR_SECRET)
```
you can set testMode or extra properties
``` lua
kiip.setProperties({
    testMode = true --optional
})
```
to save a moment
``` lua
kiip.saveMoment({
    saveMomentId = "test" -- required
})
```
to display a poptart, note: prior to this call, you must call saveMoment to successfuly obtain a poptart.
``` lua
kiip.showPoptart({})
```
please notify kiip when the app is on foreground by calling startSession
``` lua
kiip.startSession({})
```
please notify kiip when the app is in background by calling endSession
``` lua
kiip.endSession({})
```
