local function addPlayer(ply)
	local query = BREAKPOINT.Database:query([[INSERT INTO playtime(steamid, totaltime) VALUES("]]..ply:SteamID()..[[", 0)]])

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

local function onJoin(ply)
	ply:SetJoinTime()
	
	local query = BREAKPOINT.Database:query("SELECT totaltime FROM starwarsrp.playtime WHERE steamid=\""..ply:SteamID().."\"")

	function query:onSuccess(data)
		if data[1] == nil then
			addPlayer(ply)
			return
		end
		ply:SetPlaytime(data[1]["totaltime"])
	end

	function query:onError(err)
		error(err)
	end

	query:start()
end
hook.Add("PlayerInitialSpawn", "playTimeInitialSpawn", onJoin)

local meta = FindMetaTable("Player")

local function onLeave(ply)
	local query = BREAKPOINT.Database:query("UPDATE playtime SET totaltime="..ply:GetTotalPlaytime().." WHERE steamid=\""..ply:SteamID().."\"")

	function query:onSuccess(data)
	end

	function query:onError(err)
		error(err)
	end

	query:start()
end
hook.Add("PlayerDisconnected", "playTimeDisconnect", onLeave)

local function checkTime()
	for k, ply in pairs(BREAKPOINT.GetPlayers()) do
		if ply:GetJoinTime() + 5 < CurTime() then
			ply:AddHour()
			ply:SetJoinTime()
		end
	end
end
hook.Add("eachMinute", "playtimeChecker", checkTime)
