-- Pakoskyfrog 2013/03/20 20:10:01

-----------------------------------------------------------
----    CMainMenu definition
-----------------------------------------------------------

------------------------
-- Description
--[[
    Main menu of the game, the buttons are activated by a mini game
    where you are a little invader and you launch bombs on them.
]]

-----------------------------------------------------------
------------------------
--  Init
CMainMenu = {}
CMainMenu.__index = CMainMenu

------------------------
--  Properties
CMainMenu.type = "CMainMenu"


------------------------
--  Constructor
function CMainMenu:create()
    local MainMenu = {}
    setmetatable(MainMenu, CMainMenu)
    
    
    
    return MainMenu
end


------------------------
--  Callbacks

function CMainMenu:load()
    
end

function CMainMenu:draw()
    -- tmp
    love.graphics.setFont(Apps.fonts.default)
    love.graphics.setColor(255,255,255)
    love.graphics.print('"g" to launch game', 25, 25)
end

function CMainMenu:update(dt)
    
end

function CMainMenu:mousepressed(x, y, btn)
    
end

function CMainMenu:keypressed(key)
    if key == 'g' then
        Actions:launchGame()
    end
    
end

function CMainMenu:mousereleased(x, y, btn)
    
end

function CMainMenu:keyreleased(key)
    
end

------------------------
--  Static functions


------------------------
--  Member functions
function CMainMenu:getType()
    return self.type
end




print "CMainMenu loaded"