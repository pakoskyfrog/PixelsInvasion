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
CFoe.pxlSize = 5
CFoe.init = false

------------------------
--  Constructor
local function sizeToN(s)
    if type(s)=='number' then return s end
    
    if s == 's' then
        return math.random(9,11)
    elseif s == 'm' then
        return math.random(13,17)
    elseif s == 'b' then
        return math.random(19,25)
    elseif s == 'S' then
        return math.random(50,75)
    end
    
    return 10
end

function CFoe:create(sender, kind, size, dir, shape)
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
    
    Foe.speed = {80*(Foe.dir=='L' and -1 or 1), 7}  -- pxls/sec
    
    return Foe
end


------------------------
--  Callbacks

function CFoe:load()
    
end

function CFoe:draw()
    
    if not self.init then return end

    -- shield
    if self.shield then self.shield:draw() end
    
    -- shape
    self.shape:draw()
    
    -- charging weaponnery
    -- ???
    
end

function CFoe:testWall()
    --------------------
    --  This will test if the foe is about to collide into a wall
    local margin = 15
    local d = self.pxlSize * self.shape.width/2
    local cx = self.pos.x
    local tx, Tx
    if self.speed[1] < 0 then
        tx = cx - d
        if not self.voisLeft then
            Tx = margin
        else
            local vv = self.voisLeft
            Tx = vv.pxlSize*vv.shape.width/2 + vv.pos.x + margin/2
        end
        return tx <= Tx
    else
        tx = cx + d       
        if not self.voisRight then
            Tx = Apps.w - margin
        else
            local vv = self.voisRight
            Tx = -vv.pxlSize*vv.shape.width/2 + vv.pos.x - margin/2
        end
        return tx >= Tx
    end
end
function CFoe:update(dt)
    if self.shield then self.shield:update(dt) end
    
    local dx = self.speed[1] * dt
    local dy = self.speed[2] * dt
    self:move(dx,dy)
    
    if self:testWall() then
        self.speed[1] = -self.speed[1]
    end
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
function CFoe:move(dx,dy)
    local x, y = self.pos.x, self.pos.y
    self.pos = {x=x+dx,y=y+dy}
end
function CFoe:initialize(hp, wp, shieldPts, shieldRegen, color)
    --------------------
    --  This init the foe, called from squadron or game
    
    self.hp = hp or 1
    -- self.weapon = CWeapon:create(wp or 'none')
    self.shield = CShield:create(self, shieldPts or 0, shieldRegen or 0)
    self.color = color or {255,255,255}
    
    self.init = true
end

function CFoe:duplicate()
    --------------------
    --  This will make and return a clean copy
    local Foe = {}
    setmetatable(Foe, CFoe)
    Foe.kind = self.kind
    Foe.parent = self.parent
    Foe:setPosition(self.pos.x, self.pos.y)
    Foe.dir = self.dir
    Foe.shape = self.shape:duplicate()
    Foe.size  = self.shape.size
    Foe.shape.parent = Foe
    Foe.hp = self.hp
    -- Foe.weapon = self.weapon:duplicate()
    Foe.color = cd.copyColor(self.color)
    Foe.shield = self.shield:duplicate()
    Foe.shield.parent = Foe
    Foe.speed  = {self.speed[1], self.speed[2]}
    Foe.init = self.init
    
    return Foe
end


function CFoe:generateShape()
    --------------------
    --  This will call the generation of a new shape
    local k = ''
    if self.kind == 'n' then -- normal
        k = 'LR'
    elseif self.kind == 'b' then -- bombardier
        if self.dir == 'L' then k = 'ADiag'
        else k = 'Diag' end
    else -- fast
        k = 'UB'
    end
    
    self.shape = CShape:create(self, k, self.size)
end



print "CFoe loaded"