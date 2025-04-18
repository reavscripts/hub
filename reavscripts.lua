if not game:IsLoaded() then
    game.Loaded:Wait()
end
local Players = game:GetService("Players")
local StarterGui = game:GetService("StarterGui")
local player = Players.LocalPlayer or Players:GetPropertyChangedSignal("LocalPlayer"):Wait() and Players.LocalPlayer
repeat task.wait() until player and player:FindFirstChild("PlayerGui")
local function getDailyQuoteIndex()
    local currentTime = DateTime.now()
    local cetTime = DateTime.fromUnixTimestamp(currentTime.UnixTimestamp + 3600)
    local dayString = cetTime:ToIsoDate()
    local hash = 0
    for i = 1, #dayString do
        hash = (hash * 31 + string.byte(dayString, i)) % #quotes
    end
    return hash + 1
end
waitForSetCore("SendNotification")
-- Quotes
local quotes = {
    -- English
    "“The only thing we have to fear is fear itself.” – Franklin D. Roosevelt",
    "“Success is not final, failure is not fatal: It is the courage to continue that counts.” – Winston Churchill",
    "“Life is what happens when you're busy making other plans.” – John Lennon",
    "“Be yourself; everyone else is already taken.” – Oscar Wilde",
    "“In the middle of every difficulty lies opportunity.” – Albert Einstein",
    "“You miss 100% of the shots you don’t take.” – Wayne Gretzky",
    "“The best way to predict the future is to invent it.” – Alan Kay",
    "“Do not go where the path may lead, go instead where there is no path and leave a trail.” – Ralph Waldo Emerson",
    "“It does not matter how slowly you go as long as you do not stop.” – Confucius",

    -- Italian
    "“Chi ha tempo non aspetti tempo.” – Proverbio italiano",
    "“L’essenziale è invisibile agli occhi.” – Antoine de Saint-Exupéry",
    "“Vivere è la cosa più rara al mondo. La maggior parte della gente esiste, e nulla più.” – Oscar Wilde",

    -- French
    "“Liberté, égalité, fraternité.” – Maximilien Robespierre",
    "“Je pense, donc je suis.” – René Descartes",
    "“Il n’y a qu’un bonheur dans la vie, c’est d’aimer et d’être aimé.” – George Sand",

    -- Spanish
    "“La vida es sueño.” – Pedro Calderón de la Barca",
    "“En un lugar de la Mancha, de cuyo nombre no quiero acordarme...” – Miguel de Cervantes",
    "“Caminante, no hay camino, se hace camino al andar.” – Antonio Machado",

    -- German
    "“Was mich nicht umbringt, macht mich stärker.” – Friedrich Nietzsche",
    "“Zwei Dinge sind unendlich, das Universum und die menschliche Dummheit.” – Albert Einstein",
    "“Im Anfang war die Tat.” – Johann Wolfgang von Goethe",

    -- Japanese
    "「七転び八起き」– Proverb (Fall seven times, stand up eight)",
    "「己を知り、敵を知れば百戦危うからず。」– Sun Tzu",
    "「明日は明日の風が吹く。」– Japanese proverb (Tomorrow's wind will blow tomorrow)",

    -- Latin
    "“Veni, vidi, vici.” – Julius Caesar",
    "“Carpe diem.” – Horace",
    "“Amor vincit omnia.” – Virgil",

    -- Chinese
    "“千里之行，始於足下。” – Laozi",
    "“知人者智，自知者明。” – Laozi",
    "“学而不思则罔，思而不学则殆。” – Confucius"
}

local function getDailyQuoteIndex()
    local currentTime = DateTime.now()
    -- Adjust for CET (Central European Time)
    local cetTime = currentTime:AddHours(1)  
    local dayString = cetTime:ToIsoDate() 
    local hash = 0
    for i = 1, #dayString do
        hash = (hash * 31 + string.byte(dayString, i)) % #quotes
    end
    return hash + 1  -- Ensure the result is between 1 and #quotes
end

pcall(function()
    local quoteIndex = getDailyQuoteIndex() 
    StarterGui:SetCore("SendNotification", {
        Title = "💬 Quote of the Day",
        Text = quotes[quoteIndex],
        Duration = 10
    })
end)

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
    task.delay(2.5, function()
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
