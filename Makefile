MSG=

.PHONY: publish

builds/zenkillers.gma: gamemodes/zenkillers/gamemode/*.lua gamemodes/zenkillers/zenkillers.txt gamemodes/zenkillers/weapons/*.lua
	gmad.exe create -folder "." -out "builds/zenkillers.gma"
publish: builds/zenkillers.gma zenkillers.jpg
ifeq ($(MSG),)
	$(error Must set MSG!)
else
	gmpublish update -addon "builds/zenkillers.gma" -id "2140807650" -changes "$(MSG)"
endif
