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
    
    Game.bg = Cstars:create()
    Game.bg.dir[1] =  0
    Game.bg.dir[2] = -1
    
    Game.hud = CHud:create(Game)
    
    -- Game.ship = CShip:create() -- created in choose menu
    Game.army = {} -- squadrons collection
    Game.projectils = {}
    
    -- event-driven
    Game.nextEventData = nil
    -- {timeToEvent, entityConcerned, funcToCall?}
    Game.timing = 0
    
    Game.dist = 0
    
    return Game
end


------------------------
--  Callbacks

function CGame:load()
    
end

function CGame:draw()
    -- game's background
    self.bg:draw()

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
    self.timing = self.timing + dt

    self.bg:update(dt) -- , v)
    self.dist = dt * 0.1 + self.dist
    
    self.ship:update(dt)
    for index, squad in ipairs(self.army) do
        squad:update(dt)
    end
    
    -- EDCS : test if an event occurs
    local out = false
    repeat -- to call simultaneous events
        if self.nextEventData then
            if self.nextEventData[1] <= self.timing then
                -- event
                -- call event func :
                print('Calling next event')
                self.nextEventData[3](self.nextEventData[2])
            else
                -- no event
                out = true
            end
        else
            out = true
        end
    until out
    
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
        local f3 = CFoe:create(self, 'n', 'b')
        f3:initialize(75, 'bomb', math.random(250,500))
        local f4 = CFoe:create(self, 'n', 'S')
        f4:initialize(250, 'BFG', math.random(500,1500))
        -- self.army[1] = CSquadron:create(self, f2, {1}, 4)
        -- self.army[2] = CSquadron:create(self, f1, {2,3,4})
        self.army[1] = CSquadron:create(self, f2, {2}, 5)
        self.army[2] = CSquadron:create(self, f4, {0}, 1)
        self.army[3] = CSquadron:create(self, f3, {1}, 2)
        self.army[4] = CSquadron:create(self, f1, {3,0})
        
        self:findNextEvent()
    end
    if key=='j' then
        print('hitting shield')
        local rest = self.ship.shield:hitMe(self.ship.shield.pw * 0.5)
        print("Rest = "..rest)
    end
    if key=='k' then
        print('killing shield')
        local rest = self.ship.shield:hitMe(self.ship.shield.Pw + 50)
        print("Rest = "..rest)
    end
    if key=='c' then
        print('Changing ship')
        Apps.state.state = CShipChoice:create(Apps.state)
    end
    if key=='t' then
        for i = -5.5, 5.5 do
            print(i)
        end
        
    end
    
end

function CGame:mousereleased(x, y, btn)
    
end

function CGame:keyreleased(key)
    self.ship:keyreleased(key)
end

------------------------
--  Static functions


------------------------
--  Member functions
function CGame:getType()
    return self.type
end

function CGame:findNextEvent()  --entity
    --------------------
    --  This will scan the events lists and extract the most recent future event
    -- local ID = entity.uid or entity.ID or -1
    local t = math.huge
    -- self.nextEventData => {timeToEvent, Entity, func}
    local e = nil
    
    -- tmp
    print('Scanning for next event...')
    
    -- scan ship : the ship doesn't have events : too much unpredictable movements
    -- collisions are handled in its update function
    
    -- scan foes in squadrons
    for index, squad in ipairs(self.army) do
        for ind, foe in ipairs(squad.foes) do
            if foe.events then
                for ind, ev in ipairs(foe.events) do
                    if ev[1]<t then
                        t = ev[1]
                        e = ev
                    end
                end
            end
        end
    end
    
    -- scan projectils
    for index, proj in ipairs(self.projectils) do
        if proj.events then
            for ind, ev in ipairs(proj.events) do
                if ev[1]<t then
                    t = ev[1]
                    e = ev
                end
            end
        end
    end
    
    -- tmp
    if e then print("  Next Event at "..e[1]) end
    
    self.nextEventData = e
end



print "CGame loaded"