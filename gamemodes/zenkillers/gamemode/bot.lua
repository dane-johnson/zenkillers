function BotAI(bot, cmd)
   if not bot:IsBot() then return end
   if not bot:Alive() then
      -- Respawn
      cmd:SetButtons(IN_ATTACK)
      return
   end
   cmd:ClearMovement()
   cmd:ClearButtons()

   local closest
   
   for _, tgt in ipairs(player.GetAll()) do
      if tgt ~= bot and (closest == nil or bot:GetPos():DistToSqr(tgt:GetPos()) < bot:GetPos():DistToSqr(closest:GetPos())) then
         closest = tgt
      end
   end
   
   bot.tgt = closest

   cmd:SetViewAngles( ( bot.tgt:GetShootPos() - bot:GetShootPos() ):GetNormalized():Angle() )
   cmd:SetForwardMove(1000)
   
   -- Do a raytrace
   local spos = bot:GetShootPos()
   local sdest = bot.tgt:GetShootPos()
   local tr = util.TraceLine({start=spos, endpos=sdest, filter=bot})
   if IsValid(tr.Entity) and tr.Entity == bot.tgt then
      cmd:SetButtons(IN_ATTACK)
   end
end

hook.Add("StartCommand", "BotAI", BotAI)
