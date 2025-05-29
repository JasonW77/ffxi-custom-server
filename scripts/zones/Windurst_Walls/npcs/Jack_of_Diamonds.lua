-----------------------------------
-- Area: Windurst Walls
--  NPC: Jack of Diamonds
-- Adventurer's Assistant
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    if
        trade:getItemCount() == 1 and
        trade:hasItemQty(xi.item.ADVENTURER_COUPON, 1)
    then
        player:startEvent(10002, xi.settings.main.GIL_RATE * 50)
	player:addItem(28540);
        player:messageSpecial(ITEM_OBTAINED, 28540); -- Warp Ring
        player:addGil(xi.settings.main.GIL_RATE * 50)
        player:tradeComplete()
    end
end

entity.onTrigger = function(player, npc)
    player:startEvent(10001, 0, 2)
end

return entity
