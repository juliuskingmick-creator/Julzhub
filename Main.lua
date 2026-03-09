--[[
    JULZ hub | V26 Mobile
    Updated: Spin Bot, Hitbox Expander, Shader Script
    Scripts: JJS (TBO Hub) & Talentless (Piano)
]]

local TargetKey = "JULZISTHEBEST"
local DiscordLink = "https://discord.gg/cukP3aqCe"
local SaveFile = "AuthData.txt"
local IsAuthenticated = false

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera
local RunService = game:GetService("RunService")
local ControlModule = require(LocalPlayer.PlayerScripts:WaitForChild("PlayerModule")):GetControls()

-- 1. AUTH SYSTEM
if isfile(SaveFile) and readfile(SaveFile) == TargetKey then
    IsAuthenticated = true
end

if not IsAuthenticated then
    local AuthGui = Instance.new("ScreenGui", game:GetService("CoreGui"))
    local BG = Instance.new("Frame", AuthGui)
    BG.Size = UDim2.new(0, 280, 0, 180); BG.Position = UDim2.new(0.5, -140, 0.5, -90); BG.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
    Instance.new("UICorner", BG)

    local Input = Instance.new("TextBox", BG)
    Input.PlaceholderText = "Enter Key..."; Input.Size = UDim2.new(0.85, 0, 0, 40); Input.Position = UDim2.new(0.075, 0, 0.28, 0); Input.BackgroundColor3 = Color3.fromRGB(30, 30, 30); Input.TextColor3 = Color3.new(1, 1, 1)
    Instance.new("UICorner", Input)

    local LoginBtn = Instance.new("TextButton", BG)
    LoginBtn.Text = "SUBMIT"; LoginBtn.Size = UDim2.new(0.85, 0, 0, 40); LoginBtn.Position = UDim2.new(0.075, 0, 0.55, 0); LoginBtn.BackgroundColor3 = Color3.fromRGB(160, 0, 255); LoginBtn.TextColor3 = Color3.new(1, 1, 1)
    Instance.new("UICorner", LoginBtn)

    local LinkBtn = Instance.new("TextButton", BG)
    LinkBtn.Text = "COPY DISCORD"; LinkBtn.Size = UDim2.new(0.85, 0, 0, 25); LinkBtn.Position = UDim2.new(0.075, 0, 0.82, 0); LinkBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40); LinkBtn.TextColor3 = Color3.new(1, 1, 1)
    Instance.new("UICorner", LinkBtn)

    LinkBtn.MouseButton1Click:Connect(function() setclipboard(DiscordLink) LinkBtn.Text = "COPIED!" task.wait(1) LinkBtn.Text = "COPY DISCORD" end)

    LoginBtn.MouseButton1Click:Connect(function() 
        if Input.Text == TargetKey then 
            writefile(SaveFile, TargetKey); IsAuthenticated = true; AuthGui:Destroy() 
        else 
            LocalPlayer:Kick("\n[SYSTEM]\nInvalid Key. Join Discord: " .. DiscordLink)
        end 
    end)
    repeat task.wait() until IsAuthenticated == true
end

-- 2. ENGINE CONFIG
local Config = {
    Aimbot = false, FOV = 120, AimPart = "Head",
    WalkSpeed = 16, JumpPower = 50, FlySpeed = 50, Flying = false,
    EspEnabled = false, SpinBot = false, SpinSpeed = 50,
    HitboxExpander = false, HitboxSize = 2
}

local FOVCircle = Drawing.new("Circle")
FOVCircle.Thickness = 2; FOVCircle.Color = Color3.fromRGB(160, 0, 255); FOVCircle.Transparency = 0.7; FOVCircle.Filled = false; FOVCircle.Visible = true

local function GetClosestTarget()
    local target = nil; local shortestDistance = Config.FOV
    local screenCenter = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
    for _, v in pairs(Players:GetPlayers()) do
        if v ~= LocalPlayer and v.Character and v.Character:FindFirstChild(Config.AimPart) and v.Character.Humanoid.Health > 0 then
            local pos, onScreen = Camera:WorldToViewportPoint(v.Character[Config.AimPart].Position)
            if onScreen then
                local distance = (Vector2.new(pos.X, pos.Y) - screenCenter).Magnitude
                if distance < shortestDistance then target = v; shortestDistance = distance end
            end
        end
    end
    return target
end

