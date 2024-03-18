--[Other Variables]
local level1 = 0; -- color1 used for >= this & < level2
local level2 = 60; -- color2 used for >= this & < level3
local level3 = 134; -- color3 used for >= this & < level4
local level4 = 200; -- color4 used for >= this & < level5
local level5 = 225; -- color5 used for >= this & < level6
local level6 = 246; -- color6 used for the few highest items
local level7 = 258; -- color7 used legendaries/specials
--T4: 0, 35, 55, 105, 116, 121
--T8: 0, 60, 134, 200, 225, 246, 258

local colorDefault = "FFFFFF"; --Used for unknown cases
local color1 = "D3D3D3"; -- Gray
local color2 = "FFFFFF"; -- White
local color3 = "03E500"; -- Green
local color4 = "0070DD"; -- Blue
local color5 = "A335EE"; -- Purple
local color6 = "FE8505"; -- Orange
local color7 = "E6CC80"; -- Light Gold

--[Addon Functions]
local function GetItemLevelAndEquip(itemLink)
	local isEquippableItem = false;
	
	if not itemLink or itemLink == nil then 
		return -1; 
	end
	
	local iLevel, _, iType, iSubType, _, iEquipLoc, _ = select(4, GetItemInfo(itemLink));
	if not iLevel or iLevel == nil then
		iLevel = -1;
	end
	if iEquipLoc ~= nil and iEquipLoc ~= "" then
		isEquippableItem = true;
	end
		
	return iLevel, isEquippableItem;
end

local function EventItem(itemLink, tooltipObj)
	local itemLevel, isEquipItem = GetItemLevelAndEquip(itemLink);
			
	if isEquipItem == false then
		if itemLevel and itemLevel ~= nil then
			local color = colorDefault;
			local validItemLevel = 1;
			
			if 		itemLevel >= level7 then color = color7;
			elseif 	itemLevel >= level6 then color = color6;
			elseif 	itemLevel >= level5 then color = color5;
			elseif 	itemLevel >= level4 then color = color4;
			elseif 	itemLevel >= level3 then color = color3;
			elseif 	itemLevel >= level2 then color = color2;
			elseif 	itemLevel >= level1 then color = color1;
			else 	validItemLevel = 0;
			end
			
			if validItemLevel == 1 then
				tooltipObj:AddLine("iLvl: |cff" .. color .. itemLevel .. "|r");
			end
		end
	end
end

--[Event Wrappers]
local function EventSetItem()
	local iName, iLink = GameTooltip:GetItem();
	EventItem(iLink, GameTooltip);
end
local function EventSetItemRef()
	local iName, iLink = ItemRefTooltip:GetItem(); 
	EventItem(iLink, ItemRefTooltip);
end
local function EventSetItemCompare1()
	local iName, iLink = ShoppingTooltip1:GetItem();
	EventItem(iLink, ShoppingTooltip1);
end
local function EventSetItemCompare2()
	local iName, iLink = ShoppingTooltip2:GetItem();
	EventItem(iLink, ShoppingTooltip2);
end

--[Tooltip Hooks]
GameTooltip:HookScript("OnTooltipSetItem", EventSetItem);
ItemRefTooltip:HookScript("OnTooltipSetItem", EventSetItemRef);
ShoppingTooltip1:HookScript("OnTooltipSetItem", EventSetItemCompare1);
ShoppingTooltip2:HookScript("OnTooltipSetItem", EventSetItemCompare2);