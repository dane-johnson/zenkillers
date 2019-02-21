local draw = draw

HUD = {}

function HUD.DrawHud() 
	-- This is my custom HUD
	local client = LocalPlayer()
	local bottom = ScrH()
	
	if not client:Alive() then return end
	
	draw.RoundedBox(3, 25, bottom - 130, 150, 55, Color(0, 0, 0, 100))
	
	draw.SimpleText(client:GetTowerLevel() .. "/" .. GAMEMODE.NumberOfGuns, "HudNumbers", 105, bottom - 120, Color(255, 255, 0, 255), 0, 0)
end
hook.Add("HUDPaint", "DrawHud", HUD.DrawHud)


local blacklist = { -- Blacklisted elements will be hidden

}

function HUD.HUDShouldDraw(name)
	if blacklist[name] then return false end
end
hook.Add("HUDShouldDraw", "HUDShouldDraw", HUD.HUDShouldDraw)