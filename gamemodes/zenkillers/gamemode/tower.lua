-- The tower system controls where a player is in the weapon progression and how close she is to winning

TOWER = {}
TOWER.WEAPONS = {}

local DEFAULT_TOWER = [[
weapon_pistol
weapon_357
weapon_smg1
weapon_shotgun
weapon_frag
weapon_ar2
weapon_rpg
weapon_crossbow
]]

function TOWER.Size()
   return #TOWER.WEAPONS + 1 -- Always +1 for stunstick
end

function TOWER.LoadTower(name)
   if not file.Exists("zenkillers/" .. name .. ".dat", "DATA") then
      if name == "default" then
         if not file.Exists("zenkillers", "DATA") then
            file.CreateDir("zenkillers")
         end
         local fout = file.Open("zenkillers/default.dat", "w", "DATA")
         fout:Write(DEFAULT_TOWER)
         fout:Close()
         TOWER.LoadTower("default") -- Recur
      else
         Error("Zenkillers: Could not find DATA/zenkillers" .. name .. ".dat. Reverting to default...")
         TOWER.LoadTower("default") -- Recur
      end
   else
      local fin = file.Open("zenkillers/" .. name .. ".dat", "r", "DATA")
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
