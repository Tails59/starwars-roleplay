AddCSLuaFile()

BREAKPOINT = {}

BREAKPOINT.Factions = {
	["Light"] = {
		"Jedi Consular",
		"Jedi Knight",
		"Trooper",
		"Smuggler"
	},

	["Dark"] = {
		"Sith Warrior",
		"Sith Inquisitor",
		"Bounty Hunters",
		"Imperial Agent"
	}
}

BREAKPOINT.Characters = {
	["GetMaxCharacters"] = function(ply)
		if ply:IsSuperAdmin() then
			return 6; 
		elseif ply:IsAdmin() then
			return 3;
		end

		return 1;
	end
}