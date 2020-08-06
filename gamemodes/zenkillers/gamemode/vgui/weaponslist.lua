local PANEL = {}

local WHITE = Color(255, 255, 255)
local YELLOW = Color(255, 255, 0)

function PANEL:Paint(w, h)
   local y = 0

   local ply = LocalPlayer()

   -- Draw the names
   for i, wpn in ipairs(ply:GetTowerNames()) do
      surface.SetTextPos(0, y)
      if i == ply:GetTowerLevel() then
         surface.SetTextColor(YELLOW)
      else
         surface.SetTextColor(WHITE)
      end
      surface.DrawText(wpn)
      y = y + 20
   end
end

vgui.Register("ZKWeaponslist", PANEL)
