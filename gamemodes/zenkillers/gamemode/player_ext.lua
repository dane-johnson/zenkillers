-- Extentions to base player class

local plymeta = FindMetaTable("Player")

function plymeta:SetTowerLevel(level)
   self:SetNWInt("TowerLevel", level)
end

function plymeta:ReceiveWeapons()
   self:StripWeapons()
   
   local level = self:GetTowerLevel()
   MsgN("At level " .. level .. " of " .. GAMEMODE.NumberOfGuns)
   if level < GAMEMODE.NumberOfGuns then
      self:Give(TOWER.WEAPONS[level])
   end
   self:Give("weapon_stunstick")
   -- Prevent default loadout
end
