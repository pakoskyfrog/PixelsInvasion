------------------------
--  This contains specific shapes generators
-- All generators compute 'connected' shapes, all pixel have at least one neighbor
-- Generators are based on a drunkard walk method

require 'sources/entities/shape'

local function formatShape(s, mx,my, Mx,My)
    --------------------
    --  This will realign the shape so it is in 1..xmax / 1..ymax range
    
    local array = {}
    for i = my, My do
        array[i-my+1] = {}
        for j = mx, Mx do
            array[i-my+1][j-mx+1] = s[i][j]
        end
    end
    return array
end


function CShape:genSymLR(N)
    --------------------
    --  This will generate a shape with N point dispatch in a Left/Right symetry
    N = N or 7
    
    local mx,my, Mx,My = 9999,9999, -9999,-9999
    
    local n = 0
    local shape = {}
    
    local tmpRev = {}
    local function add(x,y)
        local ind = x..':'..y
        local sym = tostring(-x)..':'..y
        tmpRev[ind] = true
        tmpRev[sym] = true
        if not shape[y] then shape[y] = {} end
        shape[y][ x] = true
        shape[y][-x] = true
        n = n + 1
        if x ~= 0 then n = n + 1 end
        mx = math.min(mx,  x)
        mx = math.min(mx, -x)
        my = math.min(my, y)
        Mx = math.max(Mx,  x)
        Mx = math.max(Mx, -x)
        My = math.max(My, y)
    end
    local function test(x,y)
        local ind = x..':'..y
        return tmpRev[ind]
    end
    -- add the start point at 0,0
    -- local shape[0] = {}
    -- local shape[0][0] = true
    local x, y = 0, 0
    add(x, y)
    
    -- walking
    repeat
        -- choose direction
        local rn = math.random()
        if rn<0.25 then
            x = x - 1
        elseif rn<0.5 then
            x = x + 1
        elseif rn<0.75 then
            y = y - 1
        else
            y = y + 1
        end
        
        -- new cell ?
        if not test(x,y) then
            add(x,y)
        end
        
    until n >= N
    
    local w, h = Mx-mx+1, My-my+1
    return formatShape(shape, mx,my, Mx,My), w, h
end

function CShape:genSymUB(N)
    --------------------
    --  This will generate a shape with N point dispatch in a Up/Bottom symetry
    N = N or 7
    
    -- just transpose LR
end

function CShape:genSymDiag(N)
    --------------------
    --  This will generate a shape with N point dispatch in a diagonal symetry
    N = N or 7
    
end


function CShape:genSymAntiDiag(N)
    --------------------
    --  This will generate a shape with N point dispatch in an "anti"diagonal symetry
    N = N or 7
    
    -- just transpose normal diag
end

