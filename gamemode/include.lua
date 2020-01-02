AddCSLuaFile()
include("easylogs.lua")
include("shared.lua")
include("config.lua")

if SERVER then
	include("mysql.lua")
end

local folder_name = "starwars-roleplay"

local function addShared(File)
	include(File)
	if SERVER then
		AddCSLuaFile(File)
	end
end

local function addClient(File)
	if CLIENT then
		include(File)
	else
		AddCSLuaFile(File)
	end
end

local function addServer(file)
	if SERVER then
		include(file)
	end
end

local function loader(file, dir)
	type = string.sub(file, 1, 2)

	if type == "sh" then
		include(dir..file)
		if SERVER then
		AddCSLuaFile(dir..file)
		end
	elseif type == "sv" then
		if SERVER then
			include(dir..file)
		end
	else
		if CLIENT then
			include(dir..file)
		else
			AddCSLuaFile(dir..file)
		end
	end
end

do
	local files, folders = file.Find(folder_name.."/gamemode/metatables/*.lua", "LUA")

	local type
	for k, v in pairs(files) do
		loader(v, "metatables/")
	end
end

do
	local _, folders = file.Find(folder_name.."/gamemode/plugins/*", "LUA")

	for k, dir in pairs(folders) do
		local files, _ = file.Find(folder_name.."/gamemode/plugins/"..dir.."/*.lua", "LUA")

		for k, v in pairs(files) do
			loader(v, "plugins/"..dir.."/")
		end
	end

	ELogs.Output("Loaded "..#folders.." plugins!")
end

//Load serverside lua files
do
	ELogs.Output("Loading serverside lua content...")
	local files, dir = file.Find(folder_name.."/gamemode/server/*.lua", "LUA")

	if not(files) then 
		ELogs.Error("Server folder is missing!") 
		return s
	end

	for i = 1, #files do
		addServer(files[i])
	end

	ELogs.Output("Loaded ".. #files.." serverside files")
end

do
	ELogs.Output("Loading shared lua content...")

	local files, dir = file.Find(folder_name.."/gamemode/shared/*.lua", "LUA")
	if not(files) then 
		ELogs.Error("Shared folder is missing!") 
		return 
	end

	for i = 1, #files do
		addShared(files[i])
	end

	ELogs.Output("Loaded ".. #files.." shared files")
end

do
	ELogs.Output("Loading clientside lua content...")

	local files, dir = file.Find(folder_name.."/gamemode/client/*.lua", "LUA")
	if not(files) then 
		ELogs.Error("Client folder is missing!") 
		return 
	end

	for i = 1, #files do
		addClient(files[i])
	end

	ELogs.Output("Loaded ".. #files.." clientside files")
end