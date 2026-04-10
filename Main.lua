--[[
    JULZHUB | RIVALS ONLY
    Developed by: julzmon
    Library: Luna UI
    Target Game: Rivals (Roblox)
]]

local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

-- UI Library Boot
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/shlexsoftware/Luna/main/source.lua"))()

-- ==========================================
-- MAIN SCRIPT LOGIC (LOADS AFTER KEY)
-- ==========================================
local function LoadJulzHub()
    local Window = Library:CreateWindow({
        Name = "JulzHub | Rivals Only",
        Subtitle = "Developer: julzmon",
        Logo = "rbxassetid://16255151491", -- Mimi Icon
        ConfigFolder = "JulzHub_Rivals_Configs"
    })

    -- 1. RAGE COMBAT
    local RageTab = Window:CreateTab({ Name = "Rage Combat", Icon = "rbxassetid://10734950309" })
    RageTab:CreateSection("Blatant Modules")
    RageTab:CreateToggle({ Name = "Silent Aim", Callback = function(v) print("Feature Activated: Silent Aim") end })
    RageTab:CreateToggle({ Name = "Kill Aura (Melee)", Callback = function(v) print("Feature Activated: Kill Aura") end })
    RageTab:CreateToggle({ Name = "Rapid Fire", Callback = function(v) print("Feature Activated: Rapid Fire") end })
    RageTab:CreateToggle({ Name = "Auto-Wall", Callback = function(v) print("Feature Activated: Auto-Wall") end })
    RageTab:CreateToggle({ Name = "Double Tap", Callback = function(v) print("Feature Activated: Double Tap") end })
    RageTab:CreateSlider({ Name = "Hitbox Extender", Min = 1, Max = 15, CurrentValue = 1, Callback = function(v) print("Feature Activated: Hitbox Size") end })
    RageTab:CreateToggle({ Name = "No Spread", Callback = function(v) print("Feature Activated: No Spread") end })
    RageTab:CreateToggle({ Name = "No Recoil", Callback = function(v) print("Feature Activated: No Recoil") end })
    RageTab:CreateToggle({ Name = "Auto-Reload", Callback = function(v) print("Feature Activated: Auto-Reload") end })
    RageTab:CreateButton({ Name = "Instant Kill Players", Callback = function() print("Feature Activated: Attempting Kill All") end })

    -- 2. LEGIT COMBAT
    local LegitTab = Window:CreateTab({ Name = "Legit Combat", Icon = "rbxassetid://10734950309" })
    LegitTab:CreateSection("Closet Cheating")
    LegitTab:CreateToggle({ Name = "Aimbot", Callback = function(v) print("Feature Activated: Aimbot") end })
    LegitTab:CreateSlider({ Name = "Smoothness", Min = 1, Max = 10, CurrentValue = 5, Callback = function(v) print("Feature Activated: Smoothness") end })
    LegitTab:CreateSlider({ Name = "FOV Radius", Min = 30, Max = 500, CurrentValue = 100, Callback = function(v) print("Feature Activated: FOV") end })
    LegitTab:CreateToggle({ Name = "Show FOV Circle", Callback = function(v) print("Feature Activated") end })
    LegitTab:CreateToggle({ Name = "Triggerbot", Callback = function(v) print("Feature Activated: Trigger") end })
    LegitTab:CreateSlider({ Name = "Trigger Delay (ms)", Min = 0, Max = 500, CurrentValue = 50, Callback = function(v) print("Feature Activated") end })
    LegitTab:CreateDropdown({ Name = "Target Part", Options = {"Head", "Torso", "Random"}, Callback = function(v) print("Feature Activated: " .. v) end })
    LegitTab:CreateToggle({ Name = "Visible Check Only", Callback = function(v) print("Feature Activated") end })
    LegitTab:CreateToggle({ Name = "Ignore Teammates", Callback = function(v) print("Feature Activated") end })
    LegitTab:CreateToggle({ Name = "Dynamic FOV", Callback = function(v) print("Feature Activated") end })

    -- 3. VISUALS (PLAYERS)
    local VisualsTab = Window:CreateTab({ Name = "Visuals", Icon = "rbxassetid://10734897102" })
    VisualsTab:CreateSection("ESP Settings")
    VisualsTab:CreateToggle({ Name = "Enable ESP", Callback = function(v) print("Feature Activated: ESP Master") end })
    VisualsTab:CreateToggle({ Name = "Boxes", Callback = function(v) print("Feature Activated") end })
    VisualsTab:CreateToggle({ Name = "Skeletons", Callback = function(v) print("Feature Activated") end })
    VisualsTab:CreateToggle({ Name = "Names", Callback = function(v) print("Feature Activated") end })
    VisualsTab:CreateToggle({ Name = "Distance", Callback = function(v) print("Feature Activated") end })
    VisualsTab:CreateToggle({ Name = "Health Bars", Callback = function(v) print("Feature Activated") end })
    VisualsTab:CreateToggle({ Name = "Tracer Lines", Callback = function(v) print("Feature Activated") end })
    VisualsTab:CreateToggle({ Name = "Chams (Glow)", Callback = function(v) print("Feature Activated") end })
    VisualsTab:CreateToggle({ Name = "Weapon Display", Callback = function(v) print("Feature Activated") end })
    VisualsTab:CreateToggle({ Name = "Offscreen Indicators", Callback = function(v) print("Feature Activated") end })

    -- 4. MOVEMENT
    local MoveTab = Window:CreateTab({ Name = "Movement", Icon = "rbxassetid://10747373176" })
    MoveTab:CreateSection("Physics Manipulation")
    MoveTab:CreateSlider({ Name = "Speed Multiplier", Min = 16, Max = 150, CurrentValue = 16, Callback = function(v) print("Feature Activated: Speed") end })
    MoveTab:CreateSlider({ Name = "Jump Power", Min = 50, Max = 250, CurrentValue = 50, Callback = function(v) print("Feature Activated: Jump") end })
    MoveTab:CreateToggle({ Name = "Infinite Jump", Callback = function(v) print("Feature Activated") end })
    MoveTab:CreateToggle({ Name = "Fly Mode", Callback = function(v) print("Feature Activated") end })
    MoveTab:CreateToggle({ Name = "No-Clip", Callback = function(v) print("Feature Activated") end })
    MoveTab:CreateToggle({ Name = "Bunny Hop", Callback = function(v) print("Feature Activated") end })
    MoveTab:CreateToggle({ Name = "Anti-Fall", Callback = function(v) print("Feature Activated") end })
    MoveTab:CreateToggle({ Name = "Spin Bot", Callback = function(v) print("Feature Activated") end })
    MoveTab:CreateToggle({ Name = "Auto-Sprint", Callback = function(v) print("Feature Activated") end })
    MoveTab:CreateToggle({ Name = "Walk On Water", Callback = function(v) print("Feature Activated") end })

    -- 5. WORLD & UTILS
    local WorldTab = Window:CreateTab({ Name = "World", Icon = "rbxassetid://10734947300" })
    WorldTab:CreateSection("Environment")
    WorldTab:CreateToggle({ Name = "Fullbright", Callback = function(v) print("Feature Activated") end })
    WorldTab:CreateToggle({ Name = "Remove Map Props", Callback = function(v) print("Feature Activated") end })
    WorldTab:CreateToggle({ Name = "Bullet Tracers", Callback = function(v) print("Feature Activated") end })
    WorldTab:CreateToggle({ Name = "Custom Skybox", Callback = function(v) print("Feature Activated") end })
    WorldTab:CreateToggle({ Name = "Third Person", Callback = function(v) print("Feature Activated") end })
    WorldTab:CreateButton({ Name = "Server Hop", Callback = function() print("Feature Activated") end })
    WorldTab:CreateButton({ Name = "Rejoin Server", Callback = function() print("Feature Activated") end })
    WorldTab:CreateToggle({ Name = "Auto-Queue Match", Callback = function(v) print("Feature Activated") end })
    WorldTab:CreateToggle({ Name = "Chat Spam (JulzHub)", Callback = function(v) print("Feature Activated") end })
    WorldTab:CreateToggle({ Name = "Instant Respawn", Callback = function(v) print("Feature Activated") end })

    -- 6. SETTINGS
    local SettingsTab = Window:CreateTab({ Name = "Settings", Icon = "rbxassetid://10734950056" })
    SettingsTab:CreateSection("System")
    SettingsTab:CreateButton({ Name = "Unload Script", Callback = function() Library:Unload() end })
    SettingsTab:CreateButton({ Name = "Copy Discord Link", Callback = function() setclipboard("https://discord.gg/julzhub") end })
    SettingsTab:CreateToggle({ Name = "Streamer Mode", Callback = function(v) print("Feature Activated") end })
    SettingsTab:CreateToggle({ Name = "Performance Mode", Callback = function(v) print("Feature Activated") end })
    SettingsTab:CreateDropdown({ Name = "UI Theme", Options = {"Dark", "Mimi Pink", "ThinkPad Red"}, Callback = function(v) print("Feature Activated") end })

    Library:Init()
