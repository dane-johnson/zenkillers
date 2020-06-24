-- Extentions to base player class

local plymeta = FindMetaTable("Player")

function plymeta:SetTowerLevel(level)
   self:SetNWInt("TowerLevel", level)
end

function plymeta:SetTowerNames(towernames)
   self:SetNWString("TowerNames", table.concat(towernames, ":"))
end

function plymeta:ReceiveWeapons()
   self:StripWeapons()
   
   local level = self:GetTowerLevel()
   if level < TOWER.Size() then
      self:Give(TOWER.WEAPONS[level])
   end
   self:Give("weapon_stunstick")
   -- Prevent default loadout
end
