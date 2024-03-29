require("mysqloo")

BREAKPOINT.MySQL = {}
BREAKPOINT.MySQL.Enabled = true

BREAKPOINT.MySQL.host = ""
BREAKPOINT.MySQL.user = ""
BREAKPOINT.MySQL.pass = ""
BREAKPOINT.MySQL.database = ""
BREAKPOINT.MySQL.port = 3306

BREAKPOINT.Database = BREAKPOINT.Database or nil

local function createMainTable()
	local query = BREAKPOINT.Database:query("CREATE TABLE IF NOT EXISTS main ("..
		"steamid VARCHAR(255) NOT NULL,"..
		"PRIMARY KEY (steamid)"..
		")")
	
	function query:onSuccess(data)
	end

	function query:onError(err)
		error(err)
	end

	query:start()
end

function BREAKPOINT.MySQL.InsertPlayer(ply)
	local query = BREAKPOINT.Database:query("INSERT INTO main(steamid) VALUES(\""..ply:SteamID().."\")")

	function query:onSuccess(data)
	end

	function query:onError(err)
		error(err)
	end

	query:start()
end

function BREAKPOINT.MySQL.Load()
	local x = BREAKPOINT.MySQL
	BREAKPOINT.Database = mysqloo.connect(x.host, x.user, x.pass, x.database, x.port)

	function BREAKPOINT.Database:onConnected()
		ELogs.Output("Established connection to database!")
		createMainTable()

		hook.Run("onDatabaseConnected")
	end

	function BREAKPOINT.Database:onConnectionFailed()
		ErrorNoHalt("BPSkins failed to connect to DB")
	end

	BREAKPOINT.Database:connect()
end

function BREAKPOINT.MySQL.FirstEverSpawn(ply)
	if not BREAKPOINT.Database then
		ErrorNoHalt("No database connection establish!")
		return
	end

	if not ply then return end

	local query = BREAKPOINT.Database:query("SELECT 1 FROM starwarsrp.main WHERE steamid=\""..ply:SteamID().."\"")
	
	local val;
	function query:onSuccess(data)
		if (data[1] == nil) then
			val = true;
		else
			val = false;
		end
	end

	function query:onError(err)
		error(err)
	end

	query:start()
	query:wait(true)

	return val;
end
