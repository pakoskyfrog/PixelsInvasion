-- Pakoskyfrog 2013

-----------------------------------------------------------
----    Action functions
-----------------------------------------------------------

------------------------
-- Description
--[[
    Centralisation of actions, call by buttons mostly.
]]

-----------------------------------------------------------
------------------------
--  Init
Actions = {}

function Actions.activateMainMenu()
    --------------------
    --  assigne primary state to the mainmenu
    Apps.state = CMainMenu:create()
    Apps.state:load()
end

function Actions.wip()
    --------------------
    --  Dummy function that indicates it's a work in progress
    Apps:addMsg("WIP : this is not implemented yet.")
end

function Actions:goPage1()
    --------------------
    --  Makes the menu goes back to the first page
    -- self is the button clicked
    self.parent:setCurrentPage(1)
end

function Actions:nextOption()
    --------------------
    --  Will change button status to the next option
    self.optSelected = math.mod(self.optSelected, #self.options) + 1
    self:setCaption(self.prefix .. self.options[self.optSelected])
end

function Actions:launchGame()
    --------------------
    --  Will extract options and launch the game accordingly
    
    -- option transfert TODO
    local options = {}
    
    Apps.state = CGame:create(options)
end

function Actions:restartGame()
    --------------------
    --  re-launch a game with previous options
    
    Apps.state = CGame:create(Apps.state.options)
end


function Actions:nullUnderState()
    --------------------
    --  set the underState to nil
    Apps.state.state = nil
end
