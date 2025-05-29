-----------------------------------
-- Area: Port Bastok
--  NPC: Clarion Star
-- Trust NPC
-- !pos 81.478 7.500 -24.169 236
-----------------------------------
local ID = zones[xi.zone.PORT_BASTOK]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    xi.trust.onTradeCipher(player, trade, 437, 457, 458)
end

entity.onTrigger = function(player, npc)
    local trustSandoria = player:getQuestStatus(xi.questLog.SANDORIA, xi.quest.id.sandoria.TRUST_SANDORIA)
    local trustBastok   = player:getQuestStatus(xi.questLog.BASTOK, xi.quest.id.bastok.TRUST_BASTOK)
    local trustWindurst = player:getQuestStatus(xi.questLog.WINDURST, xi.quest.id.windurst.TRUST_WINDURST)

    if
        player:getMainLvl() >= 5 and
        xi.settings.main.ENABLE_TRUST_QUESTS == 1 and
        trustBastok == xi.questStatus.QUEST_AVAILABLE
    then
        if
            trustWindurst == xi.questStatus.QUEST_AVAILABLE and
            trustSandoria == xi.questStatus.QUEST_AVAILABLE
        then
	    player:startEvent(434)
        elseif
            trustWindurst == xi.questStatus.QUEST_COMPLETED or
            trustSandoria == xi.questStatus.QUEST_COMPLETED
        then
            player:startEvent(438)
        end
    elseif player:hasKeyItem(xi.ki.BLUE_INSTITUTE_CARD) then
           player:startEvent(435)
    elseif trustBastok == xi.questStatus.QUEST_COMPLETED then
           player:startEvent(436)
    else
       -- player:startEvent(3505)
    end
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
    if (csid == 434 or csid == 438) and option == 2 then
        player:addQuest(xi.questLog.BASTOK, xi.quest.id.bastok.TRUST_BASTOK)
        npcUtil.giveKeyItem(player, xi.ki.BLUE_INSTITUTE_CARD)
    elseif csid == 437 or csid == 458 then
        local spellID = player:getLocalVar('TradingTrustCipher')
        player:setLocalVar('TradingTrustCipher', 0)
        player:addSpell(spellID, true, true)
        player:messageSpecial(ID.text.YOU_LEARNED_TRUST, 0, spellID)
        player:tradeComplete()
    end
end

return entity
