-- [[ CONFIGURATION ]]
local CorrectKey = "Tent-acoustic-neck eight-adapt-category IX;i4j-n:fLAlIsB KOkW|TAP<upSNLQs"
local MyLinkvertise = "https://linkvertise.com/2419595/dQ836JlqG4QY?o=sharing"

-- [[ GUI SETUP ]]
local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Size = UDim2.new(0, 350, 0, 200)
MainFrame.Position = UDim2.new(0.5, -175, 0.5, -100)
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true -- Added to make it mobile friendly!

-- UI Elements
local Title = Instance.new("TextLabel", MainFrame)
Title.Size = UDim2.new(1, 0, 0, 40)
Title.Text = "JULZ HUB LOGIN"
Title.TextColor3 = Color3.new(1, 1, 1)
Title.BackgroundTransparency = 1

local TextBox = Instance.new("TextBox", MainFrame)
TextBox.Size = UDim2.new(0, 280, 0, 40)
TextBox.Position = UDim2.new(0.5, -140, 0.4, -20)
TextBox.PlaceholderText = "Paste Key Here..."
TextBox.Text = ""

local VerifyBtn = Instance.new("TextButton", MainFrame)
VerifyBtn.Size = UDim2.new(0, 130, 0, 40)
VerifyBtn.Position = UDim2.new(0.25, -65, 0.75, -20)
VerifyBtn.Text = "Verify Key"
VerifyBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 0)

local GetKeyBtn = Instance.new("TextButton", MainFrame)
GetKeyBtn.Size = UDim2.new(0, 130, 0, 40)
GetKeyBtn.Position = UDim2.new(0.75, -65, 0.75, -20)
GetKeyBtn.Text = "Get Key (Copy)"
GetKeyBtn.BackgroundColor3 = Color3.fromRGB(0, 100, 200)

-- [[ BUTTON LOGIC ]]

-- Logic for "Get Key"
GetKeyBtn.MouseButton1Click:Connect(function()
    if setclipboard then
        setclipboard(MyLinkvertise)
        GetKeyBtn.Text = "Copied to Clipboard!"
        task.wait(2)
        GetKeyBtn.Text = "Get Key (Copy)"
    else
        GetKeyBtn.Text = "Error: Use an Executor"
    end
end)

-- Logic for "Verify"
VerifyBtn.MouseButton1Click:Connect(function()
    if TextBox.Text == CorrectKey then
        ScreenGui:Destroy() -- Close the UI
        
        ----------------------------------------------------
        -- THE NORMAL JULZ HUB (ALL GAMES)
        ----------------------------------------------------
        
        local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
        local Window = Rayfield:CreateWindow({
           Name = "Julz Hub | V4.5 EMPIRE",
           LoadingTitle = "Mobile Excellence",
           LoadingSubtitle = "by JULZ",
           Theme = "Default"
        })

        -- [TAB: BLOX FRUITS 🏴‍☠️]
        local BloxTab = Window:CreateTab("Blox Fruits 🏴‍☠️", 4483362458)
        BloxTab:CreateSection("Keyless Mobile Scripts")
        BloxTab:CreateButton({ Name = "Redz Hub (Keyless)", Callback = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/realredz/BloxFruits/main/Source.lua"))() end })
        BloxTab:CreateButton({ Name = "Min Hub (No Lag)", Callback = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/JonnyCheeser/bloxfruits/main/minhubv4"))() end })
        BloxTab:CreateButton({ Name = "Zaque Hub (Fruit Finder)", Callback = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/Mei2232/ZaqueHub/main/Zaque%20Hub"))() end })
        BloxTab:CreateButton({ Name = "Banana Hub", Callback = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/Nghia11n/Banana-Hub/main/bananahub.lua"))() end })

        -- [TAB: BUILD A BOAT ⛵]
        local BABFTTab = Window:CreateTab("Build A Boat ⛵", 4483362458)
        BABFTTab:CreateButton({ Name = "SpectrX Hub (Auto-Farm)", Callback = function() loadstring(game:HttpGet('https://raw.githubusercontent.com/Arhangels-team/SpectreX-Hub/main/babft%20auto%20farm.lua'))() end })
        BABFTTab:CreateButton({ Name = "Asu Hub (Auto-Builder)", Callback = function() loadstring(game:HttpGet('https://raw.githubusercontent.com/TheRealAsu/BABFT/refs/heads/main/Loader.lua'))() end })

        -- [TAB: TSB 🥋]
        local TSBTab = Window:CreateTab("TSB 🥋", 4483362458)
        TSBTab:CreateButton({ Name = "Speed Hub X (Keyless Kill Farm)", Callback = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/AhmadV99/Speed-Hub-X/main/Speed%20Hub%20X.lua", true))() end })
        TSBTab:CreateButton({ Name = "Vexon Hub (Combat)", Callback = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/DiosDi/VexonHub/refs/heads/main/VexonHub"))() end })

        -- [TAB: JJS 👊]
        local JJSTab = Window:CreateTab("JJS 👊", 4483362458)
        JJSTab:CreateButton({ Name = "SMN2 Main (Auto-Block)", Callback = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/Idontknowhowtotype/SMN2/refs/heads/main/Main.lua", true))() end })
        JJSTab:CreateButton({ Name = "Kajun Hub", Callback = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/Kajun123/KajunHub/main/KajunHub.lua"))() end })

        -- [TAB: UNIVERSAL 🌌]
        local UnivTab = Window:CreateTab("Universal 🌌", 4483362458)
        UnivTab:CreateButton({ Name = "Infinite Yield", Callback = function() loadstring(game:HttpGet('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source'))() end })
        UnivTab:CreateButton({ Name = "Dex Explorer (Mobile)", Callback = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/infyiff/backup/main/dex.lua"))() end })

        -- [TAB: PLAYER 🏃]
        local PlayerTab = Window:CreateTab("Player 🏃", 4483362458)
        PlayerTab:CreateSlider({ Name = "WalkSpeed", Range = {16, 500}, Increment = 1, CurrentValue = 16, Callback = function(v) game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = v end })
        PlayerTab:CreateSlider({ Name = "JumpPower", Range = {50, 500}, Increment = 1, CurrentValue = 50, Callback = function(v) game.Players.LocalPlayer.Character.Humanoid.JumpPower = v end })

        ----------------------------------------------------
    else
        TextBox.Text = ""
        TextBox.PlaceholderText = "INVALID KEY!"
        task.wait(1.5)
        TextBox.PlaceholderText = "Paste Key Here..."
    end
end)
