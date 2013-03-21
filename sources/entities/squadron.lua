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
function CSquadron:create(sender, model, lineList)
    -- model : a CFoe to duplicate

    -- lineList : list of num of line filled
    --      = {2,3,4} => 3 filled lines 2..4, the first is still free, ready to welcome a starship for example
    --  lines are 100 pxls high
    
    local Squadron = {}
    setmetatable(Squadron, CSquadron)
    
    local grad = {"regular"}
    local rdc = function () return 60 + math.random(195) end
    for i = 1, 5 do
        grad[i+1] = {rdc(), rdc(), rdc()}
    end
    
    -- Squadron.phase = 'entering'
    Squadron.foes  = {}
    
    -- nbr of foes puttable in a line :
    local dw = model.pxlSize*model.shape.width*2
    local ni = math.floor(0.75*Apps.w/(dw))
    local x,y
    local foe
    
    for i = 1, #lineList do
        for j = 1, ni do
            -- fill the lines outside the screen
            if model.dir == 'L' then
                -- start at the right side
                x = (j-1)*dw + Apps.w
            else
                -- left
                x = (j-1)*dw - Apps.w*0.75
            end
            y = (lineList[i]-1)*100
            foe = model:duplicate()
            foe:setPosition(x,y)
        
            -- adjust the colors
            local ii = ((j-1)*dw + ni*dw*(i-1) ) / (#lineList * Apps.w)
            -- local ii = (  ) / (#lineList * Apps.w)
            foe.color = cd.evalGradientAt(grad, ii)
            
            print(model.dir, i,j, x,y)
            
            
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