--[[
    JULZHUB | RIVALS ONLY (DELTA OPTIMIZED)
    Lead Developer: julzmon
    Theme: Monochrome (Gray/Black)
    Key: thinkpad
]]

-- 1. Delta-Specific Optimization: Ensure environment is ready
repeat task.wait() until game:IsLoaded()

local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")
local ContentProvider = game:GetService("ContentProvider")
local LocalPlayer = Players.LocalPlayer

-- Pre-load Mimi Asset to prevent white box issues
local MimiAsset = "rbxassetid://16255151491"
task.spawn(function()
    ContentProvider:PreloadAsync({MimiAsset})
end)

-- 2. Secure UI Library Load
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/shlexsoftware/Luna/main/source.lua"))()

-- ==========================================
-- MAIN INTERFACE (LUNA)
-- ==========================================
local function LoadJulzHub()
    local Window = Library:CreateWindow({
        Name = "JulzHub | Rivals Only",
        Subtitle = "Dev: julzmon",
        Logo = MimiAsset,
        ConfigFolder = "JulzHub_Rivals_Delta"
    })

    -- TAB 1: COMBAT (High Precision)
    local CombatTab = Window:CreateTab({ Name = "Combat", Icon = "rbxassetid://10734950309" })
    CombatTab:CreateSection("Accuracy Modules")
    CombatTab:CreateToggle({ Name = "Silent Aim", Callback = function(v) end })
    CombatTab:CreateToggle({ Name = "Aimbot", Callback = function(v) end })
    CombatTab:CreateSlider({ Name = "Smoothness", Min = 1, Max = 100, CurrentValue = 50, Callback = function(v) end })
    CombatTab:CreateSlider({ Name = "FOV Size", Min = 30, Max = 800, CurrentValue = 100, Callback = function(v) end })
    CombatTab:CreateToggle({ Name = "Show FOV Circle", Callback = function(v) end })
    CombatTab:CreateToggle({ Name = "Triggerbot", Callback = function(v) end })
    CombatTab:CreateToggle({ Name = "No Recoil", Callback = function(v) end })
    CombatTab:CreateToggle({ Name = "No Spread", Callback = function(v) end })
    CombatTab:CreateSlider({ Name = "Hitbox Multiplier", Min = 1, Max = 10, CurrentValue = 1, Callback = function(v) end })
    CombatTab:CreateDropdown({ Name = "Target Bone", Options = {"Head", "Torso", "HumanoidRootPart"}, Callback = function(v) end })

    -- TAB 2: VISUALS (Optimized for Mobile/Delta)
    local VisualsTab = Window:CreateTab({ Name = "Visuals", Icon = "rbxassetid://10734897102" })
    VisualsTab:CreateSection("ESP Options")
    VisualsTab:CreateToggle({ Name = "Enable ESP", Callback = function(v) end })
    VisualsTab:CreateToggle({ Name = "Box ESP", Callback = function(v) end })
    VisualsTab:CreateToggle({ Name = "Skeleton ESP", Callback = function(v) end })
    VisualsTab:CreateToggle({ Name = "Name ESP", Callback = function(v) end })
    VisualsTab:CreateToggle({ Name = "Distance ESP", Callback = function(v) end })
    VisualsTab:CreateToggle({ Name = "Tracer Lines", Callback = function(v) end })
    VisualsTab:CreateToggle({ Name = "Health Bars", Callback = function(v) end })
    VisualsTab:CreateToggle({ Name = "Chams (Outlines)", Callback = function(v) end })
    VisualsTab:CreateToggle({ Name = "Head Dots", Callback = function(v) end })
    VisualsTab:CreateToggle({ Name = "View Angles", Callback = function(v) end })

    -- TAB 3: MOVEMENT
    local MoveTab = Window:CreateTab({ Name = "Movement", Icon = "rbxassetid://10747373176" })
    MoveTab:CreateSection("Physics Control")
    MoveTab:CreateSlider({ Name = "Walk Speed", Min = 16, Max = 150, CurrentValue = 16, Callback = function(v) end })
    MoveTab:CreateSlider({ Name = "Jump Power", Min = 50, Max = 250, CurrentValue = 50, Callback = function(v) end })
    MoveTab:CreateToggle({ Name = "Infinite Jump", Callback = function(v) end })
    MoveTab:CreateToggle({ Name = "Flight Mode", Callback = function(v) end })
    MoveTab:CreateToggle({ Name = "No-Clip", Callback = function(v) end })
    MoveTab:CreateToggle({ Name = "Auto-Sprint", Callback = function(v) end })
    MoveTab:CreateToggle({ Name = "Bunny Hop", Callback = function(v) end })
    MoveTab:CreateToggle({ Name = "Anti-Fall", Callback = function(v) end })
    MoveTab:CreateToggle({ Name = "Spinbot", Callback = function(v) end })
    MoveTab:CreateToggle({ Name = "Water Walk", Callback = function(v) end })

    -- TAB 4: UTILITY (Rivals Only)
    local UtilTab = Window:CreateTab({ Name = "Utility", Icon = "rbxassetid://10734947300" })
    UtilTab:CreateSection("Game Utils")
    UtilTab:CreateButton({ Name = "Server Hop", Callback = function() end })
    UtilTab:CreateButton({ Name = "Rejoin Server", Callback = function() end })
    UtilTab:CreateToggle({ Name = "Auto-Queue Match", Callback = function(v) end })
    UtilTab:CreateToggle({ Name = "Fullbright", Callback = function(v) end })
    UtilTab:CreateToggle({ Name = "Instant Respawn", Callback = function(v) end })
    UtilTab:CreateToggle({ Name = "Streamer Mode", Callback = function(v) end })
    UtilTab:CreateToggle({ Name = "Performance Mode", Callback = function(v) end })
    UtilTab:CreateToggle({ Name = "Chat Spammer", Callback = function(v) end })
    UtilTab:CreateToggle({ Name = "FPS Unlocker", Callback = function(v) end })
    UtilTab:CreateButton({ Name = "Copy Script Link", Callback = function() setclipboard("https://github.com/juliuskingmick-creator/Julzhub") end })

    Library:Init()
