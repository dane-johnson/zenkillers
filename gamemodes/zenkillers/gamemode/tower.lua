-- The tower system controls where a player is in the weapon progression and how close she is to winning

TOWER = {}
TOWER.WEAPONS = {}

function TOWER.Size()
   return #TOWER.WEAPONS + 1 -- Always +1 for stunstick
end

function TOWER.LoadTower(name)
   if not file.Exists("zenkillers/" .. name .. ".zk", "DATA") then
      Error("Using default tower as zenkillers/" .. name .. ".zk could not be found in the DATA folder\n")
   else
      local fin = file.Open("zenkillers/" .. name .. ".zk", "r", "DATA")
      local weapons = {}
      while not fin:EndOfFile() do
         local weapon = fin:ReadLine():gsub("[\n\r ]", "")
         if weapon != "" then
            table.insert(weapons, weapon)
            MsgN("zenkillers: Inserted " .. weapon)
         end
      end
      PrintTable(weapons)
      TOWER.WEAPONS = weapons
   end
end

function TOWER.GetWeaponNames()
   local names = {}
   for _, w in ipairs(TOWER.WEAPONS) do
      local weaponTable = weapons.Get(w)
      local name
      if weaponTable then
         name = weaponTable.PrintName
         if name == "Scripted Weapon" then
            -- Come on yall take some pride in your work...
            name = w
         end
      else
         -- Engine weapons don't have a weapon table?
         name = w
      end
      table.insert(names, name)
   end
   table.insert(names, "Stunstick")
   return names
end

function TOWER.InitPlayer(ply)
   local level = 1 -- Everyone starts at the bottom
   ply:SetTowerLevel(1)
   ply:SetTowerNames(TOWER.GetWeaponNames())
end

function TOWER.PromotePlayer(ply)
   local level = ply:GetTowerLevel()
   level = level + 1
   ply:SetTowerLevel(level)
   ply:ReceiveWeapons()
end

function TOWER.ResetPlayer(ply)
   local level = 1 -- As it was in the beginning...
   ply:SetTowerLevel(1)
end

function TOWER.HasWon(ply)
   local level = ply:GetTowerLevel()
   return level == TOWER.Size()
end
