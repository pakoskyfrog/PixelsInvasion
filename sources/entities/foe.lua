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
        return math.random(50,100)
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
    Foe.uid = Apps:getNextID()
    Foe.pos = {x=0, y=0}
    Foe.dir = dir or (math.random()<0.5 and 'L' or 'R')
    
    if shape then
        Foe.shape = shape:duplicate()
        Foe.size  = shape.size
    else
        Foe.size = sizeToN(size)
        Foe:generateShape()
    end
    
    Foe.speed = {(100-0.5*Foe.size)*(Foe.dir=='L' and -1 or 1), 7}  -- pxls/sec
    
    Foe.events = {} -- list of events attached to the foe
    
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
    -- This isn't part of the EDCS, just a placeholder
    
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
    
    -- if self:testWall() then
        -- self.speed[1] = -self.speed[1]
    -- end
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
    
    Foe.events = {}
    
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

function CFoe:collide(modeQ)
    --------------------
    --  This function is call by the event-driven collision system
    --  It handles changing directions of the foe against the wall or a neighbor
    
    modeQ = modeQ or true
    
    -- TODO : Consider round shape if shield is on
    -- TODO : rework / simplify / subfunctionalize
    
    -- erase old event :
    
    
    --  1/ old school : everybody change direction
    if not modeQ then
        if self.speed[1] > 0 then
            -- right bump
            local vois = self
            self.events = {} -- TMP : need to be able to store more than one event
            repeat
                vois.speed[1] = -vois.speed[1]
                if vois.voisLeft == nil then
                    --  1/b/ actualize events
                    -- vois.events[#vois.events+1]
                    vois.events = {}
                    vois.events[1] = {Apps.state.timing+(-vois.pos.x)/vois.speed[1], vois, vois.collide}
                end
                vois = vois.voisLeft
            until vois == nil
        else
            -- left bump
            local vois = self
            self.events = {} -- TMP : need to be able to store more than one event
            repeat
                vois.speed[1] = -vois.speed[1]
                if vois.voisRight == nil then
                    --  1/b/ actualize events
                    -- vois.events[#vois.events+1]
                    vois.events = {}
                    vois.events[1] = {Apps.state.timing+(Apps.w-vois.pos.x)/vois.speed[1], vois, vois.collide}
                end
                vois = vois.voisRight
            until vois == nil
        end
        return
    end
    
    
    --  2/ new wave : change sens only when dist <= margin
    --  TODO : modif pos.x with width and shield
    if self.speed[1] > 0 then
        -- right bump
        self.events = {} -- TMP : need to be able to store more than one event
        self.speed[1] = -self.speed[1]
        local vR = self.voisRight   -- hit now
        if vR then
            -- a foe
            vR.speed[1] = -vR.speed[1]
            local vRR = vR.voisRight
            local dR
            local sR = vR.speed[1]
            if vRR then
                -- a foe
                dR = vRR.pos.x - vR.pos.x
                sR = sR - vRR.speed[1]
            else
                -- the wall
                dR = Apps.w - vR.pos.x
            end
            -- make event with vR
            local tR = dR/sR
            if sR > 0 then
                -- vR.events[#vR.events+1]
                vR.events = {}
                vR.events[1] = {Apps.state.timing+tR, vR, vR.collide}
            end
        else
            -- the wall : nothing to do, it won't move
        end
        local vL = self.voisLeft    -- future hit
        local dL
        local sL = self.speed[1]
        if vL then
            -- a foe
            dL = vL.pos.x - self.pos.x
            sL = sL - vL.speed[1]
        else
            -- the wall
            dL = 0 - self.pos.x
        end
        -- make event with vL
        local tL = dL/sL -- both are negative so tL > 0
        if sL < 0 then
            -- vL.events[#vR.events+1]
            self.events = {}
            self.events[1] = {Apps.state.timing+tL, self, self.collide}
        end
    else
        -- left bump
        self.events = {} -- TMP : need to be able to store more than one event
        self.speed[1] = -self.speed[1]
        local vL = self.voisLeft   -- hit now
        if vL then
            -- a foe
            vL.speed[1] = -vL.speed[1]
            local vLL = vL.voisLeft
            local dL
            local sL = vL.speed[1]
            if vLL then
                -- a foe
                dL = vLL.pos.x - vL.pos.x
                sL = sL - vLL.speed[1]
            else
                -- the wall
                dL = 0 - vL.pos.x
            end
            -- make event with vR
            local tL = dL/sL -- both are negative so tL > 0
            if sL < 0 then
                -- vR.events[#vR.events+1]
                vL.events = {}
                vL.events[1] = {Apps.state.timing+tL, vL, vL.collide}
            end
        else
            -- the wall : nothing to do, it won't move
        end
        local vR = self.voisRight   -- future hit
        local dR
        local sR = self.speed[1]
        if vR then
            -- a foe
            dR = vR.pos.x - self.pos.x
            sR = sR - vR.speed[1]
        else
            -- the wall
            dR = Apps.w - self.pos.x
        end
        -- make event with vL
        local tR = dR/sR
        if sR > 0 then
            -- vL.events[#vR.events+1]
            self.events = {}
            self.events[1] = {Apps.state.timing+tR, self, self.collide}
        end
    end
    
    Apps.state:findNextEvent()
end



print "CFoe loaded"