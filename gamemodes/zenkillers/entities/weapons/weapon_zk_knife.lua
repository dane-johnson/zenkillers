AddCSLuaFile()

SWEP.PrintName = "Knife"
SWEP.Author = "Dane Johnson"
SWEP.Instructions = "Instant kill to setback an opponent or win the game"

SWEP.Spawnable = true

SWEP.Slot = 0
SWEP.SlotPos = 0
SWEP.Weight = -1
SWEP.ViewModelFlip = false
SWEP.ViewModelFOV = 54
SWEP.DrawAmmo = false
SWEP.DrawCrosshair = true

SWEP.UseHands = true
SWEP.ViewModel = "models/weapons/cstrike/c_knife_t.mdl"
SWEP.WorldModel = "models/weapons/w_knife_t.mdl"

SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = -1
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = "none"
SWEP.Primary.Delay = 1.0

SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo = "none"

function SWEP:PrimaryAttack()
   self:SetNextPrimaryFire(CurTime() + self.Primary.Delay)

   -- Hull trace a short attack
   local spos = self:GetOwner():GetShootPos()
   local sdest = spos + (self:GetOwner():GetAimVector() * 70)

   local kmins = Vector(1, 1, 1) * -10
   local kmaxs = Vector(1, 1, 1) * 10

   self.Owner:LagCompensation(true)

   local tr = util.TraceHull({start=spos, endpos=sdest, filter=self:GetOwner(), mask=MASK_SHOT_HULL, mins=kmins, maxs=kmaxs})

   self.Owner:LagCompensation(false)

   -- If we hit the environment, just do a ray trace.
   if not IsValid(tr.Entity) then
      tr = util.TraceLine({start=spos, endpos=sdest, filter=self:GetOwner(), mask=MASK_SHOT_HULL})
   end

   local hitEnt = tr.Entity

   -- Blood
   if IsValid(hitEnt) then
      local edata = EffectData()
      edata:SetStart(spos)
      edata:SetOrigin(tr.HitPos)
      edata:SetNormal(tr.Normal)
      edata:SetEntity(hitEnt)

      if hitEnt:IsPlayer() or hitEnt:GetClass() == "prop_ragdoll" then
         util.Effect("BloodImpact", edata)
      end
   end

   if IsValid(hitEnt) then
      self:SendWeaponAnim(ACT_VM_SECONDARYATTACK)
      self:EmitSound("Weapon_Knife.Stab")
      if SERVER and hitEnt:IsPlayer() then
         -- Dead
         local dmg = DamageInfo()
         dmg:SetDamage(hitEnt:Health() + 1)
         dmg:SetAttacker(self:GetOwner())
         dmg:SetInflictor(self)
         dmg:SetDamageForce(self:GetOwner():GetAimVector() * 5)
         dmg:SetDamagePosition(self:GetOwner():GetPos())
         dmg:SetDamageType(DMG_SLASH)
         hitEnt:TakeDamageInfo(dmg)
      end
   else
      self:SendWeaponAnim(ACT_VM_MISSCENTER)
      self:EmitSound("Weapon_Knife.Slash")   
   end

   if SERVER then
      self:GetOwner():SetAnimation(PLAYER_ATTACK1)
   end
end
