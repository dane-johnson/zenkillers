-- The tower system controls where a player is in the weapon progression and how close she is to winning

TOWER = {}
TOWER.WEAPONS = {}

local DEFAULT_TOWER = [[
weapon_pistol,Pistol
weapon_357,Revolver
weapon_smg1,SMG
weapon_shotgun,Shotgun
weapon_frag,Grenade
weapon_ar2,Plasma Rifle
weapon_rpg,Rocket
weapon_crossbow,X-Bow
]]

function TOWER.Size()
   return #TOWER.WEAPONS + 1 -- Always +1 for knife
end

function TOWER.LoadTower(name)
   if not file.Exists("zenkillers/" .. name .. ".txt", "DATA") then
      if name == "default" then
         if not file.Exists("zenkillers", "DATA") then
            file.CreateDir("zenkillers")
         end
         local fout = file.Open("zenkillers/default.txt", "w", "DATA")
         fout:Write(DEFAULT_TOWER)
         fout:Close()
         TOWER.LoadTower("default") -- Recur
      else
         Error("Zenkillers: Could not find DATA/zenkillers" .. name .. ".txt. Reverting to default...")
         TOWER.LoadTower("default") -- Recur
      end
   else
      local fin = file.Open("zenkillers/" .. name .. ".txt", "r", "DATA")
      local weapons = {}
      while not fin:EndOfFile() do
         local weapon = fin:ReadLine():gsub("[\n\r]", "")
         if weapon != "" then
            local splitWeapon = string.Split(weapon, ",")
            if #splitWeapon == 1 then
               table.insert(weapons, {className=weapon, prettyName=weapon})
            else
               table.insert(weapons, {className=splitWeapon[1], prettyName=splitWeapon[2]})
            end
            MsgN("zenkillers: Inserted " .. weapon)
         end
      end
      TOWER.WEAPONS = weapons
   end
end

function TOWER.GetWeaponNames()
   local names = {}
   for _, w in ipairs(TOWER.WEAPONS) do
      table.insert(names, w.prettyName)
   end
   table.insert(names, "Knife")
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
   if level == TOWER.Size() then
      Announce(ply:Nick() .. " has reached the knife!")
   end
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
