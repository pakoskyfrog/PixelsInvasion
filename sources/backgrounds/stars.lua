-- Pakoskyfrog 2013

-- mode : N/S/E/W/Tunnel (def : E)

------------------------
--  Init
Cstars = {}
Cstars.__index = Cstars

------------------------
--  Properties
Cstars.N = 500
Cstars.dir = {1, 0} -- vector of direction of the virtual spaceship going through the starfield

------------------------
--  Constructor

function Cstars:create()
    local stars = {}
    setmetatable(stars, self)
    
    stars.h = love.graphics.getHeight()
    stars.w = love.graphics.getWidth()
    
    stars.field = {}
    
    for i = 1, Cstars.N do
        stars.field[#stars.field+1] = Cstars.starFactory(stars, "creation")
    end
    
    return stars
end

------------------------
--  Callbacks

function Cstars:update(dt, vec)
    if vec ~= nil then
        self.dir[1] = vec[1]
        self.dir[2] = vec[2]
    end 
    for i = #self.field, 1, -1 do
        local star = self.field[i]
        -- going forward
        star.x = star.x - self.dir[1] * star.speed * dt
        star.y = star.y - self.dir[2] * star.speed * dt
        -- out ? => new !
        if star.y < 0 or star.y > self.h or star.x < 0 or star.x > self.w then
            table.remove(self.field, i)
            self.field[#self.field+1] = Cstars:starFactory(self.mode)
        end
    end
end

function Cstars:draw()
    love.graphics.setPointSize(3)

    for i, star in ipairs(self.field) do
        local x = star.x
        local y = star.y
        local c = star.speed
        love.graphics.setColor({c*0.8,c,c}) -- slightly cyan
        love.graphics.point(x, y)
    end
end

------------------------
--  Member functions

function Cstars:starFactory(mode)
    local star = {}
    local h = love.graphics.getHeight()
    local w = love.graphics.getWidth()
    
        star.x = 0
        star.y = 0
    
    if mode == "creation" then
        star.x = math.random(w)
        star.y = math.random(h)
    elseif mode == "Tunnel" then
        -- 0,0 is fine
        -- direction
        -- TODO, update with polar v
    else
        local a = self.dir[2]/self.dir[1]
        local A1, A2
        local A = w * h
        if a >= h/w then
            A1 = h*h/a*0.5
            
        elseif a >= 0 then
            A2 = w*w*a*0.5
            A1 = A-A2
            
        elseif a >= -h/w then
            A2 = -w*w*a*0.5
            A1 = A-A2
        else
            A1 = -h*h/a*0.5
            
        end
        local pw1 = A1/A
        
        local first = math.random()<pw1
        local x = math.random(w)
        local y = math.random(h)
        
        if self.dir[1] < 0 and self.dir[2] > 0 then -- NE
            if first then
                star.y = y
            else
                star.x = x
                star.y = h
            end
        elseif self.dir[1] > 0 and self.dir[2] > 0 then -- NW
            if first then
                star.x = w
                star.y = y
            else
                star.x = x
                star.y = h
            end
        elseif self.dir[1] > 0 and self.dir[2] < 0 then -- SW
            if first then
                star.x = w
                star.y = y
            else
                star.x = x
            end
        elseif self.dir[1] < 0 and self.dir[2] < 0 then -- SE
            if first then
                star.y = y
            else
                star.x = x
            end
        elseif self.dir[2] == 0 then -- horizontal
            if self.dir[1] > 0 then
                star.x = w
            end
            star.y = math.random(h)
        elseif self.dir[1] == 0 then -- vertical
            star.x = x
            if self.dir[2] > 0 then star.y = h else star.y = 0 end
        end
    end
    star.speed = math.random(255) -- <=> distance / paralaxe
    
    return star
end


print "Cstars loaded"