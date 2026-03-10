-- [[ CONFIGURATION ]]
local MasterKey = "banditbeater60"
local LinkvertiseKey = "Tent-acoustic-neck eight-adapt-category IX;i4j-n:fLAlIsB KOkW|TAP<upSNLQs"
local MyLinkvertise = "https://linkvertise.com/2419595/dQ836JlqG4QY?o=sharing"
local DiscordServer = "https://discord.gg/cukP3aqCe"

-- [[ CLEAN UI SETUP ]]
local ScreenGui = Instance.new("ScreenGui", game:GetService("CoreGui"))
local MainFrame = Instance.new("Frame", ScreenGui)
local UICorner = Instance.new("UICorner", MainFrame)
local UIStroke = Instance.new("UIStroke", MainFrame)

MainFrame.Name = "JulzLogin"
MainFrame.Size = UDim2.new(0, 320, 0, 260)
MainFrame.Position = UDim2.new(0.5, -160, 0.5, -130)
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
MainFrame.Active = true
MainFrame.Draggable = true -- Essential for Mobile

UICorner.CornerRadius = UDim.new(0, 10)
UIStroke.Color = Color3.fromRGB(255, 255, 255)
UIStroke.Thickness = 1.5

-- Title
local Title = Instance.new("TextLabel", MainFrame)
Title.Size = UDim2.new(1, 0, 0, 40)
Title.Text = "JULZ HUB V4.5"
Title.TextColor3 = Color3.new(1, 1, 1)
Title.BackgroundTransparency = 1
Title.Font = Enum.Font.GothamBold
Title.TextSize = 18

-- Status Label (Feedback for User)
local Status = Instance.new("TextLabel", MainFrame)
Status.Size = UDim2.new(1, 0, 0, 20)
Status.Position = UDim2.new(0, 0, 0.88, 0)
Status.Text = "Waiting for key..."
Status.TextColor3 = Color3.fromRGB(150, 150, 150)
Status.BackgroundTransparency = 1
Status.Font = Enum.Font.Gotham
Status.TextSize = 12

-- Input Box
local TextBox = Instance.new("TextBox", MainFrame)
TextBox.Size = UDim2.new(0, 260, 0, 40)
TextBox.Position = UDim2.new(0.5, -130, 0.3, 0)
TextBox.PlaceholderText = "Enter Key Here..."
TextBox.Text = ""
TextBox.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
TextBox.TextColor3 = Color3.new(1, 1, 1)
Instance.new("UICorner", TextBox)

-- [[ BUTTON SYSTEM ]]
local function CreateBtn(name, pos, color, callback)
    local btn = Instance.new("TextButton", MainFrame)
    btn.Size = UDim2.new(0, 125, 0, 35)
    btn.Position = pos
    btn.Text = name
    btn.BackgroundColor3 = color
    btn.TextColor3 = Color3.new(1, 1, 1)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 12
    Instance.new("UICorner", btn)
    btn.MouseButton1Click:Connect(callback)
    return btn
end

-- 1. Verify
CreateBtn("VERIFY", UDim2.new(0.08, 0, 0.52, 0), Color3.fromRGB(0, 170, 0), function()
    if TextBox.Text == MasterKey or TextBox.Text == LinkvertiseKey then
        Status.Text = "✅ SUCCESS! LOADING..."
        Status.TextColor3 = Color3.new(0, 1, 0)
        task.wait(1)
        ScreenGui:Destroy()
        
        -- LOAD RAYFIELD HUB
        local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
        local Window = Rayfield:CreateWindow({
           Name = "Julz Hub | V4.5",
           LoadingTitle = "Empire Loading...",
           LoadingSubtitle = "by JULZ",
           Theme = "Default"
        })

        local MainTab = Window:CreateTab("Blox Fruits 🏴‍☠️")
        MainTab:CreateButton({Name = "Redz Hub", Callback = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/realredz/BloxFruits/main/Source.lua"))() end})
        MainTab:CreateButton({Name = "Mukuru Hub", Callback = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/FRX7/X/main/Mukuru.lua"))() end})

        local GamesTab = Window:CreateTab("Other 🎮")
        GamesTab:CreateButton({Name = "TSB: Speed Hub X", Callback = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/AhmadV99/Speed-Hub-X/main/Speed%20Hub%20X.lua"))() end})
        GamesTab:CreateButton({Name = "JJS: SMN2", Callback = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/Idontknowhowtotype/SMN2/refs/heads/main/Main.lua", true))() end})

        local PlayerTab = Window:CreateTab("Player 🏃")
        PlayerTab:CreateSlider({Name = "WalkSpeed", Range = {16, 500}, Increment = 1, CurrentValue = 16, Callback = function(v) game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = v end})
    else
        Status.Text = "❌ INVALID KEY!"
        Status.TextColor3 = Color3.new(1, 0, 0)
        TextBox.Text = ""
        task.wait(2)
        Status.Text = "Waiting for key..."
        Status.TextColor3 = Color3.fromRGB(150, 150, 150)
    end
end)

-- 2. Get Key
CreateBtn("GET KEY", UDim2.new(0.53, 0, 0.52, 0), Color3.fromRGB(0, 120, 255), function()
    setclipboard(MyLinkvertise)
    Status.Text = "Linkvertise Copied!"
end)

-- 3. Discord
local Disc = CreateBtn("JOIN DISCORD", UDim2.new(0.08, 0, 0.72, 0), Color3.fromRGB(88, 101, 242), function()
    setclipboard(DiscordServer)
    Status.Text = "Discord Link Copied!"
end)
Disc.Size =
