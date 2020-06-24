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
TOWER.LoadTower(towername)

function EndGame(winner)
   for _, ply in ipairs(player.GetAll()) do
      TOWER.ResetPlayer(ply)
      ply:KillSilent()
   end
end
