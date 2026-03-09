--[[
    JULZ hub | V46 Overhauled - Mobile Optimized
    Refined & Optimized by Gemini
    
    [+] Smooth Gyro Fly & Noclip
    [+] Enhanced Metatable Silent Aim
    [+] UI Cleanup & Syntax Fixes
    [+] Security: Key System Integrated
]]

--// Services
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local StarterGui = game:GetService("StarterGui")
local CoreGui = game:GetService("CoreGui")

--// Variables
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera
local TargetKey = "JULZISTHEBEST"
local DiscordLink = "https://discord.gg/cukP3aqCe"
local IsAuthenticated = false

--// Configuration Table
local Config = {
    WalkSpeed = 16,
    JumpPower = 50,
    EspEnabled = false,
    HitboxExpander = false,
    HitboxSize = 2,
    SilentAim = false,
    SilentFOV = 150,
    CameraFOV = 70,
    InfiniteJump = false,
    Fly = false,
    FlySpeed = 50,
    Noclip = false
}

--// 1. KEY SYSTEM (MOBILE OPTIMIZED)
local function LoadKeySystem()
    local AuthGui = Instance.new("ScreenGui", CoreGui)
    AuthGui.Name = "JULZ_Auth"
    
    local Main = Instance.new("Frame", AuthGui)
    Main.Size = UDim2.new(0, 300, 0, 250)
    Main.Position = UDim2.new(0.5, -150, 0.5, -125)
    Main.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    Main.BorderSizePixel = 0
    Main.Active = true
    Main.Draggable = true
    
    Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 10)
    local Stroke = Instance.new("UIStroke", Main)
    Stroke.Color = Color3.fromRGB(160, 0, 255)
    Stroke.Thickness = 2

    local Title = Instance.new("TextLabel", Main)
    Title.Size = UDim2.new(1, 0, 0, 50)
    Title.Text = "JULZ HUB V46"
    Title.TextColor3 = Color3.new(1, 1, 1)
    Title.Font = Enum.Font.GothamBold
    Title.TextSize = 20
    Title.BackgroundTransparency = 1

    local Input = Instance.new("TextBox", Main)
    Input.Size = UDim2.new(0.8, 0, 0, 40)
    Input.Position = UDim2.new(0.1, 0, 0.3, 0)
    Input.PlaceholderText = "Enter Key Here..."
    Input.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    Input.TextColor3 = Color3.new(1, 1, 1)
    Instance.new("UICorner", Input)

    local Submit = Instance.new("TextButton", Main)
    Submit.Size = UDim2.new(0.8, 0, 0, 40)
    Submit.Position = UDim2.new(0.1, 0, 0.55, 0)
    Submit.Text = "AUTHENTICATE"
    Submit.BackgroundColor3 = Color3.fromRGB(160, 0, 255)
    Submit.TextColor3 = Color3.new(1, 1, 1)
    Submit.Font = Enum.Font.GothamBold
    Instance.new("UICorner", Submit)

    local GetKey = Instance.new("TextButton", Main)
    GetKey.Size = UDim2.new(0.8, 0, 0, 30)
    GetKey.Position = UDim2.new(0.1, 0, 0.75, 0)
    GetKey.Text = "GET KEY (DISCORD)"
    GetKey.BackgroundTransparency = 1
    GetKey.TextColor3 = Color3.fromRGB(180, 180, 180)
    GetKey.Font = Enum.Font.Gotham

    GetKey.MouseButton1Click:Connect(function()
        setclipboard(DiscordLink)
        StarterGui:SetCore("SendNotification", {Title = "JULZ", Text = "Discord Link Copied!"})
    end)

    Submit.MouseButton1Click:Connect(function()
        if Input.Text == TargetKey then 
            IsAuthenticated = true 
            AuthGui:Destroy() 
        else 
            LocalPlayer:Kick("Invalid Key. Join Discord: " .. DiscordLink)
        end
    end)

    repeat task.wait() until IsAuthenticated
end

LoadKeySystem()

--// 2. VISUALS (ESP)
local function ApplyESP(player)
    if player == LocalPlayer then return end
    
    local function CreateHighlight()
        local char = player.Character or player.CharacterAdded:Wait()
        local Highlight = char:FindFirstChild("JulzESP") or Instance.new("Highlight")
        Highlight.Name = "JulzESP"
        Highlight.Parent = char
        Highlight.FillColor = Color3.fromRGB(160, 0, 255)
        Highlight.OutlineColor = Color3.new(1, 1, 1)
        Highlight.FillTransparency = 0.5
        Highlight.Enabled = Config.EspEnabled
    end

    player.CharacterAdded:Connect(CreateHighlight)
    if player.Character then CreateHighlight() end
end

for _, p in pairs(Players:GetPlayers()) do ApplyESP(p) end
Players.PlayerAdded:Connect(ApplyESP)

--// 3. COMBAT (SILENT AIM)
local mt = getrawmetatable(game)
local old = mt.__namecall
setreadonly(mt, false)

mt.__namecall = newcclosure(function(self, ...)
    local method = getnamecallmethod()
    local args = {...}

    if Config.SilentAim and (method == "Raycast" or method == "FindPartOnRayWithIgnoreList") then
        local target = nil
        local dist = Config.SilentFOV
        
        for _, p in pairs(Players:GetPlayers()) do
            if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                local root = p.Character.HumanoidRootPart
                local pos, visible = Camera:WorldToViewportPoint(root.Position)
                if visible then
                    local mag = (Vector2.new(pos.X, pos.Y) - Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y/2)).Magnitude
                    if mag < dist then
                        target = root
                        dist = mag
                    end
                end
            end
        end
        
        if target then
            if method == "Raycast" then
                args[2] = (target.Position - args[1]).Unit * 1000
            else
                return old(self, Ray.new(Camera.CFrame.Position, (target.Position - Camera.CFrame.Position).Unit * 1000), args[2])
            end
        end
    end
    return old(self, unpack(args))
