-- Funzione per mostrare i messaggi (se non l'hai già definita)
local function showMessage(message, duration)
    -- Mostra il messaggio all'utente per una durata specificata (in secondi)
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

    -- Rimuovi il messaggio dopo la durata specificata
    wait(duration)
    gui:Destroy()
end

local function getScriptUrl()
    -- Aggiungi qui gli URL degli script in base al PlaceId e GameId
    local scripts = {
        [7074860883] = {  -- Esegui solo se il GameId è uguale a questo
            [128336380114944] = "https://raw.githubusercontent.com/reavscripts/arise/refs/heads/main/dungeon.lua",  -- Script per il Dungeon
            default = "https://raw.githubusercontent.com/reavscripts/arise/refs/heads/main/default.lua"  -- Script predefinito
        },
        -- Aggiungi altri giochi qui
        [12345678901234] = {  -- Un altro esempio di gioco
            [98765432109876] = "https://raw.githubusercontent.com/someoneelse/game_script.lua",  -- URL specifico
            default = "https://raw.githubusercontent.com/someoneelse/game_script.lua"  -- URL predefinito
        }
    }

    -- Controllo per la determinata situazione (Room_1 con un Portal)
    local room1 = workspace:FindFirstChild("__Main") and workspace.__Main.__World:FindFirstChild("Room_1")

    if room1 and room1:FindFirstChild("Portal") then
        -- Se la situazione è soddisfatta, carica un URL speciale
        showMessage("Special script triggered due to Room_1 and Portal.", 3)
        return "https://raw.githubusercontent.com/reavscripts/arise/refs/heads/main/infernal.lua"
    end

    -- Restituisci l'URL giusto in base al GameId e PlaceId
    local scriptUrl = scripts[game.GameId]  -- Verifica il GameId
    if scriptUrl then
        return scriptUrl[game.PlaceId] or scriptUrl.default  -- Verifica il PlaceId
    end

    return nil  -- Se non ci sono corrispondenze
end

-- Funzione principale per eseguire lo script
local function executeScript()
    local scriptUrl = getScriptUrl()  -- Ottieni l'URL dello script

    if scriptUrl then
        showMessage("Loading script from: " .. scriptUrl, 3)
        -- Esegui lo script usando loadstring e HttpGet
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

-- Avvia l'esecuzione dello script
executeScript()
