--- Player spawning and dying

function GM:PlayerInitialSpawn(ply)
	TOWER.InitPlayer(ply)
end

function GM:PlayerLoadout(ply)
	ply:ReceiveWeapons()
	-- Prevent default loadout
	return true
end

function GM:PlayerDeath(victim, inflictor, attacker)
	if victim == attacker then
		-- suicide resets the player
		TOWER.ResetPlayer(victim)
	elseif attacker:GetActiveWeapon():GetClass() == "weapon_stunstick" then
		TOWER.ResetPlayer(victim)
		if TOWER.HasWon(attacker) then
			EndGame(attacker)
		end
	else
		TOWER.PromotePlayer(attacker)
	end
end