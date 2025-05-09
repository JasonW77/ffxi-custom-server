-----------------------------------
-- Area: Windurst Walls
--  NPC: Festive Moogle
-- Type: Event NPC
--  !pos -206.927 -0.521 -144.713 239
-----------------------------------
require("scripts/globals/npc_util")
-----------------------------------
local entity = {}

local stock =
{
    16119,  -- Nomad Cap
    15456,  -- Dash sash
    27556,  -- Echad ring
    15840,  -- kupofrieds ring
    26406,  -- Kupo Shield
    11290,  -- Tidal Talisman
    11811,  -- Destrier Beret
    10293,  -- Chocobo Shirt
}

local festiveItemVars =
{
    [1] = "festiveMoogleNomadCap",
    [2] = "festiveMoogleMoogleCap",
    [3] = "festiveMoogleMoogleRod",
    [4] = "festiveMoogleHarpsichord",
    [5] = "festiveMooglestuffedChocobo",
    [6] = "festiveMoogleTidalTalisman",
    [7] = "festiveMoogleDestrierBeret",
    [8] = "festiveMoogleChocoboShirt",
}

local function getFestiveItems(player)
    local festiveItemsAvailable = {}
    for i = 1, #festiveItemVars, 1 do
        if player:getCharVar(festiveItemVars[i]) == 0 then
            table.insert(festiveItemsAvailable, stock[i])
        end
    end

    return festiveItemsAvailable
end

entity.onTrade = function(player, npc, trade)
    --TODO: trade of pells for prize
end

entity.onTrigger = function(player, npc)
    local festiveItems = getFestiveItems(player)
    -- player:delKeyItem(xi.ki.FORGOTTEN_HEXAGUN)
    -- player:unlockJob(xi.job.COR)
    -- player:messageSpecial(talaccaCoveID.text.YOU_CAN_NOW_BECOME_A_CORSAIR)
    if festiveItems[1] then
        player:startEvent(503, unpack(festiveItems))
    else
        player:startEvent(504)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    local festiveItems = getFestiveItems(player)
    if csid == 503 then
        if npcUtil.giveItem(player, festiveItems[option]) then
            for i = 1, #stock do
                if stock[i] == festiveItems[option] then
                    player:setCharVar(festiveItemVars[i], 0)
                    break
                end
            end
        end
    end
end

return entity
