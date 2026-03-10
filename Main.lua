-- [[ CONFIGURATION ]]
local MasterKey = "banditbeater60"
local LinkvertiseKey = "Tent-acoustic-neck eight-adapt-category IX;i4j-n:fLAlIsB KOkW|TAP<upSNLQs"
local MyLinkvertise = "https://linkvertise.com/2419595/dQ836JlqG4QY?o=sharing"
local DiscordServer = "https://discord.gg/cukP3aqCe"

-- [[ GUI SETUP ]]
local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Size = UDim2.new(0, 350, 0, 250) -- Made slightly taller for extra buttons
MainFrame.Position = UDim2.new(0.5, -175, 0.5, -125)
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true

local UICorner = Instance.new("UICorner", MainFrame)
local UIStroke = Instance.new("UIStroke", MainFrame)
UIStroke.Color = Color3.fromRGB(255, 255, 255)
UIStroke.Thickness = 2

-- Title
local Title = Instance.new("TextLabel", MainFrame)
Title.Size = UDim2.new(1, 0, 0, 45)
Title.Text = "JULZ HUB | LOGIN"
Title.TextColor3 = Color3.new(1, 1, 1)
Title.BackgroundTransparency = 1
Title.Font = Enum.Font.GothamBold
Title.TextSize = 20

-- Key Input
local TextBox = Instance.new("TextBox", MainFrame)
TextBox.Size = UDim2.new(0, 300, 0, 45)
TextBox.Position = UDim2.new(0.5, -150, 0.35, -20)
TextBox.PlaceholderText = "Enter Master Key or Linkvertise Key..."
TextBox.Text = ""
TextBox.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
TextBox.TextColor3 = Color3.new(1,1,1)
Instance.new("UICorner", TextBox)

-- [[ BUTTONS ]]

-- 1. Verify Button
local VerifyBtn = Instance.new("TextButton", MainFrame)
VerifyBtn.Size = UDim2.new(0, 145, 0, 35)
VerifyBtn.Position = UDim2.new(0.07, 0, 0.65, 0)
VerifyBtn.Text = "Verify Key"
VerifyBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
VerifyBtn.TextColor3 = Color3.new(1, 1, 1)
Instance.new("UICorner", VerifyBtn)

-- 2. Get Key Button
local GetKeyBtn = Instance.new("TextButton", MainFrame)
GetKeyBtn.Size = UDim2.new(0, 145, 0, 35)
GetKeyBtn.Position = UDim2.new(0.51, 0, 0.65, 0)
GetKeyBtn.Text = "Get Key (Copy)"
GetKeyBtn.BackgroundColor3 = Color3.fromRGB(0, 100, 200)
GetKeyBtn.TextColor3 = Color3.new(1, 1, 1)
Instance.new("UICorner", GetKeyBtn)

-- 3. Join Discord Button
local DiscordBtn = Instance.new("TextButton", MainFrame)
DiscordBtn.Size = UDim2.new(0, 300, 0, 35)
DiscordBtn.Position = UDim2.new(0.5, -150, 0.82, 0)
DiscordBtn.Text = "Join Discord (Copy)"
DiscordBtn.BackgroundColor3 = Color3.fromRGB(88, 101, 242) -- Discord Blurple
DiscordBtn.TextColor3 = Color3.new(1, 1, 1)
Instance.new("UICorner", DiscordBtn)

-- [[ LOGIC ]]

-- Get Key Logic
GetKeyBtn.MouseButton1Click:Connect(function()
    setclipboard(MyLinkvertise)
    GetKeyBtn.Text = "Link Copied!"
    task.wait(2)
    GetKeyBtn.Text = "Get Key (Copy)"
end)

-- Discord Logic
DiscordBtn.MouseButton1Click:Connect(function()
    setclipboard(DiscordServer)
    DiscordBtn.Text = "Discord Link Copied!"
    task.wait(2)
    DiscordBtn.Text = "Join Discord (Copy)"
end)

-- Verify Logic
VerifyBtn.MouseButton1Click:Connect(function()
    if TextBox.Text == MasterKey or TextBox.Text == LinkvertiseKey then
        ScreenGui:Destroy()
        
        -- LOAD THE FULL JULZ HUB
        local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
        local Window = Rayfield:CreateWindow({
           Name = "Julz Hub | V4.5 EMPIRE",
           LoadingTitle = "Mobile Excellence",
           LoadingSubtitle = "by JULZ",
           Theme = "Default"
        })

        -- [TAB: BLOX FRUITS 🏴‍☠️]
        local BloxTab = Window:CreateTab("Blox Fruits 🏴‍☠️", 4483362458)
        BloxTab:CreateButton({ Name = "Redz Hub (Keyless)", Callback = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/realredz/BloxFruits/main/Source.lua"))() end })
        BloxTab:CreateButton({ Name = "Mukuru Hub (Working)", Callback = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/FRX7/X/main/Mukuru.lua"))() end })
        BloxTab:CreateButton({ Name = "Volcano Hub (Sea 3)", Callback = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/RippeR731/Volcano/main/Volcano.lua"))() end })

        -- [TAB: OTHER GAMES]
        local GamesTab = Window:CreateTab("Other Games 🎮", 4483362458)
        GamesTab:CreateButton({ Name = "TSB: Speed Hub X", Callback = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/AhmadV99/Speed-Hub-X/main/Speed%20Hub%20X.lua"))() end })
        GamesTab:CreateButton({ Name = "JJS: SMN2 Main", Callback = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/Idontknowhowtotype/SMN2/refs/heads/main/Main.lua", true))() end })
        GamesTab:CreateButton({ Name = "BABFT: SpectrX Farm", Callback = function() loadstring(game:HttpGet('https://raw.githubusercontent.com/Arhangels-team/SpectreX-Hub/main/babft%20auto%20farm.lua'))() end })

        -- [TAB: PLAYER]
        local PlayerTab = Window:CreateTab("Player 🏃", 4483362458)
        PlayerTab:CreateSlider({ Name = "WalkSpeed", Range = {16, 500}, Increment = 1, CurrentValue = 16, Callback = function(v) game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = v end })
        PlayerTab:CreateButton({ Name = "Infinite Yield", Callback = function() loadstring(game:HttpGet('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source'))() end })

    else
        TextBox.Text = ""
        TextBox.PlaceholderText = "❌ INVALID KEY!"
        task.wait(1.5)
        TextBox.PlaceholderText = "Enter Master Key or Linkvertise Key..."
    end
end)
