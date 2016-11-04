local kiip = require( "plugin.kiip" )
kiip.init("3b46e5f42299f1697193bb843ed8dbf4", "90c4f68ebb4817b3edf24799b04df22c")
kiip.setProperties({testMode = true})
local composer = require( "composer" )

-- Hide status bar
display.setStatusBar( display.HiddenStatusBar )

-- Seed the random number generator
math.randomseed( os.time() )

-- Reserve channel 1 for background music
audio.reserveChannels( 1 )
-- Reduce the overall volume of the channel
audio.setVolume( 0.5, { channel=1 } )

-- Go to the menu screen
composer.gotoScene( "menu" )
