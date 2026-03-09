local TargetKey = "JULZISTHEBEST"
local DiscordLink = "https://discord.gg/cukP3aqCe"
local SaveFile = "AuthData.txt"
local IsAuthenticated = false

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local ControlModule = require(LocalPlayer.PlayerScripts:WaitForChild("PlayerModule")):GetControls()

-- 1. PERSISTENT AUTH (MOBILE STORAGE COMPATIBLE)
if isfile(SaveFile) and readfile(SaveFile) == TargetKey then
    IsAuthenticated = true
end

if not IsAuthenticated then
    local AuthGui = Instance.new("ScreenGui", game:GetService("CoreGui"))
    local BG = Instance.new("Frame", AuthGui)
    BG.Size = UDim2.new(0, 280, 0, 180); BG.Position = UDim2.new(0.5, -140, 0.5, -90); BG.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
    Instance.new("UICorner", BG)

    local Input = Instance.new("TextBox", BG)
    Input.PlaceholderText = "Enter Key..."; Input.Size = UDim2.new(0.85, 0, 0, 40); Input.Position = UDim2.new(0.075, 0, 0.25, 0); Input.BackgroundColor3 = Color3.fromRGB(25, 25, 25); Input.TextColor3 = Color3.new(1, 1, 1); Input.TextSize = 14
    Instance.new("UICorner", Input)

    local LoginBtn = Instance.new("TextButton", BG)
    LoginBtn.Text = "SUBMIT"; LoginBtn.Size = UDim2.new(0.85, 0, 0, 40); LoginBtn.Position = UDim2.new(0.075, 0, 0.52, 0); LoginBtn.BackgroundColor3 = Color3.fromRGB(160, 0, 255); LoginBtn.TextColor3 = Color3.new(1, 1, 1)
    Instance.new("UICorner", LoginBtn)

    local LinkBtn = Instance.new("TextButton", BG)
    LinkBtn.Text = "COPY DISCORD"; LinkBtn.Size = UDim2.new(0.85, 0, 0, 30); LinkBtn.Position = UDim2.new(0.075, 0, 0.8, 0); LinkBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 35); LinkBtn.TextColor3 = Color3.new(1, 1, 1)
    Instance.new("UICorner", LinkBtn)

    LinkBtn.MouseButton1Click:Connect(function() setclipboard(DiscordLink) LinkBtn.Text = "COPIED!" task.wait(1) LinkBtn.Text = "COPY DISCORD" end)

    LoginBtn.MouseButton1Click:Connect(function() 
        if Input.Text == TargetKey then 
            writefile(SaveFile, TargetKey); IsAuthenticated = true; AuthGui:Destroy() 
        else 
            LocalPlayer:Kick("\n[JULZ]\nInvalid key. Discord: " .. DiscordLink)
        end 
    end)
    repeat task.wait() until IsAuthenticated == true
end

---------------------------------------------------------
-- 2. MOBILE-FRIENDLY ENGINE
---------------------------------------------------------
local Config = {
    Aimbot = false, SilentAim = false, FOV = 120, AimPart = "Head",
    WalkSpeed = 16, JumpPower = 50, FlySpeed = 50, Flying = false,
    EspEnabled = false
}

-- FOV Circle (Centered for Mobile)
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

-- ESP (Performance Optimized for Mobile)
local function CreateESP(plr)
    plr.CharacterAdded:Connect(function(char)
        if plr == LocalPlayer then return end
        local head = char:WaitForChild("Head")
        local hum = char:WaitForChild("Humanoid")
        local bill = Instance.new("BillboardGui", head)
        bill.AlwaysOnTop = true; bill.Size = UDim2.new(0, 100, 0, 50); bill.StudsOffset = Vector3.new(0, 2, 0)
        local lbl = Instance.new("TextLabel", bill)
        lbl.Size = UDim2.new(1, 0, 1, 0); lbl.BackgroundTransparency = 1; lbl.TextColor3 = Color3.new(1, 1, 1); lbl.Font = Enum.Font.GothamBold; lbl.TextSize = 12
        
        RunService.Heartbeat:Connect(function()
            if char and char:FindFirstChild("Head") and hum.Health > 0 then
                lbl.Visible = Config.EspEnabled
                lbl.Text = plr.Name .. " [" .. math.floor(hum.Health) .. "]"
                lbl.TextColor3 = hum.Health > 50 and Color3.new(0, 1, 0) or Color3.new(1, 0, 0)
            else
                bill.Enabled = false
            end
        end)
    end)
