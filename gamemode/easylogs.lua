AddCSLuaFile()
ELogs = {}

local function sysTime()
	return "["..os.date('%H:%M:%S').."] " 
end

function ELogs.Error(msg)
	MsgC(Color(255, 0, 0), sysTime(), msg)
	MsgN("")
end

function ELogs.Warn(msg)
	MsgC(Color(245, 144, 66), sysTime(), msg)
	MsgN("")
end

function ELogs.Output(msg)
	MsgC(Color(66, 245, 150), sysTime(), msg)
	MsgN("")
end