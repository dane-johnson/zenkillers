-- Shared extensions to the base player class

local plymeta = FindMetaTable("Player")

function plymeta:GetTowerLevel()
   return self:GetNWInt("TowerLevel", 1)
end

function plymeta:GetTowerNames()
   -- Thanks for the decent string lib!
   return string.Split(self:GetNWString("TowerNames"), ":")
end
