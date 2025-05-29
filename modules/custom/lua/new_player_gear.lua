require('modules/module_utils')

local m = Module:new('new_player_gear')

-- Configuration Table: [TutorialProgress] = { items = {item IDs}, message = "dialogue text" }
local gearRewards = {
    [2] = {
        items = {
            xi.item.DESTRIER_BERET,
        },
        message = "This hat will help keep the sun outta your eyes."
    },
    [3] = {
        items = {
            xi.item.KUPO_SHIELD,
        },
        message = "This shield will both aid you in your crafting, and help protect you in battle."
    },
    [4] = {
        items = {
            xi.item.CHOCOBO_SHIRT,
        },
        message = "This armor should help you survive out there."
    },
    [5] = {
        items = {
            xi.item.TALARIA,
        },
        message = "Here’s a pair of comfortable shoes to go with that stylish shirt."
    },
    [6] = {
        items = {
            xi.item.INVISIBLE_RING,
        },
        message = "You no doubt can now see the importance of avoiding enemies, here's a ring that will help you do just that."
    },
    [7] = {
        items = {
            xi.item.WARP_RING,
        },
        message = "You’ve earned this accessory. Use it well."
    }
}

-- Utility: Give items the player doesn't already have
local function giveTutorialGear(player, stage)
    local reward = gearRewards[stage]
    if not reward then
        return
    end

    local missingItems = {}
    for _, itemID in ipairs(reward.items) do
        -- Check all storage locations for the item
        if not player:hasItem(itemID, false) then
            table.insert(missingItems, itemID)
        end
    end

    -- Only check for the first item
    if not player:hasItem(xi.item.DESTRIER_BERET, false) then
            player:PrintToPlayer(reward.message or "I see you are missing the hat i gave you!", 0, npc:getPacketName())
        if npcUtil.giveItem(player, reward.items) then
            player:PrintToPlayer(reward.message or "You received some gear!", 0, npc:getPacketName())
        else
            player:PrintToPlayer("Your inventory is full! Make room to receive your gear.", 0, npc:getPacketName())
        end
    else
        player:PrintToPlayer("You already have the gear for this stage.", 0, npc:getPacketName())
    end
end

-- Hook into tutorial progression
m:addOverride('xi.tutorial.onEventFinish', function(player, csid, option, npc_event_offset, nation_offset)
    super(player, csid, option, npc_event_offset, nation_offset)

    local stage = player:getCharVar('TutorialProgress')
    giveTutorialGear(player, stage)
end)

return m
