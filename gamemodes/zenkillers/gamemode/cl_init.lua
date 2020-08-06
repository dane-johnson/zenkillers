include("vgui/playerlist.lua")
include("vgui/weaponslist.lua")
include("cl_hud.lua")
include("cl_scoreboard.lua")
include("shared.lua")
include("player_ext_shd.lua")

local BLOOD_RED = Color(255, 0, 0)

function GM:PreDrawHalos()
   local leaders = {}
   local max = 0
   for _, ply in ipairs(player:GetAll()) do
      if ply:GetTowerLevel() > max then
         leaders = {ply}
         max = ply:GetTowerLevel()
      elseif ply:GetTowerLevel() == max then
         table.insert(leaders, ply)
      end
   end
   halo.Add(leaders, BLOOD_RED)
end
