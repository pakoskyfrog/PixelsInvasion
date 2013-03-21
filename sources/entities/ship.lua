-- Pakoskyfrog 2013/03/21 06:13:27

-----------------------------------------------------------
----    CShip definition
-----------------------------------------------------------

------------------------
-- Description
--[[
    Your space ship, last barrier against world invasion.
    Entity handling with the ship, keyboard/UI, drawing, ...
]]

-----------------------------------------------------------
------------------------
--  Init
CShip = {}
CShip.__index = CShip

------------------------
--  Properties
CShip.type = "CShip"
CShip.pxlSize = 7


------------------------
--  Constructor
function CShip:create(N)
    local Ship = {}
    setmetatable(Ship, CShip)
    
    Ship.size = N or 25
    -- Ship.parent = sender
    
    Ship.shape = CShape:create(Ship, 'LR', Ship.size)
    Ship.pos = {x=Apps.w/2, y=Apps.h-20-Ship.shape.height/2*Ship.pxlSize}
    
    return Ship
end


------------------------
--  Callbacks

function CShip:load()
    
end

function CShip:draw()
    -- shield
    if self.shield then self.shield:draw() end
    
    -- shape
    self.shape:draw()
    
    -- charging weaponnery
    -- ???
end

function CShip:update(dt)
    -- local dt = love.timer.getDelta()
    local dx = 250 * dt
    
    if love.keyboard.isDown('up') or love.keyboard.isDown('w') then
        
    elseif love.keyboard.isDown('down') or love.keyboard.isDown('s') then
        
    elseif love.keyboard.isDown('left') or love.keyboard.isDown('a') then
        self.pos.x = self.pos.x - dx
    elseif love.keyboard.isDown('right') or love.keyboard.isDown('d') then
        self.pos.x = self.pos.x + dx
    end
    
end

function CShip:mousepressed(x, y, btn)
    
end

function CShip:keypressed(key)
    -- 123    = bullet, laser, choose bomb
    -- space  = fire
    -- b      = launch bomb

end

function CShip:mousereleased(x, y, btn)
    
end

function CShip:keyreleased(key)
    
end

------------------------
--  Static functions


------------------------
--  Member functions
function CShip:getType()
    return self.type
end




print "CShip loaded"