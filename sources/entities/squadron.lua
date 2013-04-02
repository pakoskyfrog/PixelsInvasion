-- Pakoskyfrog 2013/03/21 06:32:57

-----------------------------------------------------------
----    CSquadron definition
-----------------------------------------------------------

------------------------
-- Description
--[[
    This represents a collection of foes. There can be more than one squadron in one "scene"
    A Squadron is composed of one or more or the same foe, with the same behavior.
    Should not handle starships ?
    Can handle bombardiers and fasts
]]

-----------------------------------------------------------
------------------------
--  Init
CSquadron = {}
CSquadron.__index = CSquadron

------------------------
--  Properties
CSquadron.type = "CSquadron"


------------------------
--  Constructor
function CSquadron:create(sender, model, lineList, Nmax)
    -- model : a CFoe to duplicate

    -- lineList : list of num of line filled
    --      = {2,3,4} => 3 filled lines 2..4, the first is still free, ready to welcome a starship for example
    --  lines are 100 pxls high
    
    local Squadron = {}
    setmetatable(Squadron, CSquadron)
    Squadron.uid = Apps:getNextID()
    
    local grad = {"regular"}
    local rdc = function () return 60 + math.random(195) end
    for i = 1, 5 do
        grad[i+1] = {rdc(), rdc(), rdc()}
    end
    
    -- Squadron.phase = 'entering'
    Squadron.foes  = {}
    
    -- nbr of foes puttable in a line :
    local dw = model.pxlSize*math.max(model.shape.width, 5)*2
    local ni = math.floor(0.75*Apps.w/(dw))
    local NN = Nmax or ni-1
    local dx = 0.75*Apps.w / NN
    local wv = (NN-1)/2 * dx
    local sx = Apps.w/2 - wv
    local x,y
    local foe
    
    for i = 1, #lineList do
        -- for j = -(ni-1)/2 + ((ni-1)%2)/2, (ni-1)/2 + ((ni-1)%2)/2 do
        for j = 1, NN do
            -- fill the lines outside the screen
            if model.dir == 'L' then
                -- start at the right side
                x = sx + (j-1)*dx + Apps.w
            else
                -- left
                x = sx + (j-1)*dx - Apps.w
            end
            y = (lineList[i]-1)*100
            foe = model:duplicate()
            foe:setPosition(x,y)
        
            -- adjust the colors
            local ii = ((j-1)*dx + NN*dx*(i-1) ) / (#lineList * Apps.w)
            -- local ii = (  ) / (#lineList * Apps.w)
            foe.color = cd.evalGradientAt(grad, ii)
            
            print(model.dir, i,j, x,y, foe.shape.size)
            
            -- neighbors
            -- if j > 1 then foe.voisLeft = Squadron.foes[#Squadron.foes] end
            if j > 1 then -- and #Squadron.foes>0
                foe.voisLeft = Squadron.foes[#Squadron.foes]
                Squadron.foes[#Squadron.foes].voisRight = foe
            end
            
            -- Event-driven
            if not foe.events then foe.events = {} end
            if model.dir == 'R' and j==NN then
                foe.events[#foe.events+1] = {Apps.state.timing+(Apps.w-foe.pos.x)/foe.speed[1], foe, foe.collide}
            end
            if model.dir == 'L' and j==1 then
                foe.events[#foe.events+1] = {Apps.state.timing+(-foe.pos.x)/foe.speed[1], foe, foe.collide}
            end

            -- table.sort(foe.event, function()  end)
            
            Squadron.foes[#Squadron.foes+1] = foe
        end
        
    end
    
    
    return Squadron
end


------------------------
--  Callbacks

function CSquadron:load()
    
end

function CSquadron:draw()
    for index, foe in ipairs(self.foes) do
        foe:draw()
    end
    
end

function CSquadron:update(dt)
    for index, foe in ipairs(self.foes) do
        foe:update(dt)
    end
end

function CSquadron:mousepressed(x, y, btn)
    
end

function CSquadron:keypressed(key)
    
end

function CSquadron:mousereleased(x, y, btn)
    
end

function CSquadron:keyreleased(key)
    
end

------------------------
--  Static functions


------------------------
--  Member functions
function CSquadron:getType()
    return self.type
end




print "CSquadron loaded"