--- Player spawning and dying

function GM:PlayerInitialSpawn(ply)
  ply:SetModel("models/player/leet.mdl")
  TOWER.InitPlayer(ply)
end

function GM:PlayerLoadout(ply)
  ply:ReceiveWeapons()
  -- Prevent default loadout
  return true
end

function GM:PlayerDeath(victim, inflictor, attacker)
  if victim == attacker or attacker == game.GetWorld() or attacker:GetClass() == "trigger_hurt" then
    -- suicide resets the player
    TOWER.ResetPlayer(victim)
  elseif IsValid(attacker:GetActiveWeapon()) and inflictor:GetClass() == "weapon_zk_knife" then
    TOWER.ResetPlayer(victim)
    if TOWER.HasWon(attacker) then
      EndGame(attacker)
    else
      attacker:SetStabs(attacker:Stabs() + 1) -- Shame the stabber
    end
  else
    TOWER.PromotePlayer(attacker)
  end
end

function GM:PlayerCanPickupWeapon(ply, wep)
  -- Player can only pick up the current tower weapon and a knife
  return
    GetConVar("zk_allow_pickups"):GetBool() or
    wep:GetClass() == "weapon_zk_knife" or
    wep:GetClass() == ply:GetTowerClass()
end
