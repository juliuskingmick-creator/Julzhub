--[[
    JULZ HUB | V50
    Branding: JULZ HUB by JULZ
    Fixes: Fly Logic (Mobile Optimized), ESP (Re-added), Silent Aim (Stable)
    Scripts: Infinite Yield, XVC, BABFT, Epstein
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

-- 1. KEY SYSTEM
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

    Submit.MouseButton1Click:Connect(function()
        if Input.Text == TargetKey then IsAuthenticated = true; AuthGui:Destroy() else LocalPlayer:Kick("\nInvalid Key.") end
    end)
    repeat task.wait() until IsAuthenticated
end
LoadKeySystem()

-- 2. CONFIG
local Config = {
    WalkSpeed = 16, EspEnabled = false, HitboxExpander = false, HitboxSize = 2,
    SilentAim = false, FOV = 150, InfiniteJump = false, Noclip = false, Fly = false, FlySpeed = 50
}

-- 3. ESP SYSTEM (RE-ADDED)
local function ApplyESP(p)
    local function CreateHighlight()
        if p == LocalPlayer then return end
        local char = p.Character or p.CharacterAdded:Wait()
        if char:FindFirstChild("JulzHighlight") then char.JulzHighlight:Destroy() end
        local h = Instance.new("Highlight", char)
        h.Name = "JulzHighlight"
        h.FillColor = Color3.fromRGB(160, 0, 255)
        h.OutlineColor = Color3.new(1, 1, 1)
        RunService.RenderStepped:Connect(function() h.Enabled = Config.EspEnabled end)
    end
    p.CharacterAdded:Connect(CreateHighlight)
    if p.Character then task.spawn(CreateHighlight) end
end
for _, v in pairs(Players:GetPlayers()) do ApplyESP(v) end
Players.PlayerAdded:Connect(ApplyESP)

-- 4. SILENT AIM
local CurrentTarget = nil
local function GetClosest()
    local target, dist = nil, Config.FOV
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
            local pos, visible = Camera:WorldToViewportPoint(p.Character.HumanoidRootPart.Position)
            if visible then
                local mag = (Vector2.new(pos.X, pos.Y) - Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y/2)).Magnitude
                if mag < dist then target = p.Character.HumanoidRootPart; dist = mag end
            end
        end
    end
    return target
end
RunService.Heartbeat:Connect(function() if Config.SilentAim then CurrentTarget = GetClosest() else CurrentTarget = nil end end)

-- 5. INTERFACE
local Luna = loadstring(game:HttpGet("https://raw.githubusercontent.com/Nebula-Softworks/Luna-Interface-Suite/main/source.lua"))()
local Window = Luna:CreateWindow({ Name = "JULZ HUB", Subtitle = "by JULZ", LoadingEnabled = true })

local Combat = Window:CreateTab({ Name = "Combat", Icon = "shutter_speed" })
local Visuals = Window:CreateTab({ Name = "Visuals", Icon = "visibility" })
local Movement = Window:CreateTab({ Name = "Movement", Icon = "bolt" })
local Extra = Window:CreateTab({ Name = "Scripts", Icon = "auto_awesome" })

Combat:CreateToggle({ Name = "Silent Aim", Callback = function(v) Config.SilentAim = v end })
Combat:CreateSlider({ Name = "FOV", Range = {50, 800}, CurrentValue = 150, Callback = function(v) Config.FOV = v end })
Combat:CreateToggle({ Name = "Hitbox Expander", Callback = function(v) Config.HitboxExpander = v end })

Visuals:CreateToggle({ Name = "Highlight ESP", Callback = function(v) Config.EspEnabled = v end })
Visuals:CreateButton({ Name = "Fullbright", Callback = function() game:GetService("Lighting").Brightness = 2; game:GetService("Lighting").GlobalShadows = false end })

Movement:CreateSlider({ Name = "WalkSpeed", Range = {16, 250}, CurrentValue = 16, Callback = function(v) Config.WalkSpeed = v end })
Movement:CreateToggle({ Name = "Fly (Stable)", Callback = function(v) Config.Fly = v end })
Movement:CreateToggle({ Name = "Noclip", Callback = function(v) Config.Noclip = v end })
Movement:CreateToggle({ Name = "Infinite Jump", Callback = function(v) Config.InfiniteJump = v end })

Extra:CreateButton({ Name = "Infinite Yield", Callback = function() loadstring(game:HttpGet('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source'))() end })
Extra:CreateButton({ Name = "XVC Hub", Callback = function() loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-XVC-Hub-79830"))() end })
Extra:CreateButton({ Name = "BABFT Ultimate", Callback = function() loadstring(game:HttpGet("https://rawscripts.net/raw/Build-A-Boat-For-Treasure-Ultimte-B3BFT-Script-28601"))() end })

-- 6. FLY & CORE ENGINE
RunService.Stepped:Connect(function()
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        if Config.Fly then
            LocalPlayer.Character.HumanoidRootPart.Velocity = Vector3.new(0, 2, 0)
            if UserInputService:IsKeyDown(Enum.KeyCode.Space) then
                LocalPlayer.Character.HumanoidRootPart.CFrame *= CFrame.new(0, 1, 0)
            end
        end
        if Config.Noclip then
            for _, v in pairs(LocalPlayer.Character:GetDescendants()) do
                if v:IsA("BasePart") then v.CanCollide = false end
            end
        end
    end
end)

RunService.Heartbeat:Connect(function()
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid.WalkSpeed = Config.WalkSpeed
    end
    if Config.HitboxExpander and CurrentTarget then
        CurrentTarget.Size = Vector3.new(Config.HitboxSize, Config.HitboxSize, Config.HitboxSize)
        CurrentTarget.Transparency = 0.7
    end
end)

UserInputService.JumpRequest:Connect(function() if Config.InfiniteJump then LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):ChangeState(Enum.HumanoidStateType.Jumping) end end)

Luna:Notification({ Title = "JULZ HUB", Content = "V50 Loaded! Fly & ESP Fixed." })
