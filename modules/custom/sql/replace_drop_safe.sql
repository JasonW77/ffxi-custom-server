DROP PROCEDURE IF EXISTS replace_drop_safe;
DELIMITER $$

CREATE PROCEDURE replace_drop_safe(
    IN zoneName TINYTEXT,
    IN mobName TINYTEXT,
    IN oldDropName TINYTEXT,
    IN newDropName TINYTEXT
)
proc_block: BEGIN
    DECLARE zoneId INT DEFAULT NULL;
    DECLARE dropListId INT DEFAULT NULL;
    DECLARE oldDropId INT DEFAULT NULL;
    DECLARE newDropId INT DEFAULT NULL;
    DECLARE msg TEXT;

    -- Lookups
    SELECT zoneid INTO zoneId FROM zone_settings WHERE name = zoneName;
    SELECT itemid INTO oldDropId FROM item_basic WHERE name = oldDropName;
    SELECT itemid INTO newDropId FROM item_basic WHERE name = newDropName;

    IF zoneId IS NOT NULL THEN
        SELECT dropid INTO dropListId FROM mob_groups WHERE zoneid = zoneId AND name = mobName;
    END IF;

    -- Error handling and logging
    IF zoneId IS NULL THEN
        SET msg = CONCAT('Zone not found: ', zoneName);
        INSERT INTO replace_drop_log (zone_name, mob_name, old_item, new_item, status, message)
        VALUES (zoneName, mobName, oldDropName, newDropName, 'FAILED', msg);
        LEAVE proc_block;
    END IF;

    IF dropListId IS NULL THEN
        SET msg = CONCAT('Mob group not found: ', mobName, ' in zone ', zoneName);
        INSERT INTO replace_drop_log (zone_name, mob_name, old_item, new_item, status, message)
        VALUES (zoneName, mobName, oldDropName, newDropName, 'FAILED', msg);
        LEAVE proc_block;
    END IF;

    IF oldDropId IS NULL THEN
        SET msg = CONCAT('Old item not found: ', oldDropName);
        INSERT INTO replace_drop_log (zone_name, mob_name, old_item, new_item, status, message)
        VALUES (zoneName, mobName, oldDropName, newDropName, 'FAILED', msg);
        LEAVE proc_block;
    END IF;

    IF newDropId IS NULL THEN
        SET msg = CONCAT('New item not found: ', newDropName);
        INSERT INTO replace_drop_log (zone_name, mob_name, old_item, new_item, status, message)
        VALUES (zoneName, mobName, oldDropName, newDropName, 'FAILED', msg);
        LEAVE proc_block;
    END IF;

    -- Perform the drop replacement
    UPDATE mob_droplist
    SET itemId = newDropId
    WHERE dropId = dropListId AND itemId = oldDropId;

    -- Log the success
    SET msg = CONCAT('Successfully replaced ', oldDropName, ' with ', newDropName);
    INSERT INTO replace_drop_log (zone_name, mob_name, old_item, new_item, status, message)
    VALUES (zoneName, mobName, oldDropName, newDropName, 'SUCCESS', msg);

END proc_block$$
DELIMITER ;
