AddCSLuaFile("cl_init.lua")
AddCSLuaFile("cl_hud.lua")
AddCSLuaFile("shared.lua")
AddCSLuaFile("player_ext_shd.lua")

include("tower.lua")
include("shared.lua")
include("player.lua")
include("player_ext.lua")
include("player_ext_shd.lua")

local player = player

local towername = GetConVar("zk_towername"):GetString()
if towername == "" then
   -- Warn for default tower
   Error("Using default tower because \"zk_towername\" is empty.\n")
else
   TOWER.LoadTower(towername)
end


function EndGame(winner)
   for _, ply in ipairs(player.GetAll()) do
      TOWER.ResetPlayer(ply)
      ply:KillSilent()
   end
end
