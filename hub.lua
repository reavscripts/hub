local function getScriptUrl()
    -- Aggiungi qui gli URL degli script in base al PlaceId e GameId
    local scripts = {
        [7074860883] = {  -- Esegui solo se il GameId è uguale a questo
            [128336380114944] = "",  -- Script per il Dungeon
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
        -- Se la situazione è soddisfatta, carica un URL diverso
        -- Ad esempio, aggiungiamo uno script specifico per questa situazione
        showMessage("Special script triggered due to Room_1 and Portal.", 3)
        return "https://raw.githubusercontent.com/reavscripts/arise/refs/heads/main/infernal.lua"
    else
        return "https://raw.githubusercontent.com/reavscripts/arise/refs/heads/main/dungeon.lua"
    end

    -- Restituisci l'URL giusto in base al GameId e PlaceId
    local scriptUrl = scripts[game.GameId]  -- Verifica il GameId
    if scriptUrl then
        return scriptUrl[game.PlaceId] or scriptUrl.default  -- Verifica il PlaceId
    end

    return nil  -- Se non ci sono corrispondenze
end
