local CorrectKey = "JULZTHEPWN"
local WrongAttempts = 0 
local DiscordLink = "https://discord.gg/cukP3aqCe"

-- 1. CREATE THE UI (Dark/Gray/White Splashes)
local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local TextBox = Instance.new("TextBox")
local SubmitBtn = Instance.new("TextButton")
local GetKeyBtn = Instance.new("TextButton")
local Title = Instance.new("TextLabel")
local UICorner = Instance.new("UICorner", MainFrame)
local UIGradient = Instance.new("UIGradient", MainFrame)
local UIStroke = Instance.new("UIStroke", MainFrame)

ScreenGui.Parent = game:GetService("CoreGui")
ScreenGui.Name = "JulzKeySystem"

MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
MainFrame.Position = UDim2.new(0.5, -125, 0.5, -90)
MainFrame.Size = UDim2.new(0, 250, 0, 180)
MainFrame.Active = true
MainFrame.Draggable = true 
UICorner.CornerRadius = UDim.new(0, 12)

-- DARK/GRAY/WHITE SPLASH GRADIENT
UIGradient.Rotation = 45 
UIGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(20, 20, 20)),    -- Deep Black
    ColorSequenceKeypoint.new(0.4, Color3.fromRGB(60, 60, 60)),   -- Dark Gray
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 255, 255)),-- White Splash
    ColorSequenceKeypoint.new(0.6, Color3.fromRGB(60, 60, 60)),   -- Dark Gray
    ColorSequenceKeypoint.new(1, Color3.fromRGB(10, 10, 10))     -- Black
})

UIStroke.Thickness = 2
UIStroke.Color = Color3.fromRGB(255, 255, 255)
UIStroke.Transparency = 0.5

Title.Parent = MainFrame
Title.Size = UDim2.new(1, 0, 0, 40)
Title.Text = "JULZ HUB LOGIN"
Title.TextColor3 = Color3.new(1, 1, 1)
Title.BackgroundTransparency = 0.8
Title.BackgroundColor3 = Color3.new(0,0,0)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 16

TextBox.Parent = MainFrame
TextBox.Position = UDim2.new(0.1, 0, 0.32, 0)
TextBox.Size = UDim2.new(0.8, 0, 0, 30)
TextBox.PlaceholderText = "Enter Key..."
TextBox.BackgroundColor3 = Color3.new(0,0,0)
TextBox.BackgroundTransparency = 0.5
TextBox.TextColor3 = Color3.new(1,1,1)
TextBox.Font = Enum.Font.Gotham
Instance.new("UICorner", TextBox).CornerRadius = UDim.new(0, 6)

SubmitBtn.Parent = MainFrame
SubmitBtn.Position = UDim2.new(0.1, 0, 0.55, 0)
SubmitBtn.Size = UDim2.new(0.8, 0, 0, 32)
SubmitBtn.Text = "LOGIN"
SubmitBtn.BackgroundColor3 = Color3.new(0,0,0)
SubmitBtn.BackgroundTransparency = 0.3
SubmitBtn.TextColor3 = Color3.new(1,1,1)
SubmitBtn.Font = Enum.Font.GothamBold
Instance.new("UICorner", SubmitBtn).CornerRadius = UDim.new(0, 6)

GetKeyBtn.Parent = MainFrame
GetKeyBtn.Position = UDim2.new(0.1, 0, 0.78, 0)
GetKeyBtn.Size = UDim2.new(0.8, 0, 0, 30)
GetKeyBtn.Text = "GET KEY (DISCORD)"
GetKeyBtn.BackgroundColor3 = Color3.new(0,0,0)
GetKeyBtn.BackgroundTransparency = 0.3
GetKeyBtn.TextColor3 = Color3.new(1,1,1)
Instance.new("UICorner", GetKeyBtn).CornerRadius = UDim.new(0, 6)

-- 2. LOGIC
GetKeyBtn.MouseButton1Click:Connect(function()
    setclipboard(DiscordLink)
    GetKeyBtn.Text = "LINK COPIED!"
    task.wait(2)
    GetKeyBtn.Text = "GET KEY (DISCORD)"
end)

SubmitBtn.MouseButton1Click:Connect(function()
    if TextBox.Text == CorrectKey then
        ScreenGui:Destroy()
        
        local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
        local Window = Rayfield:CreateWindow({
           Name = "Julz Hub | Dark Edition",
           LoadingTitle = "Welcome Julz",
           LoadingSubtitle = "by Gemini",
           ConfigurationSaving = { Enabled = false },
           KeySystem = false,
           Theme = "Default" -- Back to Dark Mode
        })

        local MainTab = Window:CreateTab("Main 🏠", 4483362458) 

        MainTab:CreateButton({
           Name = "Femboy Morph (R6/R15)",
           Callback = function()
               local char = game.Players.LocalPlayer.Character
               if not char then return end
               local hum = char:FindFirstChildOfClass("Humanoid")
               if not hum then return end

               -- FIXED MORPH LOGIC
               pcall(function()
                   if hum.RigType == Enum.HumanoidRigType.R15 then
                       local desc = hum:GetAppliedDescription()
                       desc.Height, desc.Width, desc.Proportion = 0.85, 0.75, 1
                       desc.Shirt = 6917631589
                       desc.Pants = 7192301130
                       desc.HairAccessory = "14603416757"
                       desc.Face = 12142220
                       hum:ApplyDescription(desc)
                   else
                       -- R6 Manual Swap
                       local s = char:FindFirstChildOfClass("Shirt") or Instance.new("Shirt", char)
                       local p = char:FindFirstChildOfClass("Pants") or Instance.new("Pants", char)
                       s.ShirtTemplate = "rbxassetid://6917631589"
                       p.PantsTemplate = "rbxassetid://7192301130"
                   end
               end)
               
               Rayfield:Notify({Title = "Morph Status", Content = "Attempted to load aesthetic.", Duration = 2})
           end,
        })

        MainTab:CreateButton({
           Name = "Get TP Tool",
           Callback = function()
               local tool = Instance.new("Tool", game.Players.LocalPlayer.Backpack)
               tool.RequiresHandle = false
               tool.Name = "Click TP"
               tool.Activated:Connect(function()
                   game.Players.LocalPlayer.Character:MoveTo(game.Players.LocalPlayer:GetMouse().Hit.Position + Vector3.new(0, 3, 0))
               end)
           end,
        })

        local ScriptTab = Window:CreateTab("Scripts 📜", 4483362458)
        ScriptTab:CreateButton({ Name = "Talentless", Callback = function() loadstring(game:HttpGet("https://egirlswow.pages.dev/cracks/talentless"))() end })
        ScriptTab:CreateButton({ Name = "JJS Script", Callback = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/Idontknowhowtotype/SMN2/refs/heads/main/Main.lua", true))() end })
        ScriptTab:CreateButton({ Name = "Jango Premium", Callback = function() loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-jango-premium-crack-131377"))() end })
        ScriptTab:CreateButton({ Name = "Infinite Yield", Callback = function() loadstring(game:HttpGet('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source'))() end })

    else
        WrongAttempts = WrongAttempts + 1
        if WrongAttempts >= 2 then
            game.Players.LocalPlayer:Kick("❌ Kicked: Invalid Key (2/2)")
        else
            SubmitBtn.Text = "WRONG! (1/2)"
            SubmitBtn.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
            task.wait(1.5)
            SubmitBtn.Text = "LOGIN"
            SubmitBtn.BackgroundColor3 = Color3.new(0,0,0)
        end
    end
end)
