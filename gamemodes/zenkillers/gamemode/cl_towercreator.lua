local towercreator = nil
local swepmenu = nil

local TRANSPARENT_GREY = Color(100, 100, 100, 250)

-- Emulate the scoreboard

function GM:TowerCreatorCreate()
   towercreator = vgui.Create("DFrame")
   towercreator:SetTitle("Tower Creator")

   local h = ScrH() * 0.8
   local w = ScrW() * 0.7
   towercreator:SetSize(w, h)
   towercreator:Center()


   -- Weapons selection
   local weapons_scroll = vgui.Create("DScrollPanel", towercreator)
   weapons_scroll:Dock(FILL)
   weapons_scroll:SetSize(w/3, h)

   local weaponiconlayout = vgui.Create("DIconLayout", weapons_scroll)
   weaponiconlayout:Dock(FILL)
   weaponiconlayout:MakeDroppable("zenkiller")

   local sweps = weapons.GetList()
   for i, swep in ipairs(sweps) do
      make_swep_icon(swep, weaponiconlayout)
   end

   -- Tower Listing
   local tower = vgui.Create("DScrollPanel", towercreator)
   tower:Dock(LEFT)
   tower:SetSize(w/2, h)

   function do_drop(self, panels, dropped, idx, x, y)
      if dropped then
         if self.placeholder then
            self.placeholder:Remove()
            self.placeholder = nil
         end
         for k, v in ipairs(panels) do
            weaponiconlayout:Add(v)
            make_zk_weapon_icon(v, self)
         end
      end
   end
      

   local towerlistlayout = vgui.Create("DListLayout", tower)
   towerlistlayout:Dock(FILL)
   towerlistlayout:SetMinimumSize(w/2, h)
   towerlistlayout:Receiver("zenkiller", do_drop)
   towerlistlayout:MakeDroppable("tower_reorder")

   local placeholder = vgui.Create("DLabel", towerlistlayout)
   placeholder:Dock(FILL)
   placeholder:SetText("Drop Weapons Here")
   towerlistlayout.placeholder = placeholder

   -- File IO
   local infopanel = vgui.Create("DIconLayout", towercreator)
   infopanel:Dock(TOP)

   local towername = vgui.Create("DTextEntry", infopanel)
   towername:SetPlaceholderText("Tower Name")
   towername:SetMinimumSize(80, 1)

   local savebtn = vgui.Create("DButton", infopanel)
   savebtn:SetText("Save")
   savebtn.DoClick = function()
      local tower = {}
      tower.name = towername:GetText()
      tower.weapons = {}

      for i, zk_weapon_icon in ipairs(towerlistlayout:GetChildren()) do
         tower.weapons[i] = {}
         tower.weapons[i].printname = zk_weapon_icon.name:GetText()
         tower.weapons[i].classname = zk_weapon_icon.label:GetText()
      end

      save_tower(tower)
   end

   towercreator:MakePopup()

   -- Destroy on F2
   function towercreator:OnKeyCodeReleased(btn)
      if btn == KEY_F2 then
         towercreator:Remove()
         return true -- Stop key propogation
      end
      return false
   end
end

function make_swep_icon(swep, parent)
   local swepbtn = vgui.Create("SpawnIcon", parent)
   swepbtn:SetModel(swep.WorldModel or swep.ViewModel)
   swepbtn:SetTooltip(swep.PrintName)
   swepbtn.weapon_classname = swep.ClassName
end


function make_zk_weapon_icon(panel, parent)
   local swep = weapons.Get(panel.weapon_classname)
   
   local panel = vgui.Create("DIconLayout", parent)

   
   make_swep_icon(swep, panel)

   local label = vgui.Create("DLabel", panel)
   label:SetText(swep.ClassName)
   label:SetSize(100, 60)
   panel.label = label

   local name = vgui.Create("DTextEntry", panel)
   name:SetValue(swep.PrintName or swep.ClassName)
   name:SetSize(100, 60)
   panel.name = name
   
   panel:SetSize(1, 60)
end

-- Create menu when player presses F2
function player_pressed_key(ply, button)
   if button == KEY_F2 then
      GAMEMODE:TowerCreatorCreate()
   end
end

hook.Add("PlayerButtonDown", "PlayerTowerCreatorButton", player_pressed_key)


-- Save a tower to disk

function save_tower(tower)
   if not file.Exists("zenkillers", "DATA") then
      file.CreateDir("zenkillers")
   end
   local filename = "zenkillers/" .. tower.name .. ".txt"
   local fout = file.Open(filename, "w", "DATA")
   for i, weapon in ipairs(tower.weapons) do
      fout:Write(weapon.classname .. "," .. weapon.printname .. "\n")
   end
   fout:Close()
end
