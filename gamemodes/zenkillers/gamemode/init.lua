AddCSLuaFile("cl_init.lua")
AddCSLuaFile("cl_hud.lua")
AddCSLuaFile("shared.lua")
AddCSLuaFile("player_ext_shd.lua")

include("shared.lua")
include("player.lua")
include("player_ext.lua")
include("player_ext_shd.lua")
include("tower.lua")

local player = player

function EndGame(winner)
	for _, ply in ipairs(player.GetAll()) do
		TOWER.ResetPlayer(ply)
		ply:KillSilent()
	end
end