builds/zenkillers.gma: gamemodes/zenkillers/gamemode/*.lua gamemodes/zenkillers/zenkillers.txt gamemodes/zenkillers/weapons/*.lua
	gmad.exe create -folder "." -out "builds/zenkillers.gma"
