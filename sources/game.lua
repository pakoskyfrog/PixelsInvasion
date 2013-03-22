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
function CGame:create(options)
    local Game = {}
    setmetatable(Game, CGame)
    
    Game.hud = CHud:create(Game)
    
    -- Game.ship = CShip:create()
    Game.army = {} -- squadrons collection
    
    return Game
end


------------------------
--  Callbacks

function CGame:load()
    
end

function CGame:draw()
    -- game's background
    

    -- players's ship
    if self.ship then self.ship:draw() end
    
    -- enemies
    for index, squad in ipairs(self.army) do
        squad:draw()
    end
    
    -- projectils
    -- powerups
    
    -- dev codes
    -- if ss1 then
        -- ss1:draw()
        -- love.graphics.setColor(255,255,255)
        -- love.graphics.print('sq', 5, 400)
    -- end
    
    -- HUD
    self.hud:draw()
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
    
    -- self.hud:update(dt)
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
        f1:initialize(12, 'none', 0)
        local f2 = CFoe:create(self, 'n', 'm')
        f2:initialize(25, 'bullet', math.random(25,50))
        self.army[1] = CSquadron:create(self, f2, {1})
        self.army[2] = CSquadron:create(self, f1, {2,3,4})
    end
    if key=='j' then
        print('hitting shield')
        self.ship.shield.pw = self.ship.shield.pw * 0.66
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