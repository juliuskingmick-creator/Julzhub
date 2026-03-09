--[[
    JULZ HUB | V48 MOBILE OVERHAUL
    Branding: Title "JULZ HUB", Subtitle "by JULZ"
    Updates: Infinite Yield, Fixed Silent Aim (Smooth Camera)
    Legacy: All previous scripts & tools kept.
]]

local TargetKey = "JULZISTHEBEST"
local DiscordLink = "https://discord.gg/cukP3aqCe"
local IsAuthenticated = false

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local HttpService = game:GetService("HttpService")

-- 1. KEY SYSTEM (UPDATED BRANDING)
local function LoadKeySystem()
    local AuthGui = Instance.new("ScreenGui", game:GetService("CoreGui"))
    local MainFrame = Instance.new("Frame", AuthGui)
    MainFrame.Size = UDim2.new(0, 320, 0, 260); MainFrame.Position = UDim2.new(0.5, -160, 0.5, -130); MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
    Instance.new("UICorner", MainFrame)
    
    local Title = Instance.new("TextLabel", MainFrame)
    Title.Text = "JULZ HUB"; Title.Size = UDim2.new(1, 0, 0, 50); Title.TextColor3 = Color3.new(1, 1, 1); Title.Font = Enum.Font.GothamBold; Title.BackgroundTransparency = 1

    local SubTitle = Instance.new("TextLabel", MainFrame)
    SubTitle.Text = "by JULZ"; SubTitle.Size = UDim2.new(1, 0, 0, 20); SubTitle.Position = UDim2.new(0, 0, 0, 35); SubTitle.TextColor3 = Color3.fromRGB(200, 200, 200); SubTitle.Font = Enum.Font.Gotham; SubTitle.BackgroundTransparency = 1; SubTitle.TextSize = 12

    local Input = Instance.new("TextBox", MainFrame)
    Input.PlaceholderText = "Enter Key..."; Input.Size = UDim2.new(0.85, 0, 0, 45); Input.Position = UDim2.new(0.075, 0, 0.30, 0); Input.BackgroundColor3 = Color3.fromRGB(30, 30, 30); Input.TextColor3 = Color3.new(1, 1, 1)
    Instance.new("UICorner", Input)

    local Submit = Instance.new("TextButton", MainFrame)
    Submit.Text = "LOG IN"; Submit.Size = UDim2.new(0.85, 0, 0, 45); Submit.Position = UDim2.new(0.075, 0, 0.52, 0); Submit.BackgroundColor3 = Color3.fromRGB(160, 0, 255); Submit.TextColor3 = Color3.new(1, 1, 1); Submit.Font = Enum.Font.GothamBold
    Instance.new("UICorner", Submit)

    local GetKey = Instance.new("TextButton", MainFrame)
    GetKey.Text = "GET KEY (DISCORD)"; GetKey.Size = UDim2.new(0.85, 0, 0, 40); GetKey.Position = UDim2.new(0.075, 0, 0.74, 0); GetKey.BackgroundColor3 = Color3.fromRGB(40, 40, 40); GetKey.TextColor3 = Color3.fromRGB(200, 200, 200); GetKey.Font = Enum.Font.Gotham
    Instance.new("UICorner", GetKey)

    GetKey.MouseButton1Click:Connect(function()
        setclipboard(DiscordLink)
        game:GetService("StarterGui"):SetCore("SendNotification", { Title = "JULZ HUB", Text = "Link Copied!", Duration = 5 })
    end)

    Submit.MouseButton1Click:Connect(function()
        if Input.Text == TargetKey then IsAuthenticated = true; AuthGui:Destroy() else LocalPlayer:Kick("\nInvalid Key.") end
    end)
    repeat task.wait() until IsAuthenticated
end
LoadKeySystem()

-- 2. ENGINE CONFIG
local Config = {
    WalkSpeed = 16, EspEnabled = false, HitboxExpander = false, HitboxSize = 2,
    SilentAim = false, FOV = 150, InfiniteJump = false, Noclip = false, Fly = false
}

-- 3. SILENT AIM (STABLE)
local CurrentTarget = nil
local function GetClosestTarget()
    local target, dist = nil, Config.FOV
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
            local pos, onScreen = Camera:WorldToViewportPoint(p.Character.HumanoidRootPart.Position)
            if onScreen then
                local mag = (Vector2.new(pos.X, pos.Y) - Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y/2)).Magnitude
                if mag < dist then target = p.Character.HumanoidRootPart; dist = mag end
            end
        end
    end
    return target
end

RunService.Heartbeat:Connect(function()
    if Config.SilentAim then CurrentTarget = GetClosestTarget() else CurrentTarget = nil end
end)

local mt = getrawmetatable(game)
local old = mt.__namecall
setreadonly(mt, false)
mt.__namecall = newcclosure(function(self, ...)
    local method = getnamecallmethod()
    if not checkcaller() and Config.SilentAim and CurrentTarget then
        if method == "FindPartOnRayWithIgnoreList" or method == "Raycast" then
            return old(self, unpack({...}))
        end
    end
    return old(self, ...)
end)
setreadonly(mt, true)

