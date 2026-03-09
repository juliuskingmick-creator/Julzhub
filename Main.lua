local CorrectKey = "JULZTHEPWN"
local WrongAttempts = 0 
local DiscordLink = "https://discord.gg/cukP3aqCe"

-- 1. CREATE THE LOGIN UI
local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local TextBox = Instance.new("TextBox")
local SubmitBtn = Instance.new("TextButton")
local GetKeyBtn = Instance.new("TextButton")
local Title = Instance.new("TextLabel")
local UICorner = Instance.new("UICorner") -- For rounded edges
local UIGradient = Instance.new("UIGradient") -- For the Amethyst effect

ScreenGui.Parent = game.CoreGui
ScreenGui.Name = "KeySystemUI"

-- Main Login Box
MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255) -- Base for gradient
MainFrame.Position = UDim2.new(0.5, -125, 0.5, -90)
MainFrame.Size = UDim2.new(0, 250, 0, 180)
MainFrame.Active = true
MainFrame.Draggable = true 

-- Rounded Corners for a modern look
UICorner.CornerRadius = UDim.new(0, 10)
UICorner.Parent = MainFrame

-- THE AMETHYST GRADIENT (Dark Blue -> White Splash -> Amethyst Purple)
UIGradient.Parent = MainFrame
UIGradient.Rotation = 45 -- Diagonal splash
UIGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(15, 15, 50)),    -- Dark Blue
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 255, 255)), -- White Splash
    ColorSequenceKeypoint.new(1, Color3.fromRGB(153, 50, 204))   -- Amethyst Purple
})

-- Title (Semi-transparent background so the purple shows through)
Title.Parent = MainFrame
Title.Size = UDim2.new(1, 0, 0, 40)
Title.Text = "JULZ HUB LOGIN"
Title.TextColor3 = Color3.new(1, 1, 1)
Title.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Title.BackgroundTransparency = 0.6
Title.Font = Enum.Font.GothamBold
Title.TextSize = 18

-- Rounded Corners for Title
local TitleCorner = Instance.new("UICorner", Title)
TitleCorner.CornerRadius = UDim.new(0, 10)

-- Text Input
TextBox.Parent = MainFrame
TextBox.Position = UDim2.new(0.1, 0, 0.3, 0)
TextBox.Size = UDim2.new(0.8, 0, 0, 30)
TextBox.PlaceholderText = "Enter Key Here..."
TextBox.Text = ""
TextBox.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
TextBox.BackgroundTransparency = 0.5
TextBox.TextColor3 = Color3.new(1, 1, 1)
TextBox.Font = Enum.Font.Gotham

-- Submit Button
SubmitBtn.Parent = MainFrame
SubmitBtn.Position = UDim2.new(0.1, 0, 0.55, 0)
SubmitBtn.Size = UDim2.new(0.8, 0, 0, 30)
SubmitBtn.Text = "LOGIN"
SubmitBtn.BackgroundColor3 = Color3.fromRGB(153, 50, 204) -- Purple
SubmitBtn.TextColor3 = Color3.new(1, 1, 1)
SubmitBtn.Font = Enum.Font.GothamBold

-- Get Key Button
GetKeyBtn.Parent = MainFrame
GetKeyBtn.Position = UDim2.new(0.1, 0, 0.78, 0)
GetKeyBtn.Size = UDim2.new(0.8, 0, 0, 30)
GetKeyBtn.Text = "GET KEY (DISCORD)"
GetKeyBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 150) -- Dark Blue
GetKeyBtn.TextColor3 = Color3.new(1, 1, 1)
GetKeyBtn.Font = Enum.Font.GothamBold

-- 2. LOGIC (KICK & LOGIN)
GetKeyBtn.MouseButton1Click:Connect(function()
    setclipboard(DiscordLink)
    GetKeyBtn.Text = "LINK COPIED!"
    wait(2)
    GetKeyBtn.Text = "GET KEY (DISCORD)"
end)

SubmitBtn.MouseButton1Click:Connect(function()
    if TextBox.Text == CorrectKey then
        ScreenGui:Destroy() 
        
        local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
        local Window = Rayfield:CreateWindow({
           Name = "Julz Hub | Mobile",
           LoadingTitle = "Key Verified!",
           LoadingSubtitle = "Welcome back",
           KeySystem = false 
        })

        local MainTab = Window:CreateTab("Main 🏠", 4483362458) 
        MainTab:CreateButton({
           Name = "Get TP Tool (Click to TP)",
           Callback = function()
               local mouse = game.Players.LocalPlayer:GetMouse()
               local tool = Instance.new("Tool")
               tool.RequiresHandle = false
               tool.Name = "Click TP"
               tool.Activated:Connect(function()
                   game.Players.LocalPlayer.Character:MoveTo(mouse.Hit.Position + Vector3.new(0, 3, 0))
               end)
               tool.Parent = game.Players.LocalPlayer.Backpack
           end,
        })

        local ScriptTab = Window:CreateTab("Scripts 📜", 4483362458)
        ScriptTab:CreateButton({ Name = "Talentless", Callback = function() loadstring(game:HttpGet("https://egirlswow.pages.dev/cracks/talentless"))() end })
        ScriptTab:CreateButton({ Name = "JJS Script", Callback = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/Idontknowhowtotype/SMN2/refs/heads/main/Main.lua", true))() end })
        ScriptTab:CreateButton({ Name = "Jango Premium (Universal)", Callback = function() loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-jango-premium-crack-131377"))() end })
        ScriptTab:CreateButton({ Name = "Infinite Yield", Callback = function() loadstring(game:HttpGet('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source'))() end })
    else
        WrongAttempts = WrongAttempts + 1
        if WrongAttempts >= 2 then
            game.Players.LocalPlayer:Kick("❌ Kicked: Invalid Key (2/2 attempts).")
        else
            SubmitBtn.Text = "WRONG! (1/2 TRIES)"
            SubmitBtn.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
            wait(1.5)
            SubmitBtn.Text = "TRY AGAIN"
            SubmitBtn.BackgroundColor3 = Color3.fromRGB(153, 50, 204)
        end
    end
end)
