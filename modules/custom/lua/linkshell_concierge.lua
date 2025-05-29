require('modules/module_utils')

local m = Module:new('linkshell_concierge')

-- Change this to match your actual NPC ID
local NPC_ID = 17736069 -- Replace with the actual NPC ID for "Linkshell Concierge"
local LINKSHELL_NAME = 'Valhalla'

m:addOverride('onTrigger', NPC_ID, function(npc, player)
    if not player:hasLinkpearl(LINKSHELL_NAME) then
        player:addLinkpearl(LINKSHELL_NAME, true)
        player:messageSpecial(ID.text.LINKSHELL_RECEIVED, 0, LINKSHELL_NAME)
    else
        player:PrintToPlayer("You already have the linkshell \"" .. LINKSHELL_NAME .. "\".")
    end
end)

return m
