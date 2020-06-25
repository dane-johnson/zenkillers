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
   if victim == attacker then
      -- suicide resets the player
      TOWER.ResetPlayer(victim)
   elseif IsValid(attacker:GetActiveWeapon()) and attacker:GetActiveWeapon():GetClass() == "weapon_zk_knife" then
      TOWER.ResetPlayer(victim)
      if TOWER.HasWon(attacker) then
         EndGame(attacker)
      end
   else
      TOWER.PromotePlayer(attacker)
   end
end