end

-- ==========================================
-- KEY SYSTEM WITH MIMI (TYPH OC)
-- ==========================================
local function InitializeKeySystem()
    local KeyGui = Instance.new("ScreenGui")
    KeyGui.Name = "JulzHub_Auth"
    KeyGui.ResetOnSpawn = false
    pcall(function() KeyGui.Parent = CoreGui end)

    local MainFrame = Instance.new("Frame")
    MainFrame.Size = UDim2.new(0, 450, 0, 350)
    MainFrame.Position = UDim2.new(0.5, -225, 0.5, -175)
    MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
    MainFrame.BorderSizePixel = 0
    MainFrame.Parent = KeyGui

    Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 12)
    local Stroke = Instance.new("UIStroke", MainFrame)
    Stroke.Color = Color3.fromRGB(255, 0, 100) -- Mimi Pink Accent
    Stroke.Thickness = 2

    -- Mimi Image (by Typh)
    local MimiImage = Instance.new("ImageLabel")
    MimiImage.Size = UDim2.new(0, 180, 0, 180)
    MimiImage.Position = UDim2.new(0.5, -90, 0, 10)
    MimiImage.BackgroundTransparency = 1
    MimiImage.Image = "rbxassetid://16255151491" -- High quality Mimi (Typh) Asset ID
    MimiImage.Parent = MainFrame

    local Text1 = Instance.new("TextLabel")
    Text1.Size = UDim2.new(1, 0, 0, 30)
    Text1.Position = UDim2.new(0, 0, 0, 200)
    Text1.BackgroundTransparency = 1
    Text1.Text = "um... Can I help you?"
    Text1.TextColor3 = Color3.fromRGB(255, 255, 255)
    Text1.Font = Enum.Font.GothamBold
    Text1.TextSize = 20
    Text1.Parent = MainFrame

    local Text2 = Instance.new("TextLabel")
    Text2.Size = UDim2.new(1, -60, 0, 40)
    Text2.Position = UDim2.new(0, 30, 0, 230)
    Text2.BackgroundTransparency = 1
    Text2.Text = "Unauthorized access detected. Please enter your ThinkPad license key."
    Text2.TextColor3 = Color3.fromRGB(150, 150, 150)
    Text2.Font = Enum.Font.Gotham
    Text2.TextSize = 13
    Text2.TextWrapped = true
    Text2.Parent = MainFrame

    local InputBox = Instance.new("TextBox")
    InputBox.Size = UDim2.new(0, 300, 0, 40)
    InputBox.Position = UDim2.new(0.5, -150, 0, 280)
    InputBox.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    InputBox.TextColor3 = Color3.fromRGB(255, 255, 255)
    InputBox.PlaceholderText = "Key: thinkpad"
    InputBox.Text = ""
    InputBox.Font = Enum.Font.Gotham
    InputBox.Parent = MainFrame
    Instance.new("UICorner", InputBox)

    local SubmitBtn = Instance.new("TextButton")
    SubmitBtn.Size = UDim2.new(0, 40, 0, 40)
    SubmitBtn.Position = UDim2.new(0.5, 160, 0, 280)
    SubmitBtn.BackgroundColor3 = Color3.fromRGB(255, 0, 100)
    SubmitBtn.Text = ">"
    SubmitBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    SubmitBtn.Font = Enum.Font.GothamBold
    SubmitBtn.Parent = MainFrame
    Instance.new("UICorner", SubmitBtn)

    SubmitBtn.MouseButton1Click:Connect(function()
        if InputBox.Text == "thinkpad" then
            SubmitBtn.Text = "✓"
            task.wait(0.5)
            KeyGui:Destroy()
            LoadJulzHub()
        else
            SubmitBtn.Text = "X"
            task.wait(1)
            SubmitBtn.Text = ">"
        end
    end)
end

-- Start
InitializeKeySystem()
