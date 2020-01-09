local meta = FindMetaTable("Player")

function meta:GetTotalPlaytime()
	return self:GetNW2Int("Playtime", 0)
end

//Returns the players join time
//Or more accurately, returns the time the player joined OR the time at which his hours increased by 1 - whichever is more recent
//This should not be relied on to get the players actual join time
function meta:GetJoinTime()
	return self:GetNW2Int("JoinTime", 0)
end

if SERVER then
	//Add 1 hour to the players time - we shouldnt ever need to add more than 1 
	function meta:AddHour()
		self:SetNW2Int("Playtime", self:GetTotalPlaytime() + 1)
		hook.Run("playerHourUp", self)
	end

	function meta:SetPlaytime(hours)
		self:SetNW2Int("Playtime", hours)
	end

	function meta:SetJoinTime()
		self:SetNW2Int("JoinTime", CurTime())
	end
end