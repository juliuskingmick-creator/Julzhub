local CorrectKey = "JULZTHEPWN"
local WrongAttempts = 0 
local DiscordLink = "https://discord.gg/cukP3aqCe"

-- 1. CREATE THE UI
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

-- LIGHT DOMAIN CLASH GRADIENT
UIGradient.Rotation = 0 
UIGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(100, 200, 255)),   -- Void Blue
    ColorSequenceKeypoint.new(0.45, Color3.fromRGB(200, 150, 255)),-- Purple
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 255, 255)), -- Clash Spark
    ColorSequenceKeypoint.new(0.55, Color3.fromRGB(255, 100, 100)),-- Shrine Red
    ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 200, 200))    -- Soft Red
})

UIStroke.Thickness = 2
UIStroke.Color = Color3.fromRGB(255, 255, 255)

Title.Parent = MainFrame
Title.Size = UDim2.new(1, 0, 0, 40)
Title.Text = "DOMAIN CLASH LOGIN"
Title.TextColor3 = Color3.fromRGB(40, 40, 40)
Title.BackgroundTransparency = 0.9
Title.BackgroundColor3 = Color3.new(1,1,1)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 16

TextBox.Parent = MainFrame
TextBox.Position = UDim2.new(0.1, 0, 0.32, 0)
TextBox.Size = UDim2.new(0.8, 0, 0, 30)
TextBox.PlaceholderText = "Enter Key..."
TextBox.BackgroundColor3 = Color3.new(1,1,1)
TextBox.BackgroundTransparency = 0.3
TextBox.TextColor3 = Color3.fromRGB(0,0,0)
TextBox.Font = Enum.Font.Gotham
Instance.new("UICorner", TextBox).CornerRadius = UDim.new(0, 6)

SubmitBtn.Parent = MainFrame
SubmitBtn.Position = UDim2.new(0.1, 0, 0.55, 0)
SubmitBtn.Size = UDim2.new(0.8, 0, 0, 32)
SubmitBtn.Text = "EXPAND DOMAIN"
SubmitBtn.BackgroundColor3 = Color3.new(1,1,1)
SubmitBtn.BackgroundTransparency = 0.1
SubmitBtn.TextColor3 = Color3.fromRGB(40, 40, 40)
SubmitBtn.Font = Enum.Font.GothamBold
Instance.new("UICorner", SubmitBtn).CornerRadius = UDim.new(0, 6)

GetKeyBtn.Parent = MainFrame
GetKeyBtn.Position = UDim2.new(0.1, 0, 0.78, 0)
GetKeyBtn.Size = UDim2.new(0.8, 0, 0, 30)
GetKeyBtn.Text = "GET KEY (DISCORD)"
GetKeyBtn.BackgroundColor3 = Color3.new(1,1,1)
GetKeyBtn.BackgroundTransparency = 0.1
GetKeyBtn.TextColor3 = Color3.fromRGB(40, 40, 40)
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
        
        -- LOAD RAYFIELD WITH ERROR CHECKING
        local success, Rayfield = pcall(function()
            return loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
        end)

        if not success then 
            warn("Rayfield failed to load: " .. tostring(Rayfield))
            return 
        end

        local Window = Rayfield:CreateWindow({
           Name = "Julz Hub | Light Edition",
           LoadingTitle = "Domain Expansion Authenticated",
           LoadingSubtitle = "by Gemini",
           ConfigurationSaving = { Enabled = false },
           KeySystem = false,
           Theme = "Light" -- Forces White Mode
        })

        local MainTab = Window:CreateTab("Main 🏠", 4483362458) 

        MainTab:CreateButton({
           Name = "Femboy Morph (R6/R15)",
           Callback = function()
               local char = game.Players.LocalPlayer.Character
               local hum = char:WaitForChild("Humanoid")
               if hum.RigType == Enum.HumanoidRigType.R15 then
                   local desc = hum:GetAppliedDescription()
                   desc.Height, desc.Width, desc.Proportion = 0.85, 0.75, 1
                   desc.Shirt, desc.Pants = 6917631589, 7192301130
                   desc.HairAccessory, desc.Face = "14603416757", 12142220
                   hum:ApplyDescription(desc)
               else
                   char:FindFirstChildOfClass("Shirt").ShirtTemplate = "rbxassetid://6917631589"
                   char:FindFirstChildOfClass("Pants").PantsTemplate = "rbxassetid://7192301130"
               end
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
            game.Players.LocalPlayer:Kick("❌ Kicked: Invalid Cursed Key.")
        else
            SubmitBtn.Text = "WRONG! (1/2)"
            SubmitBtn.BackgroundColor3 = Color3.fromRGB(255, 150, 150)
            task.wait(1.5)
            SubmitBtn.Text = "EXPAND DOMAIN"
            SubmitBtn.BackgroundColor3 = Color3.new(1,1,1)
        end
    end
end)
