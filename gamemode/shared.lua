AddCSLuaFile()
DeriveGamemode("sandbox")

SWRP = {}

timer.Create("eachTenthSecond", 0.1, 0, function() hook.Run("eachTenthSecond") end)
timer.Create("eachSecond", 1, 0, function() hook.Run("eachSecond") end)
timer.Create("eachMinute", 60, 0, function() hook.Run("eachMinute") end)