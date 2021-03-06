-----------------------------------------------------------
----    Pixels invasion
----    Pakoskyfrog 2013/02/04 15:03:59
-----------------------------------------------------------

math.randomseed(os.time())

------------------------
--  Dependencies
cd = require 'sources/lib/colorData'

require 'sources/gui/button'
require 'sources/gui/actions'
require 'sources/gui/hud'
require 'sources/gui/choice'
require 'sources/apps'
require 'sources/mainmenu'
require 'sources/game'
require 'sources/backgrounds/stars'
require 'sources/entities/shape'
require 'sources/gen/conected'
require 'sources/entities/foe'
require 'sources/entities/ship'
require 'sources/entities/shield'
require 'sources/entities/squadron'

require 'debug/dump'


------------------------
--  INIT

------------------------
--  L�ve callbacks
function love.load()
    Apps:load()
end

function love.keypressed(key)
    Apps:keypressed(key)
    
end

function love.mousepressed(x, y, button)
    Apps:mousepressed(x, y, button)
end

function love.keyreleased(key)
    Apps:keyreleased(key)
end

function love.mousereleased(x, y, button)
    Apps:mousereleased(x, y, button)
end

function love.draw()
    Apps:draw()
end

function love.update(dt)
    Apps:update(dt)
    
    -- framerate limiter
    if dt < 0.016 then  --60 FPS
        love.timer.sleep(0.016 - dt)
    end
end