-- 3. ESP & HITBOX LOGIC
local function ApplyFeatures(plr)
    plr.CharacterAdded:Connect(function(char)
        if plr == LocalPlayer then return end
        local hum = char:WaitForChild("Humanoid", 10)
        local root = char:WaitForChild("HumanoidRootPart", 10)
        
        -- ESP
        local bill = Instance.new("BillboardGui", char:WaitForChild("Head"))
        bill.AlwaysOnTop = true; bill.Size = UDim2.new(0, 100, 0, 50); bill.StudsOffset = Vector3.new(0, 2, 0)
        local lbl = Instance.new("TextLabel", bill)
        lbl.Size = UDim2.new(1, 0, 1, 0); lbl.BackgroundTransparency = 1; lbl.TextColor3 = Color3.new(1, 1, 1); lbl.TextSize = 12
        
        RunService.Heartbeat:Connect(function()
            if char and char:FindFirstChild("Head") and hum.Health > 0 then
                lbl.Visible = Config.EspEnabled
                lbl.Text = plr.Name .. " [" .. math.floor(hum.Health) .. "]"
                
                -- Hitbox Expander
                if Config.HitboxExpander then
                    root.Size = Vector3.new(Config.HitboxSize, Config.HitboxSize, Config.HitboxSize)
                    root.Transparency = 0.7
                    root.CanCollide = false
                else
                    root.Size = Vector3.new(2, 2, 1)
                    root.Transparency = 1
                end
            else bill.Enabled = false end
        end)
    end)
end
for _, p in pairs(Players:GetPlayers()) do ApplyFeatures(p) end
Players.PlayerAdded:Connect(ApplyFeatures)

-- 4. INTERFACE
local Luna = loadstring(game:HttpGet("https://raw.githubusercontent.com/Nebula-Softworks/Luna-Interface-Suite/main/source.lua"))()
local Window = Luna:CreateWindow({ Name = "JULZ hub", Subtitle = "V26 Chaos", LoadingEnabled = true })

local Combat = Window:CreateTab({ Name = "Combat", Icon = "shutter_speed" })
local Visuals = Window:CreateTab({ Name = "Visuals", Icon = "visibility" })
local Movement = Window:CreateTab({ Name = "Movement", Icon = "bolt" })
local Extra = Window:CreateTab({ Name = "Scripts", Icon = "auto_awesome" })

-- COMBAT
Combat:CreateToggle({ Name = "Camera Aimbot", Callback = function(v) Config.Aimbot = v end })
Combat:CreateToggle({ Name = "Hitbox Expander", Callback = function(v) Config.HitboxExpander = v end })
Combat:CreateSlider({ Name = "Hitbox Size", Range = {2, 20}, CurrentValue = 2, Callback = function(v) Config.HitboxSize = v end })
Combat:CreateToggle({ Name = "Spin Bot", Callback = function(v) Config.SpinBot = v end })
Combat:CreateSlider({ Name = "Spin Speed", Range = {10, 100}, CurrentValue = 50, Callback = function(v) Config.SpinSpeed = v end })

-- VISUALS
Visuals:CreateToggle({ Name = "Player ESP", Callback = function(v) Config.EspEnabled = v end })
Visuals:CreateButton({ Name = "No-Key Shader Script", Callback = function() 
    -- Built-in Cinematic Shader Logic
    local bloom = Instance.new("BloomEffect", game.Lighting)
    bloom.Intensity = 1; bloom.Size = 24; bloom.Threshold = 0.9
    local sunRays = Instance.new("SunRaysEffect", game.Lighting)
    sunRays.Intensity = 0.1; sunRays.Spread = 1
    local color = Instance.new("ColorCorrectionEffect", game.Lighting)
    color.Brightness = 0.05; color.Contrast = 0.1; color.Saturation = 0.2
    Luna:Notification({ Title = "Shaders", Content = "Cinematic Shaders Applied!" })
end })

-- MOVEMENT
Movement:CreateSlider({ Name = "Speed", Range = {16, 250}, CurrentValue = 16, Callback = function(v) Config.WalkSpeed = v end })
Movement:CreateToggle({ Name = "Mobile Fly", Callback = function(v) 
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

-- SCRIPTS
Extra:CreateButton({ Name = "Load JJS (TBO Hub)", Callback = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/cool5013/TBO/main/TBOscript"))() end })
Extra:CreateButton({ Name = "Load Talentless (Piano)", Callback = function() loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-talentless-crack-75521"))() end })

-- 5. CORE LOOP
RunService.RenderStepped:Connect(function()
    FOVCircle.Radius = Config.FOV
    FOVCircle.Position = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
    
    if Config.Aimbot then
        local t = GetClosestTarget()
        if t then Camera.CFrame = CFrame.new(Camera.CFrame.Position, t.Character[Config.AimPart].Position) end
    end
    
    if Config.SpinBot and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        LocalPlayer.Character.HumanoidRootPart.CFrame = LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.Angles(0, math.rad(Config.SpinSpeed), 0)
    end

    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid.WalkSpeed = Config.WalkSpeed
    end
end)

Luna:Notification({ Title = "JULZ hub", Content = "V26 Chaos Loaded!" })
