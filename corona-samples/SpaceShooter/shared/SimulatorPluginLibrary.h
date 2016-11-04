// ----------------------------------------------------------------------------
// 
// SimulatorPluginLibrary.h
// Copyright (c) 2012 Corona Labs Inc. All rights reserved.
// 
// ----------------------------------------------------------------------------

#ifndef _SimulatorPluginLibrary_H__
#define _SimulatorPluginLibrary_H__

#include "CoronaLua.h"
#include "CoronaMacros.h"

// ----------------------------------------------------------------------------

// This corresponds to the name of the library, e.g. [Lua] require "plugin.library"
// where the '.' is replaced with '_'
CORONA_EXPORT int luaopen_plugin_library( lua_State *L );

// ----------------------------------------------------------------------------

#endif // _SimulatorPluginLibrary_H__
