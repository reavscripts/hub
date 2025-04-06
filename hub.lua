if not game:IsLoaded() then
    showMessage("Waiting for the game to load.", 3)
    game.Loaded:Wait()
end

if getgenv().ScriptExecuted then
    showMessage("Script already executed.", 3)
    return
end
getgenv().ScriptExecuted = true

local Game = game.GameId
local Place = game.PlaceId

local function getGameName()
    local success, name = pcall(function()
        return game:GetService("MarketplaceService"):GetProductInfo(Place).Name
    end)
    return success and name or "Failed to fetch game name"
end

local function executeScript(url, gameName)
    if not url then
        showMessage("Script not supported for this game.", 3)
        game.Players.LocalPlayer:Kick("Script not supported in this game.")
        return
    end
    
    showMessage("Loading script for " .. gameName .. "...", 3)
    local success, err = pcall(function()
        loadstring(game:HttpGet(url))()
    end)
    
    if not success then
        showMessage("Failed to load script. Please try again later.\nError: " .. tostring(err), 3)
        getgenv().ScriptExecuted = false
    end
end

local scripts = {
    [87039211657390] = {
        [128336380114944] = "https://raw.githubusercontent.com/reavscripts/arise/refs/heads/main/main.lua",
        default = "https://raw.githubusercontent.com/reavscripts/arise/refs/heads/main/main.lua"
    }
}

local scriptUrl = scripts[Game] 
if type(scriptUrl) == "table" then
    scriptUrl = scriptUrl[Place] or scriptUrl.default
end
scriptUrl = scriptUrl or scripts[Place]

executeScript(scriptUrl, getGameName())
