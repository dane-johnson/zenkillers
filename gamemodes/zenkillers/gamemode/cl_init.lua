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
   local all = true
   for _, ply in ipairs(player:GetAll()) do
      if ply:GetTowerLevel() > max then
         leaders = {ply}
         if max ~= 0 then
            all = false
         end
         max = ply:GetTowerLevel()
      elseif ply:GetTowerLevel() == max then
         table.insert(leaders, ply)
      else
         all = false
      end
   end
   if not all then
      halo.Add(leaders, BLOOD_RED)
   end
end
