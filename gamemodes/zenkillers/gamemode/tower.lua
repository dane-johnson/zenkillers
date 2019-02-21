-- The tower system controls where a player is in the weapon progression and how close she is to winning

TOWER = {}

function TOWER.InitPlayer(ply)
	local level = 1 -- Everyone starts at the bottom
	ply:SetTowerLevel(1)
end

function TOWER.PromotePlayer(ply)
	local level = ply:GetTowerLevel()
	level = level + 1
	ply:SetTowerLevel(level)
	ply:ReceiveWeapons()
end

function TOWER.ResetPlayer(ply)
	local level = 1 -- As it was in the beginning...
	ply:SetTowerLevel(1)
end

function TOWER.HasWon(ply)
	local level = ply:GetTowerLevel()
	return level == GAMEMODE.NumberOfGuns
end