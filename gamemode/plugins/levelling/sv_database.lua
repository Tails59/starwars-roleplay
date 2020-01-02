if not BREAKPOINT.MySQL or not BREAKPOINT.MySQL.Enabled then 
	ErrorNoHalt("Couldn't load Levelling plugin - Database not configured!")
	return 
end

require("mysqloo")

local function createTable()
	local query = BREAKPOINT.Database:query("CREATE TABLE IF NOT EXISTS levelling ("..
		"steamid VARCHAR(255) NOT NULL,"..
		"level INT NOT NULL DEFAULT 0,"..
		"xp INT NOT NULL DEFAULT 0,"..
		"PRIMARY KEY (steamid),"..
		"FOREIGN KEY(steamid) REFERENCES main(steamid))")
	
	function query:onSuccess(data)
	end

	function query:onError(err)
		error(err)
	end

	query:start()
end
hook.Add("onDatabaseConnected" ,"createTable", createTable)

local function addNewPlayer(ply)
	local query = BREAKPOINT.Database:query("INSERT INTO levelling(steamid, level, xp) VALUES(\""..ply:SteamID().."\", "..ply:GetLevel()..", "..ply:GetXP()..")")

	function query:onSuccess(data)
	end

	function query:onError(err)
		error(err)
	end

	query:start()
end
hook.Add("playerFirstSpawn", "addNewRecord", addNewPlayer)

local function loadPlayer(ply)
	local query = BREAKPOINT.Database:query("SELECT * FROM levelling WHERE steamid=\""..ply:SteamID().."\"")

	function query:onSuccess(data)
		if data[1] == nil then
			ply:SetNW2Int("XP", 0)
			ply:SetNW2Int("Level", 0)

			return
		end

		ply:SetNW2Int("XP", data[1]["xp"])
		ply:SetNW2Int("Level", data[1]["level"])
	end

	function query:onError(err)
		error(err)
	end

	query:start()
end
hook.Add("PlayerInitialSpawn", "loadLevelData", loadPlayer)

