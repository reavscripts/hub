if not game:IsLoaded() then
    game.Loaded:Wait()
end
local Players = game:GetService("Players")
local StarterGui = game:GetService("StarterGui")
local player = Players.LocalPlayer or Players:GetPropertyChangedSignal("LocalPlayer"):Wait() and Players.LocalPlayer
repeat task.wait() until player and player:FindFirstChild("PlayerGui")
if getgenv().reavscripts then
    local infoGui = Instance.new("ScreenGui")
    infoGui.Name = "ReavAlreadyRunning"
    infoGui.ResetOnSpawn = false
    infoGui.Parent = player:WaitForChild("PlayerGui")

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(0.4, 0, 0.05, 0)
    label.Position = UDim2.new(0.3, 0, 0.4, 0) -- 10% above center
    label.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    label.BackgroundTransparency = 0.2
    label.TextColor3 = Color3.fromRGB(255, 100, 100)
    label.Font = Enum.Font.GothamBold
    label.TextScaled = true
    label.Text = "Reav's Scripts already executed!"
    label.Parent = infoGui

    task.delay(3, function()
        infoGui:Destroy()
    end)

    return
end

getgenv().reavscripts = true
local function waitForSetCore(name)
    local success = false
    repeat
        success = pcall(function()
            StarterGui:SetCore(name, nil)
        end)
        if not success then task.wait() end
    until success
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
	"“The essence of strategy is choosing what not to do.“ - Michael Porter",
	"“One cannot and must not try to erase the past merely because it does not fit the present.“ - Golda Meir",
	"“Patriotism means to stand by the country. It does not mean to stand by the president.“ - Theodore Roosevelt",
	"“Death is something inevitable. When a man has done what he considers to be his duty to his people and his country, he can rest in peace. I believe I have made that effort and that is, therefore, why I will sleep for the eternity.“ - Nelson Mandela",
	"“You have to love a nation that celebrates its independence every July 4, not with a parade of guns, tanks, and soldiers who file by the White House in a show of strength and muscle, but with family picnics where kids throw Frisbees, the potato salad gets iffy, and the flies die from happiness. You may think you have overeaten, but it is patriotism.“ - Erma Bombeck",
	"“Be more concerned with your character than your reputation, because your character is what you really are, while your reputation is merely what others think you are.“ - John Wooden",
	"“Weak people revenge. Strong people forgive. Intelligent People Ignore.“ - Albert Einstein",
	"“A mind is like a parachute. It doesn't work if it is not open.“ - Frank Zappa",
	"“Never be afraid to raise your voice for honesty and truth and compassion against injustice and lying and greed.“ If people all over the world...would do this, it would change the earth. - William Faulkner",
	"“There are three kinds of men. The one that learns by reading. The few who learn by observation. The rest of them have to pee on the electric fence for themselves.“ - Will Rogers",
	"“A strong nation, like a strong person, can afford to be gentle, firm, thoughtful, and restrained. It can afford to extend a helping hand to others. It's a weak nation, like a weak person, that must behave with bluster and boasting and rashness and other signs of insecurity.“ - Jimmy Carter",
	"“The difference between stupidity and genius is that genius has its limits.“ - Albert Einstein",
	"“We the people are the rightful masters of both Congress and the courts, not to overthrow the Constitution but to overthrow the men who pervert the Constitution.“ - Abraham Lincoln",
	"“With or without religion, you would have good people doing good things and evil people doing evil things. But for good people to do evil things, that takes religion.“ - Steven Weinberg",
	"“Human kindness has never weakened the stamina or softened the fiber of a free people. A nation does not have to be cruel to be tough.“ - Franklin D. Roosevelt",
	"“A person who never made a mistake never tried anything new.“ - Albert Einstein",
	"“My mission in life is not merely to survive, but to thrive; and to do so with some passion, some compassion, some humor, and some style.“ - Maya Angelou",
	"“Life is short, break the rules... is often attributed to Mark Twain, and it encourages embracing life fully. The full quote is: Life is short, break the rules, forgive quickly, kiss slowly, love truly, laugh uncontrollably, and never regret anything that made you smile.“ (Goodreads)", 


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
    local utcTime = DateTime.now():ToUniversalTime()
    local dayString = utcTime:ToIsoDate() -- e.g., "2025-04-22"
    local hash = 0
    for i = 1, #dayString do
        hash = (hash * 31 + string.byte(dayString, i)) % #quotes
    end
    return hash + 1
end

pcall(function()
    local quoteIndex = getDailyQuoteIndex()
    StarterGui:SetCore("SendNotification", {
        Title = "💬 Quote of the Day",
        Text = quotes[quoteIndex],
        Duration = 15
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
        [7513130835] = {
            [game.PlaceId] = "https://raw.githubusercontent.com/reavscripts/untitleddrillgame/main/main.lua",  -- Using game.PlaceId directly
            default = "https://raw.githubusercontent.com/reavscripts/untitleddrillgame/main/main.lua"
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
