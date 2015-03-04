require 'libs/color'
require 'libs/utils'
require 'libs/Tserial'

Gamestate = require 'libs/hump.gamestate'
Class = require 'libs/hump.class'
lume = require 'libs/lume'

Jutils = require 'libs/Jutils'

-- Game configurations and variables
require 'G'

-- Other system module
require 'modules/a_Utils'
require 'modules/a_Input'
require 'modules/a_Preload'

-- States inclusion
require 'states/introState'
require 'states/menuState'
require 'states/playState'
require 'states/resultState'
require 'states/endingState'
require 'states/creditState'
require 'states/pauseState'

function love.load()
   
   -- love.window.setMode(0,0, {fullscreen=true})
   -- if love.system.getOS() == 'Android' then
      -- love.window.setFullscreen(true)
   -- end

   loader = require 'libs/loader'
   loader.setBaseImageDir('assets')
   loader.setBaseAudioDir('assets')
   loader.setBaseFontDir('assets')
   loader.init()

   screenScale = {
      x = love.graphics.getWidth()/gRes.w,
      y = love.graphics.getHeight()/gRes.h
   }

   -- love.graphics.setDefaultFilter( 'nearest', 'nearest')

   preload()
   Input:init()

	Gamestate.registerEvents()
   Gamestate.switch(intro)
   -- Gamestate.switch(result)
   -- Gamestate.switch(play)
	-- Gamestate.switch(ending)
   -- Gamestate.switch(result)
   Gamestate.switch(menu)

end

function love.update(dt)
   if G.debugMode then
      require('libs/lovebird').update()
   end
end

function love.draw()
   love.graphics.scale(screenScale.x, screenScale.y)
end

function love.keyreleased(key)
	if key == "escape" then
      os.exit()
   end
end


---------

-- Mobile mouse module
M = {}

-- function M.getX()
--    return love.mouse.getX() / screenScale.x
-- end

-- function M.getY()
--    return love.mouse.getY() / screenScale.y
-- end

--------

function love.mousepressed(x, y, button, isTouch)
   if isTouch then
      Input.mode = 'touch'
   end
end

function love.keypressed(k)
   Input.mode = 'keyboard'
end

function love.touchpressed(id, x, y)
   Input.mode = 'touch'
end

function love.gamepadpressed(id, x, y)
   Input.mode = 'gamepad'
end

function love.joystickadded()
   Input:GamepadAssign()
   Input.mode = 'gamepad'
end

function love.joystickremoved()
   Input.mode = 'keyboard'
   Input:GamepadAssign()
end
