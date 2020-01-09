local meta = FindMetaTable("Player")

if SERVER then
	function meta:SetXP(amt)
		self:SetNW2Int("XP", amt)
	end

	function meta:AddXP(amt)
		self:SetXP(self:GetXP() + amt)
		
		if self:GetXP() >= self:XPToLevelUp() then
			self:AddLevel(1)
			self:SetXP(self:GetXP() - self:XPToLevelUp())

			if self:GetXP() < 0 then self:SetXP(0) end //just incase :)
		end
	end

	function meta:SetLevel(lvl)
		self:SetNW2Int("Level", amt)
	end

	function meta:AddLevel(lvl)
		self:SetLevel(self:GetLevel() + lvl)
	end
end

function meta:XPToLevelUp()
	return (math.pow(1.25, self:GetLevel() - 1)) * 800
end

function meta:GetXP()
	return self:GetNW2Int("XP", 0)
end

function meta:GetLevel()
	return self:GetNW2Int("Level", 1)
end