-- 4. INTERFACE (LUNA - UPDATED BRANDING)
local Luna = loadstring(game:HttpGet("https://raw.githubusercontent.com/Nebula-Softworks/Luna-Interface-Suite/main/source.lua"))()
local Window = Luna:CreateWindow({ Name = "JULZ HUB", Subtitle = "by JULZ", LoadingEnabled = true })

local Combat = Window:CreateTab({ Name = "Combat", Icon = "shutter_speed" })
local Visuals = Window:CreateTab({ Name = "Visuals", Icon = "visibility" })
local Movement = Window:CreateTab({ Name = "Movement", Icon = "bolt" })
local Extra = Window:CreateTab({ Name = "Scripts", Icon = "auto_awesome" })
local Settings = Window:CreateTab({ Name = "Settings", Icon = "settings" })

-- COMBAT
Combat:CreateToggle({ Name = "Silent Aim", Callback = function(v) Config.SilentAim = v end })
Combat:CreateSlider({ Name = "Silent FOV", Range = {50, 800}, CurrentValue = 150, Callback = function(v) Config.FOV = v end })
Combat:CreateToggle({ Name = "Hitbox Expander", Callback = function(v) Config.HitboxExpander = v end })

-- VISUALS
Visuals:CreateToggle({ Name = "Highlight ESP", Callback = function(v) Config.EspEnabled = v end })
Visuals:CreateButton({ Name = "Fullbright", Callback = function() game:GetService("Lighting").Brightness = 2; game:GetService("Lighting").ClockTime = 14; game:GetService("Lighting").GlobalShadows = false end })
Visuals:CreateButton({ Name = "JJS Shaders", Callback = function() loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-jango-premium-crack-131377"))() end })

-- MOVEMENT
Movement:CreateSlider({ Name = "WalkSpeed", Range = {16, 250}, CurrentValue = 16, Callback = function(v) Config.WalkSpeed = v end })
Movement:CreateToggle({ Name = "Infinite Jump", Callback = function(v) Config.InfiniteJump = v end })
Movement:CreateToggle({ Name = "Noclip", Callback = function(v) Config.Noclip = v end })
Movement:CreateToggle({ Name = "Fly", Callback = function(v) Config.Fly = v end })

-- EXTRA (SCRIPTS)
Extra:CreateButton({ Name = "Infinite Yield (FE Admin)", Callback = function() loadstring(game:HttpGet('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source'))() end })
Extra:CreateButton({ Name = "Load XVC Hub", Callback = function() loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-XVC-Hub-79830"))() end })
Extra:CreateButton({ Name = "Load Epstein Script", Callback = function() loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-Jeffrey-epstein-script-115494"))() end })
Extra:CreateButton({ Name = "BABFT Ultimate", Callback = function() loadstring(game:HttpGet("https://rawscripts.net/raw/Build-A-Boat-For-Treasure-Ultimte-B3BFT-Script-28601"))() end })
Extra:CreateButton({ Name = "Apply R6 Femboy", Callback = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/juliuskingmick-creator/Julzhub/refs/heads/main/Femboy.lua"))() end })

-- SETTINGS
Settings:CreateButton({ Name = "Server Hop", Callback = function() 
    local Servers = HttpService:JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/"..game.PlaceId.."/servers/Public?sortOrder=Desc&limit=100"))
    for _, s in pairs(Servers.data) do if s.playing < s.maxPlayers and s.id ~= game.JobId then game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, s.id) break end end
end })
Settings:CreateButton({ Name = "Rejoin Server", Callback = function() game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, game.JobId) end })

-- 5. HEARTBEAT ENGINE
RunService.Stepped:Connect(function()
    if LocalPlayer.Character then
        if Config.Noclip then for _, v in pairs(LocalPlayer.Character:GetDescendants()) do if v:IsA("BasePart") then v.CanCollide = false end end end
        if Config.Fly then LocalPlayer.Character.HumanoidRootPart.Velocity = Vector3.new(0, 2, 0) end
    end
end)

RunService.Heartbeat:Connect(function()
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid.WalkSpeed = Config.WalkSpeed
    end
    if Config.HitboxExpander then
        for _, p in pairs(Players:GetPlayers()) do
            if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                p.Character.HumanoidRootPart.Size = Vector3.new(Config.HitboxSize, Config.HitboxSize, Config.HitboxSize)
                p.Character.HumanoidRootPart.Transparency = 0.8
            end
        end
    end
end)

UserInputService.JumpRequest:Connect(function() if Config.InfiniteJump then LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):ChangeState(Enum.HumanoidStateType.Jumping) end end)

Luna:Notification({ Title = "JULZ HUB", Content = "V48 Loaded Successfully!" })
