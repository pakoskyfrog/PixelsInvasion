-- Pakoskyfrog 2013/03/21 05:44:22

-----------------------------------------------------------
----    CFoe definition
-----------------------------------------------------------

------------------------
-- Description
--[[
    This is the entity behind every enemy.
]]

-----------------------------------------------------------
------------------------
--  Init
CFoe = {}
CFoe.__index = CFoe

------------------------
--  Properties
CFoe.type = "CFoe"
CFoe.pxlSize = 7
CFoe.init = false

------------------------
--  Constructor
local function sizeToN(s)
    if type(s)=='number' then return s end
    
    if size == 's' then
        return math.random(9,11)
    elseif size == 'm' then
        return math.random(13,17)
    elseif size == 'b' then
        return math.random(19,25)
    elseif size == 'S' then
        return math.random(50,75)
    end
    
    return 10
end

function CFoe:create(sender, kind, size, shape, dir)
    local Foe = {}
    setmetatable(Foe, CFoe)
    
    size = size or 's' -- s / m / b / S
    -- s = small
    -- m = medium
    -- b = big
    -- S = starship
    kind = kind or 'n' -- n / b / f
    -- n = normal
    -- b = bombardier
    -- f = fast
    
    Foe.kind = kind
    Foe.parent = sender
    Foe.pos = {x=0, y=0}
    Foe.dir = dir or (math.random()<0.5 and 'L' or 'R')
    
    if shape then
        Foe.shape = shape:duplicate()
        Foe.size  = shape.size
    else
        Foe.size = sizeToN(size)
        Foe:generateShape()
    end
    
    return Foe
end


------------------------
--  Callbacks

function CFoe:load()
    
end

function CFoe:draw()
    -- shield
    if self.shield then self.shield:draw() end
    
    -- shape
    self.shape:draw()
    
    -- charging weaponnery
    -- ???
end

function CFoe:update(dt)
    
end

function CFoe:mousepressed(x, y, btn)
    
end

function CFoe:keypressed(key)
    
end

function CFoe:mousereleased(x, y, btn)
    
end

function CFoe:keyreleased(key)
    
end

------------------------
--  Static functions


------------------------
--  Member functions
function CFoe:getType()
    return self.type
end
function CFoe:setPosition(x,y)
    self.pos = {x=x,y=y}
end
function CFoe:init(hp, wp, shieldPts)
    --------------------
    --  This init the foe, called from squadron or game
    
    self.hp = hp or 1
    -- self.weapon = CWeapon:create(wp or 'bullet')
    -- self.shield = CShield:create(shieldPts or 0)
    self.init = true
end



function CFoe:generateShape()
    --------------------
    --  This will call the generation of a new shape
    local k = ''
    if kind == 'n' then -- normal
        k = 'LR'
    elseif kind == 'b' then -- bombardier
        if self.dir == 'L' then k = 'ADiag'
        else k = 'Diag' end
    else -- fast
        k = 'UB'
    end
    
    self.shape = CShape:create(self, k, self.size)
end



print "CFoe loaded"