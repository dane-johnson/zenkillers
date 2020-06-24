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

   local delay = GetConVar("zk_equipdelay")
   -- Give them new guns after 0.75 seconds (to keep from going to fast)
   timer.Simple(delay, function()
                   local level = self:GetTowerLevel()
                   if level < TOWER.Size() then
                      local weapon = self:Give(TOWER.WEAPONS[level])
                   end
                   self:Give("weapon_stunstick")
   end)
   -- Prevent default loadout
end
