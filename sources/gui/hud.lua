-- Pakoskyfrog 2013/03/22 14:54:26

-----------------------------------------------------------
----    CHud definition
-----------------------------------------------------------

------------------------
-- Description
--[[
    This is the HUD, head up display. It handles on screen informations displays.
]]

------------------------
-- TODO list
--[[
    * Score
    * weaponnery
    * Forward distance traveled
    * name of the quadrant
    * 
]]

-----------------------------------------------------------
------------------------
--  Init
CHud = {}
CHud.__index = CHud

------------------------
--  Properties
CHud.type = "CHud"


------------------------
--  Constructor
function CHud:create(sender)
    local Hud = {}
    setmetatable(Hud, CHud)
    Hud.parent = sender
    
    
    return Hud
end


------------------------
--  Callbacks

function CHud:load()
    
end

function CHud:draw()
    -- tmp
    -- love.graphics.setFont(Apps.fonts.default)
    -- love.graphics.setColor(255,255,255)
    -- love.graphics.print('HUD : You\'re in game', 5, 5)
    
    if not self.parent.ship then return end
    
    -- retrieve infos :
    local sc = self.parent.score or 0 -- score
    local Dt = self.parent.dist  or 0 -- distance traveled
    -- selected weapon
    -- bombs + ammo left + recharging
    local hp = self.parent.ship.hp or 1 -- armor left
    local HP = self.parent.ship.Hp or 1 -- armor max
    local sp = self.parent.ship.shield.pw or 0 -- shield left
    local SP = self.parent.ship.shield.Pw or 0 -- shield max
    
    self:drawScore(sc)
    self:drawDist(Dt)
    -- self:drawWeapons(???)
    -- self:drawBomnbs(???)
    self:drawArmor(hp, HP)
    self:drawShield(sp, SP)
end
function CHud:drawScore(sc)
    local x = 0.5*(Apps.w-Apps.fonts.default:getWidth(sc)) -- centering
    love.graphics.setFont(Apps.fonts.default)
    love.graphics.setColor(255,255,255)
    love.graphics.print(tostring(sc), x, 5)
end
function CHud:drawDist(d)
    d = tostring(math.floor(d*100)*0.01).. ' a.u.'
    local x = 0.5*(Apps.w-Apps.fonts.small:getWidth(d)) -- centering
    love.graphics.setFont(Apps.fonts.small)
    love.graphics.setColor(155,155,155)
    love.graphics.print(d, x, 30)
end
function CHud:drawArmor(hp, HP)
    local grad = {"regular", cd.getNamedColor('red'), cd.getNamedColor('yellow'), cd.getNamedColor('green')}
    local rh = 150
    local rw = 15
    local ind = hp/HP
    love.graphics.setColor(cd.evalGradientAt(grad, ind))
    love.graphics.rectangle('fill', Apps.w-rw, Apps.h-rw-ind*rh, rw, ind*rh)
end
function CHud:drawShield(hp, HP)
    local grad = {"regular", cd.getNamedColor('red'), cd.getNamedColor('blue'), cd.getNamedColor('cyan')}
    local rh = 150
    local rw = 15
    local ind = hp/HP
    love.graphics.setColor(cd.evalGradientAt(grad, ind))
    love.graphics.rectangle('fill', Apps.w-rw*2.5, Apps.h-rw-ind*rh, rw, ind*rh)
end

function CHud:update(dt)
    
end

function CHud:mousepressed(x, y, btn)
    
end

function CHud:keypressed(key)
    
end

function CHud:mousereleased(x, y, btn)
    
end

function CHud:keyreleased(key)
    
end

------------------------
--  Static functions


------------------------
--  Member functions
function CHud:getType()
    return self.type
end




print "CHud loaded"