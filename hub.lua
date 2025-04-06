-- Funzione per mostrare messaggi (può essere una semplice print o un'interfaccia grafica)
local function showMessage(message, duration)
    print(message)  -- Puoi sostituire questa parte con un'interfaccia grafica per i messaggi
    -- Esegui altre operazioni qui per mostrare il messaggio
end

-- Funzione per ottenere il nome del gioco tramite MarketplaceService
local function getGameName()
    local success, name = pcall(function()
        return game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name
    end)
    return success and name or "Failed to fetch game name"
end

-- Funzione per eseguire lo script
local function executeScript(url, gameName)
    if not url then
        showMessage("Script not supported for this game.", 3)
        game.Players.LocalPlayer:Kick("Script not supported in this game.")
        return
    end
    
    showMessage("Loading script for " .. gameName .. "...", 3)
    
    local success, err = pcall(function()
        loadstring(game:HttpGet(url))()  -- Carica ed esegue lo script da URL
    end)
    
    if not success then
        showMessage("Failed to load script. Error: " .. tostring(err), 3)
    end
end

-- Funzione che restituisce l'URL del script giusto in base al PlaceId
local function getScriptUrl()
    -- Aggiungi qui gli URL degli script in base al PlaceId e GameId
    local scripts = {
        [7074860883] = {  -- Esegui solo se il GameId è uguale a questo
            [128336380114944] = "https://raw.githubusercontent.com/reavscripts/arise/refs/heads/main/main.lua",  -- Script per il Dungeon
            default = "https://raw.githubusercontent.com/reavscripts/arise/refs/heads/main/main.lua"  -- Script predefinito
        },
        -- Aggiungi altri giochi qui
        [12345678901234] = {  -- Un altro esempio di gioco
            [98765432109876] = "https://raw.githubusercontent.com/someoneelse/game_script.lua",  -- URL specifico
            default = "https://raw.githubusercontent.com/someoneelse/game_script.lua"  -- URL predefinito
        }
    }

    -- Restituisci l'URL giusto in base al GameId e PlaceId
    local scriptUrl = scripts[game.GameId]  -- Verifica il GameId
    if scriptUrl then
        return scriptUrl[game.PlaceId] or scriptUrl.default  -- Verifica il PlaceId
    end

    return nil  -- Se non ci sono corrispondenze
end

-- Inizializzazione dello script
local function startScript()
    -- Attendi che il gioco sia completamente caricato
    if not game:IsLoaded() then
        showMessage("Waiting for the game to load.", 3)
        game.Loaded:Wait()
    end

    -- Prevenire l'esecuzione multipla dello script
    if getgenv().ScriptExecuted then
        showMessage("Script already executed.", 3)
        return
    end
    getgenv().ScriptExecuted = true

    -- Ottieni il nome del gioco
    local gameName = getGameName()

    -- Ottieni l'URL dello script giusto
    local scriptUrl = getScriptUrl()

    -- Esegui lo script se esiste un URL
    executeScript(scriptUrl, gameName)
end

-- Avvio dello script
startScript()
