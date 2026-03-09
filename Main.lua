local CorrectKey = "JULZTHEPWN"
local WrongAttempts = 0 
local DiscordLink = "https://discord.gg/cukP3aqCe"

-- ==========================================
-- 1. MOBILE-FRIENDLY LOGIN (DRAGGABLE)
-- ==========================================
local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local TextBox = Instance.new("TextBox")
local SubmitBtn = Instance.new("TextButton")
local GetKeyBtn = Instance.new("TextButton")
local Title = Instance.new("TextLabel")
local UICorner = Instance.new("UICorner", MainFrame)
local UIStroke = Instance.new("UIStroke", MainFrame)

ScreenGui.Parent = game:GetService("CoreGui")
ScreenGui.Name = "JulzKeySystem"

MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
MainFrame.Position = UDim2.new(0.5, -125, 0.5, -90)
MainFrame.Size = UDim2.new(0, 250, 0, 180)
MainFrame.Active = true
MainFrame.Draggable = true 

UICorner.CornerRadius = UDim.new(0, 12)
UIStroke.Thickness = 2
UIStroke.Color = Color3.fromRGB(255, 255, 255)

Title.Parent = MainFrame
Title.Size = UDim2.new(1, 0, 0, 40)
Title.Text = "JULZ HUB V4"
Title.TextColor3 = Color3.new(1, 1, 1)
Title.BackgroundTransparency = 1
Title.Font = Enum.Font.GothamBold
Title.TextSize = 18

TextBox.Parent = MainFrame
TextBox.Position = UDim2.new(0.1, 0, 0.32, 0)
TextBox.Size = UDim2.new(0.8, 0, 0, 30)
TextBox.PlaceholderText = "Enter Key..."
TextBox.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
TextBox.TextColor3 = Color3.new(1,1,1)
Instance.new("UICorner", TextBox)

SubmitBtn.Parent = MainFrame
SubmitBtn.Position = UDim2.new(0.1, 0, 0.55, 0)
SubmitBtn.Size = UDim2.new(0.8, 0, 0, 32)
SubmitBtn.Text = "LOGIN"
SubmitBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
SubmitBtn.TextColor3 = Color3.new(1,1,1)
SubmitBtn.Font = Enum.Font.GothamBold
Instance.new("UICorner", SubmitBtn)

GetKeyBtn.Parent = MainFrame
GetKeyBtn.Position = UDim2.new(0.1, 0, 0.78, 0)
GetKeyBtn.Size = UDim2.new(0.8, 0, 0, 30)
GetKeyBtn.Text = "GET KEY"
GetKeyBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
GetKeyBtn.TextColor3 = Color3.new(1,1,1)
Instance.new("UICorner", GetKeyBtn)

-- ==========================================
-- 2. HUB INITIALIZATION
-- ==========================================
GetKeyBtn.MouseButton1Click:Connect(function()
    setclipboard(DiscordLink)
    GetKeyBtn.Text = "LINK COPIED!"
    task.wait(2)
    GetKeyBtn.Text = "GET KEY"
end)

SubmitBtn.MouseButton1Click:Connect(function()
    if TextBox.Text == CorrectKey then
        ScreenGui:Destroy()
        
        local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
        local Window = Rayfield:CreateWindow({
           Name = "Julz Hub | V4 EMPIRE",
           LoadingTitle = "Mobile Excellence",
           LoadingSubtitle = "by JULZ",
           Theme = "Default"
        })

        -- [TSB - THE STRONGEST BATTLEGROUNDS]
        local TSBTab = Window:CreateTab("TSB 🥋", 4483362458)
        TSBTab:CreateSection("Keyless Kill Farms")
        
        TSBTab:CreateButton({
            Name = "Speed Hub X (Best Keyless Farm)",
            Callback = function()
                loadstring(game:HttpGet("https://raw.githubusercontent.com/AhmadV99/Speed-Hub-X/main/Speed%20Hub%20X.lua", true))()
            end
        })

        TSBTab:CreateButton({
            Name = "Phantasm (Keyless Mobile)",
            Callback = function()
                loadstring(game:HttpGet("https://raw.githubusercontent.com/ATrainz/Phantasm/refs/heads/main/Games/TSB.lua"))()
            end
        })

        TSBTab:CreateButton({
            Name = "Vexon Hub (Universal Combat)",
            Callback = function()
                loadstring(game:HttpGet("https://raw.githubusercontent.com/DiosDi/VexonHub/refs/heads/main/VexonHub"))()
            end
        })

        -- [JJS - JUJUTSU SHENANIGANS]
        local JJSTab = Window:CreateTab("JJS 👊", 4483362458)
        JJSTab:CreateButton({ Name = "SMN2 Main", Callback = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/Idontknowhowtotype/SMN2/refs/heads/main/Main.lua", true))() end })
        JJSTab:CreateButton({ Name = "Kajun Hub", Callback = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/Kajun123/KajunHub/main/KajunHub.lua"))() end })

        -- [BLOX FRUITS]
        local BloxTab = Window:CreateTab("Blox Fruits 🏴‍☠️", 4483362458)
        BloxTab:CreateButton({ Name = "Redz Hub (Best for Mobile)", Callback = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/realredz/BloxFruits/main/Source.lua"))() end })
        BloxTab:CreateButton({ Name = "Alchemy Hub", Callback = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/DeivandSama/AlchemyHub/main/Main.lua"))() end })

        -- [DOORS / HORROR]
        local HorrorTab = Window:CreateTab("Horror 🔦", 4483362458)
        HorrorTab:CreateButton({ Name = "MSPAINT (Doors)", Callback = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/upbolt/mzpaint/main/doors.lua"))() end })

        -- [SHOOTERS / ARSENAL]
        local ShooterTab = Window:CreateTab("Shooters 🔫", 4483362458)
        ShooterTab:CreateButton({ Name = "Thunder Z", Callback = function() loadstring(game:HttpGet('https://raw.githubusercontent.com/ThunderZ-Hub/HUB/main/Arsenal'))() end })

        -- [UNIVERSAL]
        local UnivTab = Window:CreateTab("Universal 🌌", 4483362458)
        UnivTab:CreateButton({ Name = "Infinite Yield", Callback = function() loadstring(game:HttpGet('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source'))() end })
        UnivTab:CreateButton({ Name = "Dex Explorer (Mobile)", Callback = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/infyiff/backup/main/dex.lua"))() end })

        -- [PLAYER]
        local PlayerTab = Window:CreateTab("Player 🏃", 4483362458)
        PlayerTab:CreateSlider({ Name = "Speed", Range = {16, 300}, Increment = 1, CurrentValue = 16, Callback = function(v) game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = v end })
        
    else
        WrongAttempts = WrongAttempts + 1
        if WrongAttempts >= 2 then
            game.Players.LocalPlayer:Kick("❌ Invalid Key.")
        else
            SubmitBtn.Text = "WRONG! (1/2)"
            task.wait(1.5)
            SubmitBtn.Text = "LOGIN"
        end
    end
end)
