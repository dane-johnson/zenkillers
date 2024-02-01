local scoreboard = nil
local playerlist = nil
local weaponslist = nil

local TRANSPARENT_GREY = Color(100, 100, 100, 250)

function GM:ScoreboardCreate()
  scoreboard = vgui.Create("DPanel")
  scoreboard:SetBackgroundColor(TRANSPARENT_GREY)

  playerlist = vgui.Create("ZKPlayerlist", scoreboard)

  weaponslist = vgui.Create("ZKWeaponslist", scoreboard)
end

function GM:ScoreboardUpdate()
  local h = ScrH() * 0.8 or 200
  local w = ScrW() * 0.45 or 300
  scoreboard:SetSize(w, h)
  scoreboard:SetPos((ScrW() - w) / 2, (ScrH() - h) / 2)
  playerlist:SetSize(w * 2/3, h)
  playerlist:SetPos(0, 0)
  weaponslist:SetSize(w * 1/3, h)
  weaponslist:SetPos(w * 2/3, 0)
end

function GM:ScoreboardShow()
  if not scoreboard then
    self:ScoreboardCreate()
  end
  self:ScoreboardUpdate()
  scoreboard:SetVisible(true)
end

function GM:ScoreboardHide()
  scoreboard:SetVisible(false)
end
