--[[
    JULZHUB | RIVALS ONLY
    Lead Developer: julzmon
    UI Library: Luna (Strict Monochromatic Gray and Black)
    Target Game: Rivals (Roblox)
    Authentication: ThinkPad License System (Gray/Black Theme)
]]

local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")
local LocalPlayer = Players.LocalPlayer

-- Load Luna UI Library (Standard Dark default)
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/shlexsoftware/Luna/main/source.lua"))()

-- ==========================================
-- MAIN INTERFACE (LOADS ON SUCCESS)
-- ==========================================
local function LoadJulzHub()
    local Window = Library:CreateWindow({
        Name = "JulzHub | Rivals Only",
        Subtitle = "Developer: julzmon",
        Logo = "rbxassetid://16255151491", -- Mimi Logo (Gray/Black framing)
        ConfigFolder = "JulzHub_Rivals"
    })

    -- 1. GENERAL & UTILITY
    local GeneralTab = Window:CreateTab({ Name = "General & Utility", Icon = "rbxassetid://10734947300" })
    GeneralTab:CreateSection("Server & Game")
    GeneralTab:CreateToggle({ Name = "Instant Join", Callback = function() print("Feature Activated") end })
    GeneralTab:CreateButton({ Name = "Server Hop", Callback = function() print("Feature Activated") end })
    GeneralTab:CreateDropdown({ Name = "Config Manager", Options = {"Default", "Legit", "Rage"}, Callback = function() print("Feature Activated") end })
    GeneralTab:CreateToggle({ Name = "Chat Filter Bypass", Callback = function() print("Feature Activated") end })
    GeneralTab:CreateToggle({ Name = "Player Stats Overlay", Callback = function() print("Feature Activated") end })
    GeneralTab:CreateToggle({ Name = "Friend Notifier", Callback = function() print("Feature Activated") end })
    GeneralTab:CreateButton({ Name = "Teleport Manager", Callback = function() print("Feature Activated") end })
    GeneralTab:CreateToggle({ Name = "Performance Optimizer", Callback = function() print("Feature Activated") end })
    GeneralTab:CreateToggle({ Name = "Streamer Mode", Callback = function() print("Feature Activated") end })
    GeneralTab:CreateToggle({ Name = "Discord Rich Presence", Callback = function() print("Feature Activated") end })

    -- 2. COMBAT & AIM
    local CombatTab = Window:CreateTab({ Name = "Combat & Aim", Icon = "rbxassetid://10734950309" })
    CombatTab:CreateSection("Combat Enhancements")
    CombatTab:CreateToggle({ Name = "Silent Aim", Callback = function() print("Feature Activated") end })
    CombatTab:CreateSlider({ Name = "Aim Smoothness", Min = 1, Max = 100, CurrentValue = 50, Callback = function() print("Feature Activated") end })
    CombatTab:CreateDropdown({ Name = "Custom Aimbone", Options = {"Head", "Torso", "Random"}, Callback = function() print("Feature Activated") end })
    CombatTab:CreateToggle({ Name = "Snaplines", Callback = function() print("Feature Activated") end })
    CombatTab:CreateToggle({ Name = "Visibility Check", Callback = function() print("Feature Activated") end })
    CombatTab:CreateToggle({ Name = "Trigger Bot", Callback = function() print("Feature Activated") end })
    CombatTab:CreateSlider({ Name = "Recoil Control (%)", Min = 0, Max = 100, CurrentValue = 100, Callback = function() print("Feature Activated") end })
    CombatTab:CreateToggle({ Name = "Hitmarkers", Callback = function() print("Feature Activated") end })
    CombatTab:CreateToggle({ Name = "Bullet Tracers (Clean)", Callback = function() print("Feature Activated") end }) -- Changed description
    CombatTab:CreateToggle({ Name = "No-Clip Aim", Callback = function() print("Feature Activated") end })

    -- 3. VISUALS (ESP)
    local ESPTab = Window:CreateTab({ Name = "Visuals (ESP)", Icon = "rbxassetid://10734897102" })
    ESPTab:CreateSection("Visual Enhancements")
    ESPTab:CreateToggle({ Name = "Enable Master ESP", Callback = function() print("Feature Activated") end })
    ESPTab:CreateToggle({ Name = "Box ESP", Callback = function() print("Feature Activated") end })
    ESPTab:CreateToggle({ Name = "Skeleton ESP", Callback = function() print("Feature Activated") end })
    ESPTab:CreateToggle({ Name = "Player Names", Callback = function() print("Feature Activated") end })
    ESPTab:CreateToggle({ Name = "Distance ESP", Callback = function() print("Feature Activated") end })
    ESPTab:CreateToggle({ Name = "Item ESP", Callback = function() print("Feature Activated") end })
    ESPTab:CreateToggle({ Name = "2D Radar", Callback = function() print("Feature Activated") end })
    ESPTab:CreateToggle({ Name = "Tracer Lines (Gray/Black)", Callback = function() print("Feature Activated") end }) -- Changed description
    ESPTab:CreateToggle({ Name = "Health Bars", Callback = function() print("Feature Activated") end })
    ESPTab:CreateToggle({ Name = "Target Lock Icon", Callback = function() print("Feature Activated") end })
    
    Library:Init()
