local kiip = require( "plugin.kiip" )
kiip.init("e034e855dee6bc37a2d1a0077719e358", "84971bc43a995c8eba495f71749c26e9")
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
