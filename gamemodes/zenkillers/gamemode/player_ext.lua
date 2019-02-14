-- Extentions to base player class

local plymeta = FindMetaTable("Player")

function plymeta:SetTowerLevel(level)
	self:SetNWInt("TowerLevel", level)
end

function plymeta:ReceiveWeapons()
	self:StripWeapons()
	
	local level = self:GetTowerLevel()
	if level == 1 then 
		self:Give("weapon_pistol")
	elseif level == 2 then
		self:Give("weapon_rpg")
	end
	self:Give("weapon_stunstick")
	-- Prevent default loadout
end