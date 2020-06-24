GM.Name = "Zen Killers"
GM.Author = "Dane Johnson"
GM.Email = "daneallenjohnson@protonmail.com"
GM.Website = "github.com/dane-johnson"

CreateConVar("zk_towername", "default", FCVAR_NONE, "The name of the file containing the tower weapon names. See workshop for details on adding towers.")
CreateConVar("zk_equipdelay", 0.75, FCVAR_NEVER_AS_STRING, "How long to wait while switching guns")

GM.NumberOfGuns = 1 -- Default tower, just the stunstick

function GM:Initialize()
end

function GM:Think()
   if SERVER then
      for _, ply in ipairs(player.GetAll()) do
         if ply:Alive() then
            local weapon = ply:GetActiveWeapon()
            if weapon ~= NULL then
               local ammoType = weapon:GetPrimaryAmmoType()
               if ammoType ~= -1 then
                  local currentAmmo = ply:GetAmmo()[ammoType] or 0
                  ply:GiveAmmo(9999 - currentAmmo, ammoType, true)
               end
            end
         end
      end
   end
end
