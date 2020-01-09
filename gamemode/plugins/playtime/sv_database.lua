if not BREAKPOINT.MySQL or not BREAKPOINT.MySQL.Enabled then 
	ErrorNoHalt("Couldn't load playtime plugin - Database not configured!")
	return 
end

require("mysqloo")

local function createTable()
	local query = BREAKPOINT.Database:query("CREATE TABLE IF NOT EXISTS playtime ("..
		"steamid VARCHAR(255) NOT NULL,"..
		"totaltime INTEGER NOT NULL DEFAULT 0,"..
		"PRIMARY KEY (steamid),"..
		"FOREIGN KEY(steamid) REFERENCES main(steamid))")
	
	function query:onSuccess(data)
	end

	function query:onError(err)
		error(err)
	end

	query:start()
end
hook.Add("onDatabaseConnected" ,"createPlaytimeTable", createTable)

local function addNewPlayer(ply)
	local query = BREAKPOINT.Database:query("INSERT INTO playtime(steamid) VALUES(\""..ply:SteamID().."\")")

	function query:onSuccess(data)
	end

	function query:onError(err)
		error(err)
	end

	query:start()
end
hook.Add("playerFirstSpawn", "addPlayerPlaytime", addNewPlayer)

local function loadPlayer(ply)
	local query = BREAKPOINT.Database:query("SELECT * FROM playtime WHERE steamid=\""..ply:SteamID().."\"")

	function query:onSuccess(data)
		
	end

	function query:onError(err)
		error(err)
	end

	query:start()
end
hook.Add("PlayerInitialSpawn", "loadLevelData", loadPlayer)
