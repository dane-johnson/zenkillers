AddCSLuaFile("cl_init.lua")
AddCSLuaFile("cl_hud.lua")
AddCSLuaFile("cl_scoreboard.lua")
AddCSLuaFile("shared.lua")
AddCSLuaFile("player_ext_shd.lua")
AddCSLuaFile("vgui/weaponslist.lua")
AddCSLuaFile("vgui/playerlist.lua")

include("bot.lua")
include("tower.lua")
include("shared.lua")
include("player.lua")
include("player_ext.lua")
include("player_ext_shd.lua")

local player = player

local towername = GetConVar("zk_towername"):GetString()
TOWER.LoadTower(towername)

function Announce(msg)
   for _, ply in ipairs(player.GetAll()) do
      ply:ChatPrint(msg)
   end
end

function EndGame(winner)
   Announce(winner:Nick() .. " has won!")
   for _, ply in ipairs(player.GetAll()) do
      TOWER.ResetPlayer(ply)
      ply:KillSilent()
   end
end
