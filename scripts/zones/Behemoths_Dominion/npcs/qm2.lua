-----------------------------------
-- Area: Behemoth's Dominion
--  NPC: qm2 (???)
-- Spawns Behemoth or King Behemoth
-- !pos -267 -19 74 127
-----------------------------------
local ID = zones[xi.zone.BEHEMOTHS_DOMINION]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onSpawn = function(npc)
end

entity.onTrade = function(player, npc, trade)
    if
        not GetMobByID(ID.mob.BEHEMOTH):isSpawned() and
        not GetMobByID(ID.mob.KING_BEHEMOTH):isSpawned()
    then
        if
            npcUtil.tradeHasExactly(trade, xi.item.BEASTLY_SHANK) and
            npcUtil.popFromQM(player, npc, ID.mob.BEHEMOTH)
        then
            player:confirmTrade()
        elseif
            npcUtil.tradeHasExactly(trade, xi.item.SAVORY_SHANK) and
            npcUtil.popFromQM(player, npc, ID.mob.KING_BEHEMOTH)
        then
            player:confirmTrade()
        end
    end
end

entity.onTrigger = function(player, npc)
    player:messageSpecial(ID.text.IRREPRESSIBLE_MIGHT)
    if
        not GetMobByID(ID.mob.BEHEMOTH):isSpawned() and
        not GetMobByID(ID.mob.KING_BEHEMOTH):isSpawned()
    then
        -- Directly spawn Behemoth or King Behemoth without item check
        if math.random() < 0.9 then
            npcUtil.popFromQM(player, npc, ID.mob.BEHEMOTH)
        else
            npcUtil.popFromQM(player, npc, ID.mob.KING_BEHEMOTH)
        end
    end
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
