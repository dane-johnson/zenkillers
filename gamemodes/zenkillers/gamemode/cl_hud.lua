local draw = draw

HUD = {}

function HUD.DrawHud() 
	-- This is my custom HUD
	local client = LocalPlayer()
	local bottom = ScrH()
	
	if not client:Alive() then return end
	
	draw.RoundedBox(3, 25, bottom - 230, 250, 100, Color(0, 0, 0, 100))

        draw.SimpleText(client:GetTowerNames()[client:GetTowerLevel() + 1] or "-----", "HudHintTextLarge", 110, bottom - 200, Color(255, 255, 0, 200), 0, 0)
                draw.SimpleText("Next", "HudHintTextLarge", 35, bottom - 200, Color(255, 255, 0, 200), 0, 0)
	
	draw.SimpleText(client:GetTowerLevel() .. "/" .. #client:GetTowerNames(), "HudNumbers", 105, bottom - 170, Color(255, 255, 0, 200), 0, 0)
	draw.SimpleText("Level", "HudHintTextLarge", 35, bottom - 160, Color(255, 255, 0, 200), 0, 0)
end
hook.Add("HUDPaint", "DrawHud", HUD.DrawHud)


local blacklist = { -- Blacklisted elements will be hidden

}

function HUD.HUDShouldDraw(name)
	if blacklist[name] then return false end
end
hook.Add("HUDShouldDraw", "HUDShouldDraw", HUD.HUDShouldDraw)
