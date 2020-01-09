require("mysqloo")

local function createTable()
	local query = BREAKPOINT.Database:query("CREATE TABLE IF NOT EXISTS inventory ("..
		"steamid VARCHAR(255) NOT NULL,"..
		"inventory VARCHAR(255) NOT NULL,"..
		"PRIMARY KEY (steamid),"..
		"FOREIGN KEY(steamid) REFERENCES main(steamid))")
	
	function query:onSuccess(data)
	end

	function query:onError(err)
		error(err)
	end

	query:start()
end
hook.Add("onDatabaseConnected" ,"createInventoryTable", createTable)

local function addNewPlayer(ply)
	local query = BREAKPOINT.Database:query("INSERT INTO inventory(steamid, inventory) VALUES(\""..ply:SteamID().."\", "..ply:GetInventory()..")")

	function query:onSuccess(data)
	end

	function query:onError(err)
		error(err)
	end

	query:start()
end
hook.Add("playerFirstSpawn", "addPlayerLevel", addNewPlayer)

local function savePlayer(ply)
	local json = util.TableToJSON(ply:GetInventory())
	
	local query = BREAKPOINT.Database:query([[INSERT INTO inventory(steamid, inventory) VALUES("]]..ply:SteamID()..[[","]]..json..[[) ON DUPLICATE KEY UPDATE level=]]..ply:GetLevel()..[[, xp=]]..ply:GetXP())

	function query:onSuccess(data)
		print(ply:GetInventory())
	end

	function query:onError(err)
		error(err)
	end

	query:start()
end
hook.Add("PlayerDisconnected", "savePlayerXP", savePlayer)
concommand.Add("saveinv", function(ply)
	savePlayer(ply)
end)

local function loadPlayer(ply)
	local query = BREAKPOINT.Database:query("SELECT * FROM inventory WHERE steamid=\""..ply:SteamID().."\"")

	function query:onSuccess(data)
		if data[1] == nil then
			ply:SetInventory()
			return
		end

		ply:SetInventory(data[1])
	end

	function query:onError(err)
		error(err)
	end

	query:start()
end
hook.Add("PlayerInitialSpawn", "loadLevelData", loadPlayer)