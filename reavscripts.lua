local StarterGui = game:GetService("StarterGui")
local Players = game:GetService("Players")

-- Wait until LocalPlayer is fully ready
local player = Players.LocalPlayer or Players:GetPropertyChangedSignal("LocalPlayer"):Wait() and Players.LocalPlayer
repeat task.wait() until player and player:FindFirstChild("PlayerGui")

-- Wait until SetCore is available (safe SetCore call)
local function waitForSetCore(name)
    local success = false
    repeat
        success = pcall(function()
            StarterGui:SetCore(name, nil)
        end)
        if not success then task.wait() end
    until success
end

-- Actual notification logic
waitForSetCore("SendNotification")

local quotes = {
    -- English
    "“The only thing we have to fear is fear itself.” – Franklin D. Roosevelt",
    "“In the middle of every difficulty lies opportunity.” – Albert Einstein",
    -- Italian
    "“Chi ha tempo non aspetti tempo.” – Italian proverb",
    -- French
    "“Il n’est jamais trop tard pour bien faire.” – French proverb",
    -- German
    "“Wer nicht wagt, der nicht gewinnt.” – German saying",
    -- Japanese
    "「七転び八起き」– Fall seven times, stand up eight.",
    -- Arabic
    "«مَن جَدَّ وَجَد» – He who strives, succeeds.",
    -- Spanish
    "“A quien madruga, Dios le ayuda.” – Early bird gets the worm."
}

-- Show random quote
pcall(function()
    StarterGui:SetCore("SendNotification", {
        Title = "💬 Quote of the Day",
        Text = quotes[math.random(1, #quotes)],
        Duration = 8
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
