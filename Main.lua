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
local UICorner = Instance.new("UICorner", MainFrame)
local UIGradient = Instance.new("UIGradient", MainFrame)

ScreenGui.Parent = game.CoreGui
MainFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
MainFrame.Position = UDim2.new(0.5, -125, 0.5, -90)
MainFrame.Size = UDim2.new(0, 250, 0, 180)
MainFrame.Active = true
MainFrame.Draggable = true 
UICorner.CornerRadius = UDim.new(0, 10)

UIGradient.Rotation = 45
UIGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(15, 15, 50)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 255, 255)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(153, 50, 204))
})

Title.Parent = MainFrame
Title.Size = UDim2.new(1, 0, 0, 40)
Title.Text = "JULZ HUB LOGIN"
Title.TextColor3 = Color3.new(1, 1, 1)
Title.BackgroundTransparency = 0.6
Title.BackgroundColor3 = Color3.new(0,0,0)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 18

TextBox.Parent = MainFrame
TextBox.Position = UDim2.new(0.1, 0, 0.3, 0)
TextBox.Size = UDim2.new(0.8, 0, 0, 30)
TextBox.PlaceholderText = "Enter Key..."
TextBox.BackgroundTransparency = 0.5
TextBox.BackgroundColor3 = Color3.new(0,0,0)
TextBox.TextColor3 = Color3.new(1,1,1)

SubmitBtn.Parent = MainFrame
SubmitBtn.Position = UDim2.new(0.1, 0, 0.55, 0)
SubmitBtn.Size = UDim2.new(0.8, 0, 0, 30)
SubmitBtn.Text = "LOGIN"
SubmitBtn.BackgroundColor3 = Color3.fromRGB(153, 50, 204)
SubmitBtn.TextColor3 = Color3.new(1,1,1)
SubmitBtn.Font = Enum.Font.GothamBold

GetKeyBtn.Parent = MainFrame
GetKeyBtn.Position = UDim2.new(0.1, 0, 0.78, 0)
GetKeyBtn.Size = UDim2.new(0.8, 0, 0, 30)
GetKeyBtn.Text = "GET KEY (DISCORD)"
GetKeyBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 150)
GetKeyBtn.TextColor3 = Color3.new(1,1,1)

-- LOGIC
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
           LoadingTitle = "Welcome Julz",
           LoadingSubtitle = "Amethyst Edition",
           KeySystem = false 
        })

        -- MAIN TAB
        local MainTab = Window:CreateTab("Main 🏠", 4483362458) 

        MainTab:CreateButton({
           Name = "Femboy Morph (R15 Only)",
           Callback = function()
               local char = game.Players.LocalPlayer.Character
               local hum = char:WaitForChild("Humanoid")
               local desc = hum:GetAppliedDescription()
               
               -- Aesthetic Scaling
               desc.Height = 0.85
               desc.Width = 0.75
               desc.Proportion = 1
               
               -- Clothing & Hair IDs (Pink/Soft Style)
               desc.Shirt = 6917631589
               desc.Pants = 7192301130
               desc.HairAccessory = "14603416757"
               desc.Face = 12142220
               
               hum:ApplyDescription(desc)
               Rayfield:Notify({Title = "Success", Content = "Morph Applied!", Duration = 2})
           end,
        })

        MainTab:CreateButton({
           Name = "Get TP Tool",
           Callback = function()
               local mouse = game.Players.LocalPlayer:GetMouse()
               local tool = Instance.new("Tool", game.Players.LocalPlayer.Backpack)
               tool.RequiresHandle = false
               tool.Name = "Click TP"
               tool.Activated:Connect(function()
                   game.Players.LocalPlayer.Character:MoveTo(mouse.Hit.Position + Vector3.new(0, 3, 0))
               end)
           end,
        })

        -- SCRIPTS TAB
        local ScriptTab = Window:CreateTab("Scripts 📜", 4483362458)
        ScriptTab:CreateButton({ Name = "Talentless", Callback = function() loadstring(game:HttpGet("https://egirlswow.pages.dev/cracks/talentless"))() end })
        ScriptTab:CreateButton({ Name = "JJS Script", Callback = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/Idontknowhowtotype/SMN2/refs/heads/main/Main.lua", true))() end })
        ScriptTab:CreateButton({ Name = "Jango Premium", Callback = function() loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-jango-premium-crack-131377"))() end })
        ScriptTab:CreateButton({ Name = "Infinite Yield", Callback = function() loadstring(game:HttpGet('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source'))() end })

    else
        WrongAttempts = WrongAttempts + 1
        if WrongAttempts >= 2 then
            game.Players.LocalPlayer:Kick("❌ Invalid Key (2/2)")
        else
            SubmitBtn.Text = "WRONG! (1/2)"
            SubmitBtn.BackgroundColor3 = Color3.new(1,0,0)
            wait(1.5)
            SubmitBtn.Text = "LOGIN"
            SubmitBtn.BackgroundColor3 = Color3.fromRGB(153, 50, 204)
        end
    end
end)
