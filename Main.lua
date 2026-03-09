--[[
    JULZ hub | V37 Mobile Ultimate
    Updates: Fixed Piano Link, Mobile Optimized Raycasting, Silent Aim
    Security: Manual Key Entry (Kick on Fail)
]]

local TargetKey = "JULZISTHEBEST"
local DiscordLink = "https://discord.gg/cukP3aqCe"
local IsAuthenticated = false

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

-- 1. MOBILE-READY KEY SYSTEM (KICK ON WRONG KEY)
local function LoadKeySystem()
    local AuthGui = Instance.new("ScreenGui", game:GetService("CoreGui"))
    local MainFrame = Instance.new("Frame", AuthGui)
    MainFrame.Size = UDim2.new(0, 320, 0, 220); MainFrame.Position = UDim2.new(0.5, -160, 0.5, -110); MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
    Instance.new("UICorner", MainFrame)
    
    local Title = Instance.new("TextLabel", MainFrame)
    Title.Text = "JULZ HUB V37"; Title.Size = UDim2.new(1, 0, 0, 50); Title.TextColor3 = Color3.new(1, 1, 1); Title.Font = Enum.Font.GothamBold; Title.BackgroundTransparency = 1

    local Input = Instance.new("TextBox", MainFrame)
    Input.PlaceholderText = "Enter Key..."; Input.Size = UDim2.new(0.85, 0, 0, 50); Input.Position = UDim2.new(0.075, 0, 0.35, 0); Input.BackgroundColor3 = Color3.fromRGB(30, 30, 30); Input.TextColor3 = Color3.new(1, 1, 1)
    Instance.new("UICorner", Input)

    local Submit = Instance.new("TextButton", MainFrame)
    Submit.Text = "LOG IN"; Submit.Size = UDim2.new(0.85, 0, 0, 45); Submit.Position = UDim2.new(0.075, 0, 0.65, 0); Submit.BackgroundColor3 = Color3.fromRGB(160, 0, 255); Submit.TextColor3 = Color3.new(1, 1, 1); Submit.Font = Enum.Font.GothamBold
    Instance.new("UICorner", Submit)

    Submit.MouseButton1Click:Connect(function()
        if Input.Text == TargetKey then 
            IsAuthenticated = true 
            AuthGui:Destroy() 
        else 
            LocalPlayer:Kick("\n[JULZ HUB]\nInvalid Key.\nDiscord: " .. DiscordLink)
        end
    end)
    repeat task.wait() until IsAuthenticated
end
LoadKeySystem()

-- 2. ENGINE CONFIG
local Config = {
    WalkSpeed = 16, 
    EspEnabled = false, 
    HitboxExpander = false, 
    HitboxSize = 2,
    SilentAim = false, 
    FOV = 150
}

-- 3. MOBILE TELEPORT TOOL (Optimized Tap)
local function GiveTPTool()
    local TPTool = Instance.new("Tool")
    TPTool.Name = "JULZ TP TOOL"
    TPTool.RequiresHandle = false
    TPTool.Parent = LocalPlayer.Backpack

    TPTool.Activated:Connect(function()
        local inputPos = UserInputService:GetMouseLocation()
        local unitRay = Camera:ViewportPointToRay(inputPos.X, inputPos.Y)
        local result = workspace:Raycast(unitRay.Origin, unitRay.Direction * 1000)
        
        if result and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
            LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(result.Position + Vector3.new(0, 3, 0))
        end
    end)
end

-- 4. SILENT AIM (METATABLE HOOK)
local mt = getrawmetatable(game)
local old = mt.__namecall
setreadonly(mt, false)
mt.__namecall = newcclosure(function(self, ...)
    local method = getnamecallmethod()
    if Config.SilentAim and (method == "FindPartOnRayWithIgnoreList" or method == "Raycast") then
        local target = nil
        local dist = Config.FOV
        for _, p in pairs(Players:GetPlayers()) do
            if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                local pos, onScreen = Camera:WorldToViewportPoint(p.Character.HumanoidRootPart.Position)
                if onScreen then
                    local mag = (Vector2.new(pos.X, pos.Y) - Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y/2)).Magnitude
                    if mag < dist then target = p.Character.HumanoidRootPart; dist = mag end
                end
            end
        end
        if target then return target, target.Position, target.Position, target.Material end
    end
    return old(self, ...)
end)
setreadonly(mt, true)

-- 5. INTERFACE (LUNA)
local Luna = loadstring(game:HttpGet("https://raw.githubusercontent.com/Nebula-Softworks/Luna-Interface-Suite/main/source.lua"))()
local Window = Luna:CreateWindow({ Name = "JULZ hub", Subtitle = "V37 Mobile", LoadingEnabled = true })

local Combat = Window:CreateTab({ Name = "Combat", Icon = "shutter_speed" })
local Visuals = Window:CreateTab({ Name = "Visuals", Icon = "visibility" })
local Movement = Window:CreateTab({ Name = "Movement", Icon = "bolt" })
local Extra = Window:CreateTab({ Name = "Scripts", Icon = "auto_awesome" })

-- COMBAT
Combat:CreateToggle({ Name = "Silent Aim", Callback = function(v) Config.SilentAim = v end })
Combat:CreateSlider({ Name = "Silent FOV", Range = {50, 800}, CurrentValue = 150, Callback = function(v) Config.FOV = v end })
Combat:CreateToggle({ Name = "Hitbox Expander", Callback = function(v) Config.HitboxExpander = v end })
Combat:CreateSlider({ Name = "Hitbox Size", Range = {2, 35}, CurrentValue = 2, Callback = function(v) Config.HitboxSize = v end })

-- VISUALS
Visuals:CreateToggle({ Name = "Infinite ESP", Callback = function(v) Config.EspEnabled = v end })
Visuals:CreateButton({ Name = "JJS Shaders", Callback = function() loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-jango-premium-crack-131377"))() end })

-- MOVEMENT
Movement:CreateButton({ Name = "Give Click TP Tool", Callback = function() GiveTPTool() end })
Movement:CreateSlider({ Name = "WalkSpeed", Range = {16, 250}, CurrentValue = 16, Callback = function(v) Config.WalkSpeed = v end })

-- EXTRA (SCRIPTS)
Extra:CreateButton({ Name = "Load TBO Hub (JJS)", Callback = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/cool5013/TBO/main/TBOscript"))() end })
Extra:CreateButton({ Name = "Auto Piano (Targeted Fix)", Callback = function() loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-talentless-crack-75521"))() end })

-- 6. CORE HEARTBEAT
RunService.Heartbeat:Connect(function()
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid.WalkSpeed = Config.WalkSpeed
    end
    if Config.HitboxExpander then
        for _, p in pairs(Players:GetPlayers()) do
            if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                p.Character.HumanoidRootPart.Size = Vector3.new(Config.HitboxSize, Config.HitboxSize, Config.HitboxSize)
                p.Character.HumanoidRootPart.Transparency = 0.8; p.Character.HumanoidRootPart.CanCollide = false
            end
        end
    end
end)

Luna:Notification({ Title = "JULZ hub", Content = "V37 Ready for Mobile!" })
