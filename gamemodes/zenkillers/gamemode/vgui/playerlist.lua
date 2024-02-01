local PANEL = {}

local BLACK = Color(150, 150, 150)
local WHITE = Color(255, 255, 255)

function compare_players(ply1, ply2)
  if ply1:GetTowerLevel() ~= ply2:GetTowerLevel() then
    return ply1:GetTowerLevel() > ply2:GetTowerLevel()
  elseif ply1:Frags() ~= ply2:Frags() then
    return ply1:Frags() > ply2:Frags()
  elseif ply1:Deaths() ~= ply2:Deaths() then
    return ply1:Deaths() < ply2:Deaths()
  else
    return ply1:Nick() > ply2:Nick()
  end
end

function PANEL:Paint(w, h)
  local y = 0
  -- Draw Headers
  surface.SetTextColor(BLACK)
  surface.SetTextPos(0, y)
  surface.DrawText("Player")
  surface.SetTextPos(200, y)
  surface.DrawText("Weapon")
  surface.SetTextPos(400, y)
  surface.DrawText("K")
  surface.SetTextPos(450, y)
  surface.DrawText("D")
  surface.SetTextPos(500, y)
  surface.DrawText("Stabs")
  y = y + 20

  -- Draw the names
  surface.SetTextColor(WHITE)
  local sorted_players = player.GetAll()
  table.sort(sorted_players, compare_players)
  for _, ply in ipairs(sorted_players) do
    surface.SetTextPos(0, y)
    surface.DrawText(ply:Nick())
    surface.SetTextPos(200, y)
    surface.DrawText(ply:GetTowerNames()[ply:GetTowerLevel()])
    surface.SetTextPos(400, y)
    surface.DrawText(ply:Frags())
    surface.SetTextPos(450, y)
    surface.DrawText(ply:Deaths())
    surface.SetTextPos(500, y)
    surface.DrawText(ply:Stabs())
    y = y + 20
  end
end

vgui.Register("ZKPlayerlist", PANEL)
