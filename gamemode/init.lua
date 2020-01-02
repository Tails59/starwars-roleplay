include("include.lua")

function GM:Initialize()
	local succ, err = pcall(BREAKPOINT.MySQL.Load)

	if not succ then
		error(err)
		return
	end
end

function GM:PlayerInitialSpawn(ply, _)
	if (BREAKPOINT.MySQL.FirstEverSpawn(ply)) then
		print("FIRST SPAWN")
		BREAKPOINT.MySQL.InsertPlayer(ply)
		
		hook.Run("playerFirstSpawn", ply)
	end
end