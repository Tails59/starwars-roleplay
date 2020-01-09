include("include.lua")

local CurTime = CurTime
local pairs = pairs
local ipairs = ipairs
local hook = hook

function GM:Initialize()
	local succ, err = pcall(BREAKPOINT.MySQL.Load)

	if not succ then
		error(err)
		return
	end
end

function GM:PlayerInitialSpawn(ply, _)
	if (BREAKPOINT.MySQL.FirstEverSpawn(ply)) then
		BREAKPOINT.MySQL.InsertPlayer(ply)
		
		hook.Run("playerFirstSpawn", ply)
	end
end

local PLAYERS = {}
local function playerLeave(ply)
	PLAYERS = player.GetAll()
end
hook.Add("PlayerDisconnected", "playerLeave", playerLeave)

local function playerJoin(ply)
	PLAYERS = player.GetAll()
end
hook.Add("PlayerInitialSpawn", "playerJoin", playerJoin)

function BREAKPOINT.GetPlayers()
	return PLAYERS;
end

function BREAKPOINT.GetPlayerCount()
	return #PLAYERS;
end
