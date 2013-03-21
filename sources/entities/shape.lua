-- Pakoskyfrog 2013/03/21 04:58:13

-----------------------------------------------------------
----    CShape definition
-----------------------------------------------------------

------------------------
-- Description
--[[
    This is the entity describing the shape of all ships.
    Generators are in an other file.
]]

-----------------------------------------------------------
------------------------
--  Init
CShape = {}
CShape.__index = CShape

------------------------
--  Properties
CShape.type = "CShape"
CShape.generated = false

------------------------
--  Constructor
function CShape:create(sender, kind, N)
    local Shape = {}
    setmetatable(Shape, CShape)
    
    kind = kind or 'LR' -- LR / UB / Diag / ADiag
    Shape.kind = kind
    Shape.size = N or 7
    Shape.parent = sender
    
    Shape:generate()
    
    return Shape
end


------------------------
--  Callbacks

function CShape:load()
    
end

function CShape:draw()
    local cx = self.parent.pos.x
    local cy = self.parent.pos.y
    local dp = self.parent.pxlSize
    local sx = cx - dp*(self.width /2)
    local sy = cy - dp*(self.height/2)
    
    love.graphics.setColor(255,255,255) -- tmp
    -- love.graphics.setColor(self.parent.color)
    
    for i = 1, self.height do
        for j = 1, self.width do
            if self.grid[i][j] then
                local xx = sx + (j-1)*dp
                local yy = sy + (i-1)*dp
                love.graphics.rectangle('fill', xx, yy, dp, dp)
            end
        end
    end
    
end

function CShape:update(dt)
    
end

function CShape:mousepressed(x, y, btn)
    
end

function CShape:keypressed(key)
    
end

function CShape:mousereleased(x, y, btn)
    
end

function CShape:keyreleased(key)
    
end

------------------------
--  Static functions


------------------------
--  Member functions
function CShape:getType()
    return self.type
end

function CShape:generate()
    --------------------
    --  This will call the right generator
    if self.kind == 'LR' then
        -- foes and your ship
        self.grid,self.width,self.height = self:genSymLR(self.size)
        
    elseif self.kind == 'UB' then
        -- LR flyers
        self.grid,self.width,self.height = self:genSymUB(self.size)
        
    elseif self.kind == 'Diag' then
        -- bombardiers
        self.grid,self.width,self.height = self:genSymDiag(self.size)
        
    elseif self.kind == 'Antidiag' then
        -- bombardiers
        self.grid,self.width,self.height = self:genSymAntiDiag(self.size)
        
    end
    self.generated = true
end

function CShape:duplicate()
    --------------------
    --  This will return a full copy of the shape
    local gr = {}
    for i = 1, #self.grid do
        gr[i] = {}
        for j = 1, #self.grid[1] do
            gr[i][j] = self.grid[i][j]
        end
    end
    
    local Shape = {}
    setmetatable(Shape, CShape)
    
    Shape.kind   = self.kind
    Shape.size   = self.size
    Shape.parent = self.parent
    Shape.width  = self.width
    Shape.height = self.height
    
    Shape.grid = gr
    
    return Shape
end


function CShape:detectDirection()
    --------------------
    --  supposidly detecting the orientation of the shape so the point is the front
    
    -- TODO, useful ?
end



print "CShape loaded"