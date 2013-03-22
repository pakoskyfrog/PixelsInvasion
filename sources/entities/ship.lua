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
CShip.pxlSize = 5


------------------------
--  Constructor
function CShip:create(N)
    local Ship = {}
    setmetatable(Ship, CShip)
    
    Ship.size = N or 25
    -- Ship.parent = sender
    
    Ship.shape = CShape:create(Ship, 'LR', Ship.size)
    Ship.pos = {x=Apps.w/2, y=Apps.h-20-Ship.shape.height/2*Ship.pxlSize}
    Ship.speed = {250-N*1.5, 0}
    Ship.shield = CShield:create(Ship, N*3.66, 0.1)
    Ship.hp = N*2
    Ship.Hp = Ship.hp
    
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
    local dx = self.speed[1] * dt
    
    if love.keyboard.isDown('up') or love.keyboard.isDown('w') then
        
    elseif love.keyboard.isDown('down') or love.keyboard.isDown('s') then
        
    elseif love.keyboard.isDown('left') or love.keyboard.isDown('a') then
        self.pos.x = self.pos.x - dx
    elseif love.keyboard.isDown('right') or love.keyboard.isDown('d') then
        self.pos.x = self.pos.x + dx
    end
    
    -- shield
    if self.shield then self.shield:update(dt) end
end

function CShip:mousepressed(x, y, btn)
    
end

function CShip:keypressed(key)
    -- 123    = bullet, laser, choose bomb
    -- space  = fire
    -- b      = launch bomb
    
    -- movements are dealt with in update
    
    -- star field
    if key == 'a' or key == 'left' then
        Apps.state.bg.dir[1] =  -0.5
    elseif key == 'd' or key == 'right' then
        Apps.state.bg.dir[1] =   0.5
    end
    
end

function CShip:mousereleased(x, y, btn)
    
end

function CShip:keyreleased(key)
    if key == 'a' or key == 'd' or key == 'left' or key == 'right' then
        Apps.state.bg.dir[1] =  0
    end
end

------------------------
--  Static functions


------------------------
--  Member functions
function CShip:getType()
    return self.type
end

function CShip:centerMe()
    --------------------
    --  This will position the ship at the center of its line
    self.pos = {x=Apps.w/2, y=Apps.h-20-self.shape.height/2*self.pxlSize}
end



print "CShip loaded"