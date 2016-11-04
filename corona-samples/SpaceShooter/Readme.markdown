# TemplateProject

> --------------------- ------------------------------------------------------------------------------------------
> __Revision__          [REVISION_LABEL](REVISION_URL)
> __Keywords__          iOS, Android
> __See also__          
> --------------------- ------------------------------------------------------------------------------------------

## Overview

You should start all new Corona projects by copying this project.

This project allows you to:

* develop cross-platform Corona Enterprise apps
* create plugins for Corona Enterprise

## Code Walkthrough

### iOS

#### 
* The `AppCoronaDelegate` implements the `CoronaDelegate` protocol. In particular it implements the method `willLoadMain:` which is your opportunity to modify the Lua state prior to execution of `main.lua`. 
* This method creates a Lua library called `myTests` and binds native functions to that library.

### Android

* The Android "Application" class is overridden in this application so that a CoronaRuntimeListener can be set up before a Corona activity has been displayed.  This listener detects when a Corona runtime has been loaded, started, suspended, resumed, and exiting.  The listener's onLoaded() method is the application's opportunity to add its own custom Lua API to the Corona project.  See source file "CoronaApplication.java" on how to implement this.
* Lua functions are implemented in Java by using the "com.naef.jnlua.NamedJavaFunction" interface.  All source files ending with "*LuaFunction.java" in this sample project implement this interface.  They demonstrate how to use a LuaState object to perform fundamental operations such as fetching argument values, returning values, working with tables/arrays, and calling Lua functions from Java.
* Source file "AsyncCallLuaFunction.java" demonstrates how to safely call a Lua function from another thread.  This is important if you want to set up an asynchronous Lua function that accepts a Lua callback to be called from another thread once the asynchronous operation has ended.
* 3rd party libraries such as InMobi and inneractive have been excluded from this project.  This reduces the size of the resulting APK file.  Attempting to use these libraries from Lua will cause an exception to be thrown which will crash the application.

