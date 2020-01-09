if not BREAKPOINT.MySQL or not BREAKPOINT.MySQL.Enabled then 
	ErrorNoHalt("Couldn't load characters plugin - Database not configured!")
	return 
end

require("mysqloo")

local function addPlayer(ply, char)
	local query = BREAKPOINT.Database:query([[INSERT INTO characters(steamid, totaltime) VALUES("]]..ply:SteamID()..[[", 0)]])

	function query:onSuccess(data)
		if data[1] == nil then
			return
		end
		ply:SetPlaytime(data[1]["totaltime"])
	end

	function query:onError(err)
		error(err)
	end

	query:start()
end

local function createTable()
	local query = BREAKPOINT.Database:query([[CREATE TABLE IF NOT EXISTS characters(
		char_id INT AUTO_INCREMENT UNIQUE,
		steamid VARCHAR(255) NOT NULL,
		char_name VARCHAR(255) DEFAULT "UNSET NAME" NOT NULL,
		male BOOL DEFAULT 1 NOT NULL,
		species VARCHAR(255) DEFAULT "Human" NOT NULL,
		faction VARCHAR(255) DEFAULT "Light" NOT NULL,
		subfaction VARCHAR(255) DEFAULT "Jedi Consular" NOT NULL,
		specialisation VARCHAR(255) DEFAULT "Jedi Sage" NOT NULL,
		FOREIGN KEY(steamid) REFERENCES main(steamid)
		)]]
	)
	
	function query:onSuccess(data)
	end

	function query:onError(err)
		error(err)
	end

	query:start()
end
hook.Add("onDatabaseConnected" ,"createCharactersTable", createTable)

local function loadPlayer(ply)
	local query = BREAKPOINT.Database:query("SELECT * FROM characters WHERE steamid=\""..ply:SteamID().."\"")

	function query:onSuccess(data)
		if data[1] == nil then
			
			return	
		end

		PrintTable(data)
	end

	function query:onError(err)
		error(err)
	end

	query:start()
end
hook.Add("PlayerInitialSpawn", "loadCharData", loadPlayer)
