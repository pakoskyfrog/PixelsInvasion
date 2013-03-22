-- Pakoskyfrog 2013/03/22 15:07:48

-----------------------------------------------------------
----    CShipChoice definition
-----------------------------------------------------------

------------------------
-- Description
--[[
    This is the understate where the player will choose a new ship
    He can choose betweeen three different ships
    fighter : small and fast, but a bit weak
    frigate : medium size and speed, good compromise between maneuverability and thoughness
    cruiser : big and sturdy, tank look alike can sustain heavy damages, slow to maneuver
]]

------------------------
-- TODO list
--[[
    * build 3 shapes
    * make the ships according to size/style : speed, armor, shield, ...
    * Name of the ships ?
    * display BG + 3 slots + title + infos on the selected ship
    * export to profil
]]

-----------------------------------------------------------
------------------------
--  Init
CShipChoice = {}
CShipChoice.__index = CShipChoice

------------------------
--  Properties
CShipChoice.type = "CShipChoice"


------------------------
--  Constructor
function CShipChoice:create(sender)
    local ShipChoice = {}
    setmetatable(ShipChoice, CShipChoice)
    ShipChoice.parent = sender
    
    
    
    return ShipChoice
end


------------------------
--  Callbacks

function CShipChoice:load()
    
end

function CShipChoice:draw()
    
end

function CShipChoice:update(dt)
    
end

function CShipChoice:mousepressed(x, y, btn)
    
end

function CShipChoice:keypressed(key)
    
end

function CShipChoice:mousereleased(x, y, btn)
    
end

function CShipChoice:keyreleased(key)
    
end

------------------------
--  Static functions

------------------------
--  Sets / Gets
function CShipChoice:getType() return self.type end


------------------------
--  Member functions




print "CShipChoice loaded"