-- Pakoskyfrog 2013/03/21 06:55:51

-----------------------------------------------------------
----    CShield definition
-----------------------------------------------------------

------------------------
-- Description
--[[
    This is the shield of every ship.
    Drawn with 3 ellipses.
    A gradient as color for power (cyan, yellow, magenta) = (weak, normal, strong)
]]

-----------------------------------------------------------
------------------------
--  Init
CShield = {}
CShield.__index = CShield

------------------------
--  Properties
CShield.type = "CShield"
CShield.color = {"regular", cd.getNamedColor('darkCyan'), cd.getNamedColor('cyan'), cd.getNamedColor('yellow'), cd.getNamedColor('magenta'), cd.getNamedColor('darkMagenta') }

------------------------
--  Constructor
function CShield:create(sender, power, regen)
    -- regen is a % of the power max per second
    local Shield = {}
    setmetatable(Shield, CShield)
    
    Shield.parent = sender
    -- for now it's a circle
    Shield.radius = math.max(sender.shape.width, sender.shape.height)*0.5
    -- Shield.radiusW = sender.shape.width*0.5 / Shield.radius
    -- Shield.radiusH = sender.shape.height*0.5 / Shield.radius
    
    Shield.radius = Shield.radius * sender.pxlSize
    
    Shield.pw = power
    Shield.Pw = power -- const = power max
    
    Shield.regen = regen or 0
    
    return Shield
end


------------------------
--  Callbacks

function CShield:load()
    
end

local function addAlpha(c, a)
    return {c[1], c[2], c[3], a}
end
function CShield:draw()
    if self.pw <= 0 then return end
    
    local cx = self.parent.pos.x
    local cy = self.parent.pos.y
    
    local clr = self:getColor()
    
    love.graphics.setLineWidth(2)
    love.graphics.setColor(clr)
    love.graphics.circle('line', cx, cy, self.radius*1.3, 32)--, self.radiusW, self.radiusH)
    love.graphics.setColor( addAlpha(clr, 175) )
    love.graphics.circle('line', cx, cy, self.radius*1.1, 32)
    love.graphics.setColor( addAlpha(clr, 100) )
    love.graphics.circle('line', cx, cy, self.radius*0.9, 32)
end

function CShield:update(dt)
    -- regen
    self.pw = self.pw + dt * self.regen * self.Pw
    self.pw = math.min(self.pw, self.Pw)
    self.pw = math.max(self.pw, 0)
end

function CShield:mousepressed(x, y, btn)
    
end

function CShield:keypressed(key)
    
end

function CShield:mousereleased(x, y, btn)
    
end

function CShield:keyreleased(key)
    
end

------------------------
--  Static functions


------------------------
--  Member functions
function CShield:getType()
    return self.type
end
function CShield:getColor()
    --------------------
    --  This will return the color according to the power left
    local i = self.pw / self.Pw
    if self.Pw > 1000 then
        -- nothing , full power
    elseif self.Pw > 500 then
        i = i * 0.75
    elseif self.Pw > 250 then
        i = i * 0.50
    else
        i = i * 0.25
    end
    return cd.evalGradientAt(self.color, i)
end

function CShield:duplicate()
    --------------------
    --  This will make a clean copy of the shield
    local Shield = {}
    setmetatable(Shield, CShield)
    
    Shield.parent  = self.parent
    Shield.radius  = self.radius
    -- Shield.radiusH = self.radiusH
    -- Shield.radiusW = self.radiusW
    
    Shield.pw = self.pw
    Shield.Pw = self.Pw
    
    Shield.regen = self.regen
    
    return Shield
end



print "CShield loaded"