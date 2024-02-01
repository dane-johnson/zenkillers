-- Extentions to base player class

local plymeta = FindMetaTable("Player")

function plymeta:SetTowerLevel(level)
  self:SetNWInt("TowerLevel", level)
end

function plymeta:SetTowerNames(towernames)
  self:SetNWString("TowerNames", table.concat(towernames, ":"))
end

function plymeta:SetStabs(stabs)
  self:SetNWInt("Stabs", stabs)
end

function plymeta:ReceiveWeapons()
  self:StripWeapons()

  local wep = self:GetTowerClass()
  if wep then
    self:Give(wep)
  end
  self:Give("weapon_zk_knife")
end
