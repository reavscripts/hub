local quotes = {
    -- English
    "“The only thing we have to fear is fear itself.” – English",
    "“In the middle of every difficulty lies opportunity.” – English",
    "“Do not go where the path may lead, go instead where there is no path and leave a trail.” – English",
    "“Life is what happens when you're busy making other plans.” – English",
    "“Success is not final, failure is not fatal: It is the courage to continue that counts.” – English",
    "“Be yourself; everyone else is already taken.” – English",
    "“The best way to predict the future is to invent it.” – English",
    "“You miss 100% of the shots you don’t take.” – English",

    -- Italian
    "“Chi dorme non piglia pesci.” – Italian", -- He who sleeps catches no fish
    "“La calma è la virtù dei forti.” – Italian", -- Calm is the virtue of the strong
    "“Il tempo è galantuomo.” – Italian", -- Time is a gentleman

    -- Spanish
    "“El que madruga, Dios lo ayuda.” – Spanish", -- The early bird gets the worm
    "“No hay mal que por bien no venga.” – Spanish", -- Every cloud has a silver lining
    "“A mal tiempo, buena cara.” – Spanish", -- Put on a brave face in hard times

    -- French
    "“Je pense, donc je suis.” – French", -- I think, therefore I am
    "“Il n'y a pas de fumée sans feu.” – French", -- No smoke without fire
    "“Petit à petit, l’oiseau fait son nid.” – French", -- Little by little, the bird builds its nest

    -- German
    "“Was du heute kannst besorgen, das verschiebe nicht auf morgen.” – German", -- Don't put off until tomorrow what you can do today
    "“Übung macht den Meister.” – German", -- Practice makes perfect

    -- Japanese (romanized)
    "“Nana korobi ya oki.” – Japanese", -- Fall seven times, stand up eight
    "“Ichi-go ichi-e.” – Japanese", -- One time, one meeting (cherish every encounter)

    -- Chinese (romanized)
    "“Luòhuā liúshuǐ, zìrán chéngqù.” – Chinese", -- Falling flowers, flowing water — things happen naturally
    "“Yǒuzhì zhě shì jìng chéng.” – Chinese", -- Where there is a will, there is a way
}

local function sendNotification()
    pcall(function()
        game.StarterGui:SetCore("SendNotification", {
            Title = "💬 Quote of the Day",
            Text = quotes[math.random(1, #quotes)],
            Duration = 8
        })
    end)
end

task.wait(5)
sendNotification()
local StarterGui = game:GetService("StarterGui")
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local player = Players.LocalPlayer

local IMAGE_ID = "rbxassetid://104873171443907"
local FINAL_SIZE = UDim2.new(0, 400, 0, 400)

local introGui = Instance.new("ScreenGui")
introGui.Name = "IntroGui"
introGui.IgnoreGuiInset = true
introGui.ResetOnSpawn = false
introGui.Parent = player:WaitForChild("PlayerGui")

local image = Instance.new("ImageLabel")
image.Name = "IntroImage"
image.AnchorPoint = Vector2.new(0.5, 0.5)
image.Position = UDim2.new(0.5, 0, 0.5, -50)
image.Size = UDim2.new(0, 50, 0, 50) -- Inizia piccola
image.BackgroundTransparency = 1
image.Image = IMAGE_ID
image.Parent = introGui

local label = Instance.new("TextLabel")
label.AnchorPoint = Vector2.new(0.5, 0)
label.Position = UDim2.new(0.5, 0, 0.5, 170)
label.Size = UDim2.new(0, 400, 0, 50)
label.BackgroundTransparency = 1
label.Text = "Reav'S sCriptS"
label.TextColor3 = Color3.fromRGB(255, 255, 255)
label.TextStrokeTransparency = 0.5
label.TextStrokeColor3 = Color3.new(0, 0, 0)
label.TextSize = 72
label.Font = Enum.Font.LuckiestGuy
label.TextTransparency = 1 -- Inizio invisibile
label.Parent = introGui

local tweenInfo = TweenInfo.new(.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local tween = TweenService:Create(image, tweenInfo, {Size = FINAL_SIZE})
tween:Play()


tween.Completed:Connect(function()
    local labelTween = TweenService:Create(label, TweenInfo.new(1), {TextTransparency = 0})
    labelTween:Play()
    task.delay(3, function()
        introGui:Destroy()
    end)
end)

local function showMessage(message, duration)

end


local function getScriptUrl()

    local scripts = {
        [7074860883] = { 
            [128336380114944] = "https://raw.githubusercontent.com/reavscripts/arise/refs/heads/main/dungeon.lua", 
			[116614712661486] = "https://raw.githubusercontent.com/reavscripts/arise/refs/heads/main/afk.lua",
            default = "https://raw.githubusercontent.com/reavscripts/arise/refs/heads/main/main.lua"
        },
        -- Aggiungi altri giochi qui
        [12345678901234] = {  -- gameid
            [98765432109876] = "",  -- placeid alternativo
            default = "" 
        }
    }
	
	local room1
	local main = workspace:FindFirstChild("__Main")
	if main then
		local world = main:FindFirstChild("__World")
		if world then
			room1 = world:FindFirstChild("Room_1")
		end
	end

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
