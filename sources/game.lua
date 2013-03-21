-- Pakoskyfrog 2013/03/20 23:16:39

-----------------------------------------------------------
----    CGame definition
-----------------------------------------------------------

------------------------
-- Description
--[[
    The game state. It handles HUD and game displays, user interface, the engine itself.
    It will also creates/genereates scenes and waves of enemies.
]]

-----------------------------------------------------------
require 'sources/gui/hud'

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
    Game.army = {} -- squadrons collection
    
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
    for index, squad in ipairs(self.army) do
        squad:draw()
    end
    
    -- dev codes
    -- if ss1 then
        -- ss1:draw()
        -- love.graphics.setColor(255,255,255)
        -- love.graphics.print('sq', 5, 400)
    -- end
end

function CGame:update(dt)
    self.ship:update(dt)
    for index, squad in ipairs(self.army) do
        squad:update(dt)
    end
    
    
    -- dev codes
    -- if ss1 then
        -- ss1:update(dt)
    -- end
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
        -- ss1 = CShape:create({pos={x=250, y=250}, pxlSize=7}, 'LR', 50)
        local f1 = CFoe:create(self, 'n', 's')
        f1:initialize(12, 'none', math.random(5,10))
        local f2 = CFoe:create(self, 'n', 'b')
        f2:initialize(25, 'bullet', math.random(25,50))
        self.army[1] = CSquadron:create(self, f2, {1})
        self.army[2] = CSquadron:create(self, f1, {2,3,4})
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