
local function xpOverTime()
	for k, v in pairs(BREAKPOINT.GetPlayers()) do
		v:AddXP(LevellingConfig["XPPerMinute"])
	end
end
hook.Add("eachMinute", "xpOverTime", xpOverTime)

local function npcKillXP(npc, ply, inflictor)
	if not IsValid(ply) or not ply:IsPlayer() then return end

	ply:AddXP(LevellingConfig["NPCKillXP"])
end
hook.Add("OnNPCKilled", "npcKillXP", npcKillXP)