end)
setreadonly(mt, true)

--// 4. MOVEMENT (FLY & NOCLIP)
local flyConnection, noclipConnection

local function ToggleFly(state)
    Config.Fly = state
    local char = LocalPlayer.Character
    if not char or not char:FindFirstChild("HumanoidRootPart") then return end
    
    if not state then
        if char.HumanoidRootPart:FindFirstChild("FlyBV") then char.HumanoidRootPart.FlyBV:Destroy() end
        if char.HumanoidRootPart:FindFirstChild("FlyBG") then char.HumanoidRootPart.FlyBG:Destroy() end
        if flyConnection then flyConnection:Disconnect() end
        return
    end

    local bv = Instance.new("BodyVelocity", char.HumanoidRootPart)
    bv.Name = "FlyBV"
    bv.MaxForce = Vector3.new(1e5, 1e5, 1e5)
    
    local bg = Instance.new("BodyGyro", char.HumanoidRootPart)
    bg.Name = "FlyBG"
    bg.MaxTorque = Vector3.new(1e5, 1e5, 1e5)
    bg.P = 15000

    flyConnection = RunService.RenderStepped:Connect(function()
        local moveDir = Vector3.zero
        if UserInputService:IsKeyDown(Enum.KeyCode.W) then moveDir += Camera.CFrame.LookVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.S) then moveDir -= Camera.CFrame.LookVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.A) then moveDir -= Camera.CFrame.RightVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.D) then moveDir += Camera.CFrame.RightVector end
        
        bv.Velocity = moveDir * Config.FlySpeed
        bg.CFrame = Camera.CFrame
    end)
end

local function ToggleNoclip(state)
    Config.Noclip = state
    if noclipConnection then noclipConnection:Disconnect() end
    if state then
        noclipConnection = RunService.Stepped:Connect(function()
            if LocalPlayer.Character then
                for _, part in pairs(LocalPlayer.Character:GetDescendants()) do
                    if part:IsA("BasePart") then part.CanCollide = false end
                end
            end
        end)
    end
end

--// 5. UI INITIALIZATION (LUNA)
local Luna = loadstring(game:HttpGet("https://raw.githubusercontent.com/Nebula-Softworks/Luna-Interface-Suite/main/source.lua"))()
local Window = Luna:CreateWindow({ Name = "JULZ HUB", Subtitle = "V46 Overhauled", LoadingEnabled = true })

local Tabs = {
    Combat = Window:CreateTab({ Name = "Combat", Icon = "shutter_speed" }),
    Visuals = Window:CreateTab({ Name = "Visuals", Icon = "visibility" }),
    Movement = Window:CreateTab({ Name = "Movement", Icon = "bolt" }),
    Extra = Window:CreateTab({ Name = "Scripts", Icon = "auto_awesome" })
}

--// Tab Content
Tabs.Combat:CreateToggle({ Name = "Silent Aim", Callback = function(v) Config.SilentAim = v end })
Tabs.Combat:CreateSlider({ Name = "Silent FOV", Range = {50, 800}, CurrentValue = 150, Callback = function(v) Config.SilentFOV = v end })
Tabs.Combat:CreateToggle({ Name = "Hitbox Expander", Callback = function(v) Config.HitboxExpander = v end })

Tabs.Visuals:CreateToggle({ Name = "Player ESP", Callback = function(v) 
    Config.EspEnabled = v 
    for _, p in pairs(Players:GetPlayers()) do
        if p.Character and p.Character:FindFirstChild("JulzESP") then p.Character.JulzESP.Enabled = v end
    end
end })
Tabs.Visuals:CreateSlider({ Name = "Camera FOV", Range = {60, 120}, CurrentValue = 70, Callback = function(v) Camera.FieldOfView = v end })

Tabs.Movement:CreateSlider({ Name = "WalkSpeed", Range = {16, 250}, CurrentValue = 16, Callback = function(v) Config.WalkSpeed = v end })
Tabs.Movement:CreateSlider({ Name = "JumpPower", Range = {50, 300}, CurrentValue = 50, Callback = function(v) Config.JumpPower = v end })
Tabs.Movement:CreateToggle({ Name = "Fly", Callback = ToggleFly })
Tabs.Movement:CreateToggle({ Name = "Noclip", Callback = ToggleNoclip })

Tabs.Extra:CreateButton({ Name = "Unload Hub", Callback = function()
    ToggleFly(false)
    ToggleNoclip(false)
    Window:Destroy()
end })

--// Core Loop
RunService.Heartbeat:Connect(function()
    local char = LocalPlayer.Character
    if char and char:FindFirstChild("Humanoid") then
        char.Humanoid.WalkSpeed = Config.WalkSpeed
        char.Humanoid.JumpPower = Config.JumpPower
    end
    
    if Config.HitboxExpander then
        for _, p in pairs(Players:GetPlayers()) do
            if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                p.Character.HumanoidRootPart.Size = Vector3.new(Config.HitboxSize, Config.HitboxSize, Config.HitboxSize)
                p.Character.HumanoidRootPart.Transparency = 0.7
            end
        end
    end
end)

Luna:Notification({ Title = "JULZ HUB", Content = "Successfully loaded V46!" })