end

-- ==========================================
-- KEY SYSTEM (AUTHENTICATION)
-- ==========================================
local function InitializeKeySystem()
    local KeyGui = Instance.new("ScreenGui")
    KeyGui.Name = "JulzHub_Auth"
    KeyGui.ResetOnSpawn = false
    pcall(function() KeyGui.Parent = CoreGui end)

    local MainFrame = Instance.new("Frame")
    MainFrame.Size = UDim2.new(0, 480, 0, 360)
    MainFrame.Position = UDim2.new(0.5, -240, 0.5, -180)
    MainFrame.BackgroundColor3 = Color3.fromRGB(12, 12, 12) -- Dark Gray-Black
    MainFrame.BorderSizePixel = 0
    MainFrame.Parent = KeyGui

    Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 10)
    local Stroke = Instance.new("UIStroke", MainFrame)
    Stroke.Color = Color3.fromRGB(40, 40, 40) -- Clean Gray Accent
    Stroke.Thickness = 1

    -- Mimi (Typh OC) Image -Asset ID and framing preserved
    local MimiImage = Instance.new("ImageLabel")
    MimiImage.Size = UDim2.new(0, 180, 0, 180)
    MimiImage.Position = UDim2.new(0.5, -90, 0, 15)
    MimiImage.BackgroundTransparency = 1
    MimiImage.Image = "rbxassetid://16255151491" -- Mimi Image (Authentic Typh art)
    MimiImage.Parent = MainFrame

    -- Dialogue
    local Text1 = Instance.new("TextLabel")
    Text1.Size = UDim2.new(1, 0, 0, 30)
    Text1.Position = UDim2.new(0, 0, 0, 205)
    Text1.BackgroundTransparency = 1
    Text1.Text = "um... Can I help you?"
    Text1.TextColor3 = Color3.fromRGB(255, 255, 255)
    Text1.Font = Enum.Font.GothamBold
    Text1.TextSize = 18
    Text1.Parent = MainFrame

    local Text2 = Instance.new("TextLabel")
    Text2.Size = UDim2.new(1, -60, 0, 40)
    Text2.Position = UDim2.new(0, 30, 0, 230)
    Text2.BackgroundTransparency = 1
    Text2.Text = "Unauthorized access detected. Please enter your ThinkPad license key."
    Text2.TextColor3 = Color3.fromRGB(150, 150, 150) -- Gray text
    Text2.Font = Enum.Font.Gotham
    Text2.TextSize = 12
    Text2.TextWrapped = true
    Text2.Parent = MainFrame

    -- Input Box
    local InputBox = Instance.new("TextBox")
    InputBox.Size = UDim2.new(0, 300, 0, 40)
    InputBox.Position = UDim2.new(0.5, -150, 0, 275)
    InputBox.BackgroundColor3 = Color3.fromRGB(25, 25, 25) -- Dark Input
    InputBox.TextColor3 = Color3.fromRGB(255, 255, 255)
    InputBox.PlaceholderText = "License Key..."
    InputBox.Text = ""
    InputBox.Font = Enum.Font.Gotham
    InputBox.Parent = MainFrame
    Instance.new("UICorner", InputBox)

    -- Submit Button (Centered, single Gray button)
    local SubmitBtn = Instance.new("TextButton")
    SubmitBtn.Size = UDim2.new(0, 300, 0, 40)
    SubmitBtn.Position = UDim2.new(0.5, -150, 0, 320)
    SubmitBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50) -- Medium Gray Button
    SubmitBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    SubmitBtn.Text = "Verify"
    SubmitBtn.Font = Enum.Font.GothamBold
    SubmitBtn.TextSize = 16
    SubmitBtn.Parent = MainFrame
    Instance.new("UICorner", SubmitBtn)
    local BtnStroke = Instance.new("UIStroke", SubmitBtn)
    BtnStroke.Color = Color3.fromRGB(70, 70, 70) -- Button outline
    BtnStroke.Thickness = 1

    -- Developer Label
    local DevLabel = Instance.new("TextLabel")
    DevLabel.Size = UDim2.new(1, 0, 0, 20)
    DevLabel.Position = UDim2.new(0, 0, 1, -20)
    DevLabel.BackgroundTransparency = 1
    DevLabel.Text = "Lead Developer: julzmon"
    DevLabel.TextColor3 = Color3.fromRGB(80, 80, 80) -- Dark Gray text
    DevLabel.Font = Enum.Font.Gotham
    DevLabel.TextSize = 10
    DevLabel.Parent = MainFrame

    -- Key Logic
    SubmitBtn.MouseButton1Click:Connect(function()
        if InputBox.Text == "thinkpad" then
            SubmitBtn.Text = "✓"
            SubmitBtn.BackgroundColor3 = Color3.fromRGB(100, 100, 100) -- Light Gray Success
            task.wait(0.5)
            KeyGui:Destroy()
            LoadJulzHub()
        else
            SubmitBtn.Text = "X"
            SubmitBtn.BackgroundColor3 = Color3.fromRGB(15, 15, 15) -- Dark Gray Fail
            task.wait(1)
            SubmitBtn.Text = "Verify"
            SubmitBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
        end
    end)
end

-- Boot System
InitializeKeySystem()
