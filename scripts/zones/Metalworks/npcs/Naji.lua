-----------------------------------
-- Area: Metalworks
--  NPC: Naji
-- !pos 64 -14 -4 237
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
	local trustSandoria = player:getQuestStatus(xi.questLog.SANDORIA, xi.quest.id.sandoria.TRUST_SANDORIA)
  	local trustBastok   = player:getQuestStatus(xi.questLog.BASTOK, xi.quest.id.bastok.TRUST_BASTOK)
 	local trustWindurst = player:getQuestStatus(xi.questLog.WINDURST, xi.quest.id.windurst.TRUST_WINDURST)
  	local bastokFirstTrust = player:getCharVar('BastokFirstTrust')
  	local najiTrustChatFlag = player:getLocalVar('NajiTrustChatFlag')
	local rank3 = player:getRank(player:getNation()) >= 3 and 1 or 0

	if
	     trustWindurst == xi.questStatus.QUEST_ACCEPTED and
             (trustSandoria == xi.questStatus.QUEST_COMPLETED or trustBastok == xi.questStatus.QUEST_COMPLETED)
	then
	     player:startEvent(984, 0, 0, 0, trustMemoryNaji(player), 0, 0, 0, rank3)
	elseif 
	     trustBastok == xi.questStatus.QUEST_ACCEPTED and
	     bastokFirstTrust == 0 
	then 
	     player:startEvent(980, 0, 0, 0, trustMemoryNaji(player), 0, 0, 0, rank3)
	elseif 
	     trustBastok == xi.questStatus.QUEST_ACCEPTED and
	     bastokFirstTrust == 1 and
	     najiTrustChatFlag == 0 
	then 
	     player:startEvent(981)
	     player:setLocalVar('NajiTrustChatFlag', 1)
	elseif 
	     trustBastok == xi.questStatus.QUEST_ACCEPTED and
	     bastokFirstTrust == 2 
	then
	     player:startEvent(982)
	elseif
	     trustBastok == xi.questStatus.QUEST_COMPLETED and
             not player:hasSpell(xi.magic.spell.AYAME) and
             najiTrustChatFlag == 0
	then
             player:startEvent(983)
             player:setLocalVar('NajiTrustChatFlag', 1)
	else
             player:startEvent(984)
	end	
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
    --TRUST
    if csid == 980 then
        player:addSpell(xi.magic.spell.NAJI, true, true)
        player:messageSpecial(ID.text.YOU_LEARNED_TRUST, 0, xi.magic.spell.NAJI)
        player:setCharVar('BastokFirstTrust', 1)
    elseif csid == 982 then
        player:delKeyItem(xi.ki.BLUE_INSTITUTE_CARD)
        player:messageSpecial(ID.text.KEYITEM_LOST, xi.ki.BLUE_INSTITUTE_CARD)
        npcUtil.completeQuest(player, xi.questLog.BASTOK, xi.quest.id.bastok.TRUST_BASTOK, {
            ki = xi.ki.BASTOK_TRUST_PERMIT,
            title = xi.title.THE_TRUSTWORTHY,
            var = 'BastokFirstTrust' })
        player:messageSpecial(ID.text.CALL_MULTIPLE_ALTER_EGO)
    elseif csid == 984 then
        player:addSpell(xi.magic.spell.NAJI, true, true)
        player:messageSpecial(ID.text.YOU_LEARNED_TRUST, 0, xi.magic.spell.NAJI)
        player:delKeyItem(xi.ki.BLUE_INSTITUTE_CARD)
        player:messageSpecial(ID.text.KEYITEM_LOST, xi.ki.BLUE_INSTITUTE_CARD)
        npcUtil.completeQuest(player, xi.questLog.BASTOK, xi.quest.id.bastok.TRUST_BASTOK, {
            ki = xi.ki.BASTOK_TRUST_PERMIT })
    end
end

return entity
