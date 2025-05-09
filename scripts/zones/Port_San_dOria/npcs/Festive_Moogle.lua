-----------------------------------
-- Area: Port San d'Oria
--  NPC: Festive Moogle
-- Type: Event NPC
--  !pos 70.641 -16.000 -118.589 232
-----------------------------------
-- ---@type TNpcEntity
-- local entity = {}

-- entity.onTrade = function(player, npc, trade)
--     xi.festiveMoogle.onTrade(player, npc, trade)
-- end

-- entity.onTrigger = function(player, npc)
--     xi.festiveMoogle.onTrigger(player, npc)
-- end

-- entity.onEventUpdate = function(player, csid, option, npc)
--     xi.festiveMoogle.onEventUpdate(player, csid, option, npc)
-- end

-- entity.onEventFinish = function(player, csid, option, npc)
--     xi.festiveMoogle.onEventFinish(player, csid, option, npc)
-- end

-- return entity

-----------------------------------
-- Area: Port San d'Oria
--  NPC: Festive Moogle
-- Type: Event NPC
--  !pos 70.641 -16.000 -118.589 232
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
        if player:getCharVar(festiveItemVars[i]) == 0 then --change this to 0
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
    if festiveItems[1] then
        player:startEvent(773, unpack(festiveItems))
    else
        player:startEvent(774)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    local festiveItems = getFestiveItems(player)
    if csid == 773 then
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
