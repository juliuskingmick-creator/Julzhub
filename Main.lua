--[[
    JULZ hub | V32 Mobile
    Updates: Manual Key Entry (No Auto-Load), Kick on Wrong Key, Infinite ESP
    Scripts: JJS, Piano, Jango Premium
]]

local TargetKey = "JULZISTHEBEST"
local DiscordLink = "https://discord.gg/cukP3aqCe"
local IsAuthenticated = false

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera
local RunService = game:GetService("RunService")
local ControlModule = require(LocalPlayer.PlayerScripts:WaitForChild("PlayerModule")):GetControls()

-- 1. MANUAL KEY SYSTEM (AUTO-LOAD REMOVED)
local function LoadKeySystem()
    local AuthGui = Instance.new("ScreenGui", game:GetService("CoreGui"))
    local MainFrame = Instance.new("Frame", AuthGui)
    MainFrame.Size = UDim2.new(0, 300, 0, 200); MainFrame.Position = UDim2.new(0.5, -150, 0.5, -100); MainFrame.BackgroundColor3 = Color3.fromRGB(12, 12, 12)
    Instance.new("UICorner", MainFrame)
    
    local Title = Instance.new("TextLabel", MainFrame)
    Title.Text = "JULZ HUB V32"; Title.Size = UDim2.new(1, 0, 0, 50); Title.TextColor3 = Color3.new(1, 1, 1); Title.Font = Enum.Font.GothamBold; Title.BackgroundTransparency = 1

    local Input = Instance.new("TextBox", MainFrame)
    Input.PlaceholderText = "Enter Key..."; Input.Size = UDim2.new(0.8, 0, 0, 45); Input.Position = UDim2.new(0.1, 0, 0.35, 0); Input.BackgroundColor3 = Color3.fromRGB(25, 25, 25); Input.TextColor3 = Color3.new(1, 1, 1)
    Instance.new("UICorner", Input)

    local Submit = Instance.new("TextButton", MainFrame)
    Submit.Text = "LOGIN"; Submit.Size = UDim2.new(0.8, 0, 0, 40); Submit.Position = UDim2.new(0.1, 0, 0.65, 0); Submit.BackgroundColor3 = Color3.fromRGB(160, 0, 255); Submit.TextColor3 = Color3.new(1, 1, 1)
    Instance.new("UICorner", Submit)

    Submit.MouseButton1Click:Connect(function()
        if Input.Text == TargetKey then 
            IsAuthenticated = true 
            AuthGui:Destroy() 
        else 
            LocalPlayer:Kick("\n[JULZ HUB]\nAccess Denied: Invalid Key.\nGet key here: " .. DiscordLink)
        end
    end)
    
    repeat task.wait() until IsAuthenticated
end
LoadKeySystem()

-- 2. ENGINE CONFIG
local Config = {
    WalkSpeed = 16, JumpPower = 50, FlySpeed = 50, Flying = false,
    EspEnabled = false, SpinBot = false, HitboxExpander = false, HitboxSize = 2
}

-- 3. INFINITE ESP
local function ApplyESP(plr)
    plr.CharacterAdded:Connect(function(char)
        if plr == LocalPlayer then return end
        local head = char:WaitForChild("Head", 15)
        local bill = Instance.new("BillboardGui", head)
        bill.Name = "JulzESP"; bill.AlwaysOnTop = true; bill.Size = UDim2.new(0, 100, 0, 50); bill.MaxDistance = math.huge
        local lbl = Instance.new("TextLabel", bill)
        lbl.Size = UDim2.new(1, 0, 1, 0); lbl.BackgroundTransparency = 1; lbl.TextColor3 = Color3.new(1, 1, 1); lbl.Font = Enum.Font.GothamBold; lbl.TextSize = 14
        RunService.RenderStepped:Connect(function()
            if char and char:FindFirstChild("Humanoid") and char.Humanoid.Health > 0 then
                lbl.Visible = Config.EspEnabled
                lbl.Text = plr.Name .. "\n[" .. math.floor(char.Humanoid.Health) .. " HP]"
            else lbl.Visible = false end
        end)
    end)
end
for _, p in pairs(Players:GetPlayers()) do ApplyESP(p) end
Players.PlayerAdded:Connect(ApplyESP)

-- 4. INTERFACE
local Luna = loadstring(game:HttpGet("https://raw.githubusercontent.com/Nebula-Softworks/Luna-Interface-Suite/main/source.lua"))()
local Window = Luna:CreateWindow({ Name = "JULZ hub", Subtitle = "V32 | Manual Auth", LoadingEnabled = true })

local Combat = Window:CreateTab({ Name = "Combat", Icon = "shutter_speed" })
local Visuals = Window:CreateTab({ Name = "Visuals", Icon = "visibility" })
local Movement = Window:CreateTab({ Name = "Movement", Icon = "bolt" })
local Extra = Window:CreateTab({ Name = "Scripts", Icon = "auto_awesome" })

Combat:CreateToggle({ Name = "Hitbox Expander", Callback = function(v) Config.HitboxExpander = v end })
Combat:CreateSlider({ Name = "Hitbox Size", Range = {2, 50}, CurrentValue = 2, Callback = function(v) Config.HitboxSize = v end })
Combat:CreateToggle({ Name = "Spin Bot", Callback = function(v) Config.SpinBot = v end })

Visuals:CreateToggle({ Name = "Infinite ESP", Callback = function(v) Config.EspEnabled = v end })

Movement:CreateSlider({ Name = "Speed", Range = {16, 250}, CurrentValue = 16, Callback = function(v) Config.WalkSpeed = v end })
Movement:CreateToggle({ Name = "Fly", Callback = function(v) 
    Config.Flying = v 
    if v then
        local root = LocalPlayer.Character.HumanoidRootPart
        local bv = Instance.new("BodyVelocity", root); bv.MaxForce = Vector3.new(1e6, 1e6, 1e6)
        local bg = Instance.new("BodyGyro", root); bg.MaxTorque = Vector3.new(1e6, 1e6, 1e6)
        task.spawn(function()
            while Config.Flying do
                RunService.RenderStepped:Wait()
                local moveDir = ControlModule:GetMoveVector()
                bv.Velocity = ((Camera.CFrame.LookVector * -moveDir.Z) + (Camera.CFrame.RightVector * moveDir.X)) * Config.FlySpeed
                bg.CFrame = Camera.CFrame
                if moveDir.Magnitude == 0 then bv.Velocity = Vector3.new(0, 0, 0) end
            end
            bv:Destroy(); bg:Destroy()
        end)
    end
end })

Extra:CreateButton({ Name = "Jango Premium", Callback = function() loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-jango-premium-crack-131377"))() end })
Extra:CreateButton({ Name = "Load JJS", Callback = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/cool5013/TBO/main/TBOscript"))() end })
Extra:CreateButton({ Name = "Load Piano", Callback = function() loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-talentless-crack-75521"))() end })

-- 5. CORE LOOP
RunService.RenderStepped:Connect(function()
    if Config.SpinBot and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        LocalPlayer.Character.HumanoidRootPart.CFrame = LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.Angles(0, math.rad(50), 0)
    end
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

Luna:Notification({ Title = "Access Granted", Content = "Welcome back, JULZ!" })
