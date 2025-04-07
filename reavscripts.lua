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

local tweenInfo = TweenInfo.new(2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
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
    StarterGui:SetCore("SendNotification", {
        Title = "Reav'S sCriptS", 
        Text = message,
        Duration = duration or 5, 
    })
end
local function getScriptUrl()

    local scripts = {
        [7074860883] = { 
            [128336380114944] = "https://raw.githubusercontent.com/reavscripts/arise/refs/heads/main/dungeon.lua", 
            default = "https://raw.githubusercontent.com/reavscripts/arise/refs/heads/main/main.lua"
        },
        -- Aggiungi altri giochi qui
        [12345678901234] = {  -- gameid
            [98765432109876] = "",  -- placeid alternativo
            default = "" 
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
