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
CShipChoice.title = "Choose your new ship"

------------------------
--  Constructor
function CShipChoice:create(sender)
    local ShipChoice = {}
    setmetatable(ShipChoice, CShipChoice)
    ShipChoice.parent = sender
    
    local sx = Apps.w * 0.07
    local sy = sx
    local sw = Apps.w-sx*2
    local sh = Apps.h-sy*2
    
    ShipChoice.ships = {}
    ShipChoice.ships[1] = CShip:create(25)
    ShipChoice.ships[2] = CShip:create(50)
    ShipChoice.ships[3] = CShip:create(75)
    ShipChoice.ships[1].name = CShipChoice.generateName()
    ShipChoice.ships[2].name = CShipChoice.generateName()
    ShipChoice.ships[3].name = CShipChoice.generateName()
    
    ShipChoice.buttons = {}
    
    ShipChoice.frames = {}
    ShipChoice.frames[1] = {{0,0,0,200}, {'fill', sx, sy, sw, sh}}
    ShipChoice.frames[2] = {cd.getNamedColor('darkCyan'), {'line', sx, sy, sw, sh}}
    
    local d  = sw/6
    local dd = d*0.9
    local cols = {
        cd.getNamedColor('azure'),
        cd.getNamedColor('lime'),
        cd.getNamedColor('orange'),
    }
    for i = -1, 1 do
        local x = 2*d*i + 3*d + sx
        local y = sy+sh-d
        local btn = CButton:create(ShipChoice, 'VOID'..i, x-dd, y-dd)
        btn.width  = 2*dd
        btn.height = 2*dd
        -- btn.onClick = function(self) print(self.caption) end
        btn.ship = ShipChoice.ships[2+i]
        ShipChoice.ships[2+i].pos.x = x
        ShipChoice.ships[2+i].pos.y = y
        ShipChoice.frames[4+i]  = {cols[2+i], {'line', x-dd, y-dd, 2*dd, 2*dd}}
        ShipChoice.buttons[2+i] = btn
    end
    
    return ShipChoice
end


------------------------
--  Callbacks

function CShipChoice:load()
    
end

function CShipChoice:draw()
    -- frames and rectangles
    love.graphics.setLineWidth(4)
    for index, frame in ipairs(self.frames) do
        love.graphics.setColor(frame[1])
        love.graphics.rectangle(unpack(frame[2]))
    end
    
    -- title
    do
        love.graphics.setColor(200,255,255)
        local tw = Apps.fonts.big:getWidth(self.title)
        love.graphics.setFont(Apps.fonts.big)
        love.graphics.print(self.title, (Apps.w-tw)*0.5, 100)
    end
    
    -- ships
    for index, sh in ipairs(self.ships) do
        sh:draw()
    end
    
    -- infos
    local cls = {'Fighter','Frigate','Cruiser'}
    for index, btn in ipairs(self.buttons) do
        if btn.hover then
            local ypos = 175
            local xpos = 150
            love.graphics.setColor(200,200,100)
            love.graphics.setFont(Apps.fonts.small)
            
            love.graphics.print(tostring("Class : "..(cls[index])), xpos, ypos)
            love.graphics.print(tostring("Name   : "..btn.ship.name), xpos, ypos+20)
            -- love.graphics.print(tostring("Name : XFLR6"), xpos, ypos+20)
            
            xpos = xpos + 200
            love.graphics.print(tostring("Armor : "..btn.ship.Hp), xpos, ypos)
            love.graphics.print(tostring("Shield : "..btn.ship.shield.Pw..' +'..tostring(btn.ship.shield.regen*btn.ship.shield.Pw)..'/s'), xpos, ypos+20)
            
            xpos = xpos + 300
            love.graphics.print(tostring("Speed : "..btn.ship.speed[1]..' km/s'), xpos, ypos)
        end
    end
    
end

function CShipChoice:update(dt)
    -- buttons
    for index, btn in ipairs(self.buttons) do
        btn:update(dt)
    end
    
end

function CShipChoice:mousepressed(x, y, b)
    -- buttons
    for index, btn in ipairs(self.buttons) do
        if btn:mousepressed(x, y, b) then
            -- assign ship
            self.parent.ship = btn.ship
            self.parent.ship:centerMe()
            Actions:nullUnderState()
        end
    end
    
end

function CShipChoice:keypressed(key)
    local btn
    if key == '1' or key == 'kp1' then
        btn = self.buttons[1]
    elseif key == '2' or key == 'kp2' then
        btn = self.buttons[2]
    elseif key == '3' or key == 'kp3' then
        btn = self.buttons[3]
    end
    if btn then
        self.parent.ship = btn.ship
        self.parent.ship:centerMe()
        Actions:nullUnderState()
    end
end

function CShipChoice:mousereleased(x, y, btn)
    
end

function CShipChoice:keyreleased(key)
    
end

------------------------
--  Static functions
function CShipChoice.generateName()
    --------------------
    --  Generate a simple random name
    local letterRange = {string.byte('A'), string.byte('Z')}
    local digitRange  = {string.byte('0'), string.byte('9')}
    local dig = {}
    local r = math.random(2,3)
    for i = 1, r do
        dig[#dig + 1] = math.random(unpack(letterRange))
    end
    for i = r+1, 5 do
        dig[#dig + 1] = math.random(unpack(digitRange))
    end
    return string.char(unpack(dig))
end

------------------------
--  Sets / Gets
function CShipChoice:getType() return self.type end


------------------------
--  Member functions





print "CShipChoice loaded"