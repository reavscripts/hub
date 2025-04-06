
local function showMessage(message, duration)
    local gui = Instance.new("ScreenGui")
    gui.Name = "MessageGui"
    gui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

    local textLabel = Instance.new("TextLabel")
    textLabel.Size = UDim2.new(0, 400, 0, 50)
    textLabel.Position = UDim2.new(0.5, -200, 0.5, -25)
    textLabel.Text = message
    textLabel.TextSize = 20
    textLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    textLabel.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    textLabel.BackgroundTransparency = 0.5
    textLabel.Parent = gui

    wait(duration)
    gui:Destroy()
end

local function getScriptUrl()

    local scripts = {
        [7074860883] = {  -- Esegui solo se il GameId è uguale a questo
            [128336380114944] = "https://raw.githubusercontent.com/reavscripts/arise/refs/heads/main/dungeon.lua",  -- Script per il Dungeon
            default = "https://raw.githubusercontent.com/reavscripts/arise/refs/heads/main/main.lua"  -- Script predefinito
        },
        -- Aggiungi altri giochi qui
        [12345678901234] = {  -- Un altro esempio di gioco
            [98765432109876] = "https://raw.githubusercontent.com/someoneelse/game_script.lua",  -- URL specifico
            default = "https://raw.githubusercontent.com/someoneelse/game_script.lua"  -- URL predefinito
        }
    }

    local room1 = workspace:FindFirstChild("__Main") and workspace.__Main.__World:FindFirstChild("Room_1")

    if room1 and room1:FindFirstChild("Portal") then
        showMessage("Special script triggered due to Room_1 and Portal.", 3)
        return "https://raw.githubusercontent.com/reavscripts/arise/refs/heads/main/infernal.lua"
    end

    local scriptUrl = scripts[game.GameId]
    if scriptUrl then
        return scriptUrl[game.PlaceId] or scriptUrl.default 
    end

    return nil 
end

local function executeScript()
    local scriptUrl = getScriptUrl()

    if scriptUrl then
        showMessage("Loading script from: " .. scriptUrl, 3)
        local success, err = pcall(function()
            loadstring(game:HttpGet(scriptUrl))()
        end)

        if not success then
            showMessage("Failed to load script. Error: " .. err, 3)
        end
    else
        showMessage("No valid script found for this game/Place.", 3)
    end
end

executeScript()
