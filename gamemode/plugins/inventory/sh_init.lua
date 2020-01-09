Inventory = {}
Inventory.Items = {}
Inventory.Categories = {}

function Inventory.ValidItem(item_id)
	return Inventory.Items[item_id] != nil
end

/*
	Register a new item
	index is usually the same as the file name - must be lowercase with no spaces (underscores allowed)
	data is the ITEM table declared in the file
*/
function Inventory.RegisterItem(index, data)
	if not data.name then
		ErrorNoHalt("Tried to register an item without an item name!")
	end

	Inventory.Items[index] = data
end

function Inventory.GetItem(id)
	if(Inventory.Items[id]) then 
		return table.Copy(Inventory.Items[id])
	else
		return nil
	end
end

function Inventory.GetItems()
	return table.Copy(Inventory.Items)
end

function Inventory.GetCategories()
	return table.Copy(Inventory.Categories)
end

if SERVER then
	function Inventory.LoadItems()
		local fileStr = "starwars-roleplay/gamemode/items/"

		local _, categories = file.Find("starwars-roleplay/gamemode/items/*", "LUA")

		for k, category in pairs(categories) do
			local files, _ = file.Find(fileStr..category.."/*.lua", "LUA")
			
			for i, file in pairs(files) do
				include(fileStr..category.."/"..file)
				AddCSLuaFile(fileStr..category.."/"..file)
			end
		end
	end
	hook.Add("Initialize", "loadInventoryItems", Inventory.LoadItems)

	function Inventory.LoadPlayerInv(ply)

	end
	hook.Add("PlayerInitialSpawn", "loadPlayerInv", loadPlayerInv)
end