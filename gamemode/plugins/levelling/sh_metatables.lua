local meta = FindMetaTable("Player")

if SERVER then
	function meta:SetXP(amt)
		self:SetNW2Int("XP", amt)
	end

	function meta:AddXP(amt)
		self:SetXP(self:GetNW2Int("XP", 0) + amt)
	end

	function meta:SetLevel(lvl)
		self:SetNW2Int("Level", amt)
	end

	function meta:AddLevel(lvl)
		self:SetLevel(self:GetNW2Int("Level", 0) + lvl)
	end
end

function meta:GetXP()
	return self:GetNW2Int("XP", 0)
end

function meta:GetLevel()
	return self:GetNW2Int("Level", 0)
end