end
for _, p in pairs(Players:GetPlayers()) do CreateESP(p) end
Players.PlayerAdded:Connect(CreateESP)

---------------------------------------------------------
-- 3. UI LOAD (LUNA MOBILE SCALING)
---------------------------------------------------------
local Luna = loadstring(game:HttpGet("https://raw.githubusercontent.com/Nebula-Softworks/Luna-Interface-Suite/main/source.lua"))()
local Window = Luna:CreateWindow({ Name = "JULZ hub", Subtitle = "V24 Mobile", LoadingEnabled = true })

local Combat = Window:CreateTab({ Name = "Combat", Icon = "shutter_speed" })
local Visuals = Window:CreateTab({ Name = "Visuals", Icon = "visibility" })
local Movement = Window:CreateTab({ Name = "Movement", Icon = "bolt" })
local Extra = Window:CreateTab({ Name = "Scripts", Icon = "auto_awesome" })

-- COMBAT (Mobile FOV)
Combat:CreateToggle({ Name = "Camera Aimbot", Callback = function(v) Config.Aimbot = v end })
Combat:CreateToggle({ Name = "Silent Aim", Callback = function(v) Config.SilentAim = v end })
Combat:CreateSlider({ Name = "Aim Range", Range = {50, 500}, CurrentValue = 120, Callback = function(v) Config.FOV = v end })

-- VISUALS
Visuals:CreateToggle({ Name = "Player ESP", Callback = function(v) Config.EspEnabled = v end })

-- MOVEMENT (Joystick Compatible Fly)
Movement:CreateSlider({ Name = "Speed", Range = {16, 250}, CurrentValue = 16, Callback = function(v) Config.WalkSpeed = v end })
Movement:CreateSlider({ Name = "Jump", Range = {50, 400}, CurrentValue = 50, Callback = function(v) Config.JumpPower = v end })
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
                -- Mobile Vector Fix: moveDir.Z is Forward/Back, moveDir.X is Left/Right
                bv.Velocity = ((Camera.CFrame.LookVector * -moveDir.Z) + (Camera.CFrame.RightVector * moveDir.X)) * Config.FlySpeed
                bg.CFrame = Camera.CFrame
                if moveDir.Magnitude == 0 then bv.Velocity = Vector3.new(0, 0, 0) end
            end
            bv:Destroy(); bg:Destroy()
        end)
    end
end })

-- EXTERNAL
Extra:CreateButton({ Name = "Load JJS (TBO)", Callback = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/cool5013/TBO/main/TBOscript"))() end })
Extra:CreateButton({ Name = "Load Piano (Talentless)", Callback = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/hellohellohell012321/TALENTLESS/main/TALENTLESS", true))() end })

-- PERSISTENT TICK
RunService.RenderStepped:Connect(function()
    FOVCircle.Radius = Config.FOV
    FOVCircle.Position = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2) -- FOV stays middle of screen
    
    if Config.Aimbot then
        local t = GetClosestTarget()
        if t then Camera.CFrame = CFrame.new(Camera.CFrame.Position, t.Character[Config.AimPart].Position) end
    end
    
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid.WalkSpeed = Config.WalkSpeed
        LocalPlayer.Character.Humanoid.JumpPower = Config.JumpPower
    end
end)

Luna:Notification({ Title = "Mobile Ready", Content = "JULZ hub V24 is active." })
