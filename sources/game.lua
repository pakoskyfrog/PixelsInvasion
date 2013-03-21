-- Pakoskyfrog 2013/03/20 23:16:39

-----------------------------------------------------------
----    CGame definition
-----------------------------------------------------------

------------------------
-- Description
--[[
    The game state. It handles HUD and game displays, user interface, the engine itself.
]]

-----------------------------------------------------------
------------------------
--  Init
CGame = {}
CGame.__index = CGame

------------------------
--  Properties
CGame.type = "CGame"


------------------------
--  Constructor
function CGame:create()
    local Game = {}
    setmetatable(Game, CGame)
    
    Game.ship = CShip:create()
    
    return Game
end


------------------------
--  Callbacks

function CGame:load()
    
end

function CGame:draw()
    love.graphics.setFont(Apps.fonts.default)
    love.graphics.setColor(255,255,255)
    love.graphics.print('You\'re in game', 5, 5)
    
    self.ship:draw()
    
    -- dev codes
    if s1 then
        s1:draw()
    end
end

function CGame:update(dt)
    self.ship:update(dt)
end

function CGame:mousepressed(x, y, btn)
    
end

function CGame:keypressed(key)
    if key == 'escape' then
        Actions.activateMainMenu()
    end
    
    self.ship:keypressed(key)
    
    -- dev codes
    if key == 's' then
        if not s1 then
            s1 = CShape:create({pos={x=250, y=250}, pxlSize=7}, 'LR', 50)
        else
            s1 = nil
        end
    end
end

function CGame:mousereleased(x, y, btn)
    
end

function CGame:keyreleased(key)
    
end

------------------------
--  Static functions


------------------------
--  Member functions
function CGame:getType()
    return self.type
end




print "CGame loaded"