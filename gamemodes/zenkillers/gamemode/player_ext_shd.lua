-- Shared extensions to the base player class

local plymeta = FindMetaTable("Player")

function plymeta:GetTowerLevel()
	return self:GetNWInt("TowerLevel", 1)
end