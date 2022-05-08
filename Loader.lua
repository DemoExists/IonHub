local Games = {}

local GameId = game.GameId

if Games[GameId] then
    Game = Games[GameId]
else
    Game = "Universal"
end

loadstring(game:HttpGet(("https://raw.githubusercontent.com/tatar0071/IonHub/main/Games/%s.lua"):format(Game)))()