end

-- ==========================================
-- KEY SYSTEM (GRAY & BLACK MIMI THEME)
-- ==========================================
local function StartAuth()
    -- Create ScreenGui with ZIndex behavior for Delta
    local KeyGui = Instance.new("ScreenGui")
    KeyGui.Name = "JulzAuth"
    KeyGui.IgnoreGuiInset = true
    KeyGui.DisplayOrder = 999
    KeyGui.Parent = CoreGui

    local Main = Instance.new("Frame")
    Main.Size = UDim2.new(0, 450, 0, 380)
    Main.Position = UDim2.new(0.5, -225, 0.5, -190)
    Main.BackgroundColor3 = Color3.fromRGB(12, 12, 12)
    Main.BorderSizePixel = 0
    Main.Parent = KeyGui

    Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 15)
    local Stroke = Instance.new("UIStroke", Main)
    Stroke.Color = Color3.fromRGB(40, 40, 40)
    Stroke.Thickness = 2

    -- Mimi OC (Typh) - Authenticated Asset
    local Mimi = Instance.new("ImageLabel")
    Mimi.Size = UDim2.new(0, 200, 0, 200)
    Mimi.Position = UDim2.new(0.5, -100, 0, 20)
    Mimi.BackgroundTransparency = 1
    Mimi.Image = MimiAsset
    Mimi.Parent = Main

    local Title = Instance.new("TextLabel")
    Title.Size = UDim2.new(1, 0, 0, 30)
    Title.Position = UDim2.new(0, 0, 0, 230)
    Title.BackgroundTransparency = 1
    Title.Text = "um... Can I help you?"
    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title.Font = Enum.Font.GothamBold
    Title.TextSize = 18
    Title.Parent = Main

    local Sub = Instance.new("TextLabel")
    Sub.Size = UDim2.new(1, -60, 0, 40)
    Sub.Position = UDim2.new(0, 30, 0, 255)
    Sub.BackgroundTransparency = 1
    Sub.Text = "Unauthorized access detected. Please enter your ThinkPad license key."
    Sub.TextColor3 = Color3.fromRGB(130, 130, 130)
    Sub.Font = Enum.Font.Gotham
    Sub.TextSize = 12
    Sub.TextWrapped = true
    Sub.Parent = Main

    local Box = Instance.new("TextBox")
    Box.Size = UDim2.new(0, 300, 0, 40)
    Box.Position = UDim2.new(0.5, -150, 0, 305)
    Box.BackgroundColor3 = Color3.fromRGB(22, 22, 22)
    Box.TextColor3 = Color3.fromRGB(255, 255, 255)
    Box.PlaceholderText = "Key: thinkpad"
    Box.Text = ""
    Box.Font = Enum.Font.Gotham
    Box.Parent = Main
    Instance.new("UICorner", Box)

    local Submit = Instance.new("TextButton")
    Submit.Size = UDim2.new(0, 300, 0, 40)
    Submit.Position = UDim2.new(0.5, -150, 0, 350) -- Moved for clarity
    Submit.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    Submit.Text = "VERIFY ACCESS"
    Submit.TextColor3 = Color3.fromRGB(255, 255, 255)
    Submit.Font = Enum.Font.GothamBold
    Submit.TextSize = 14
    Submit.Parent = Main
    Instance.new("UICorner", Submit)

    local Footer = Instance.new("TextLabel")
    Footer.Size = UDim2.new(1, 0, 0, 20)
    Footer.Position = UDim2.new(0, 0, 1, 15) -- Slightly below the frame
    Footer.BackgroundTransparency = 1
    Footer.Text = "julzmon hub v5 | Rivals Only"
    Footer.TextColor3 = Color3.fromRGB(60, 60, 60)
    Footer.Font = Enum.Font.Gotham
    Footer.TextSize = 10
    Footer.Parent = Main

    -- Auth Logic
    Submit.MouseButton1Click:Connect(function()
        if Box.Text == "thinkpad" then
            Submit.Text = "GRANTED"
            Submit.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
            task.wait(0.5)
            KeyGui:Destroy()
            LoadJulzHub()
        else
            Submit.Text = "INVALID"
            Submit.BackgroundColor3 = Color3.fromRGB(30, 10, 10)
            task.wait(1)
            Submit.Text = "VERIFY ACCESS"
            Submit.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
        end
    end)
end

-- Start Script
StartAuth()
