local meta = FindMetaTable("Player")

function meta:GiveItem(id, amount, forced)
	if not Inventory.ValidItem(id) then
		ErrorNoHalt("GiveItem was passed an invalid item!")
		return false
	end

	self:GetInventory()
end

function meta:GetInventory()
	return self._Inventory or {}
end

function meta:HasItem(id, amt)
	if not Inventory.ValidItem(id) then
		ErrorNoHalt("Tried to check an invalid item!")
		return 
	end

	if not amt then amt = 1 end
	
	local inv = self:GetInventory()
	if inv[id] >= amt then
		return true
	end
end

if SERVER then
	function meta:SetInventory(tbl)
		if not tbl then
			self._Inventory = {}
		end
	end
end