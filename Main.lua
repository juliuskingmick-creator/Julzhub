local CorrectKey = "JULZTHEPWN"
local WrongAttempts = 0 
local DiscordLink = "https://discord.gg/cukP3aqCe"

-- ==========================================
-- 1. MOBILE-FRIENDLY LOGIN (JULZ EDITION)
-- ==========================================
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

UIGradient.Rotation = 45 
UIGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(20, 20, 20)),
    ColorSequenceKeypoint.new(0.4, Color3.fromRGB(60, 60, 60)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 255, 255)),
    ColorSequenceKeypoint.new(0.6, Color3.fromRGB(60, 60, 60)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(10, 10, 10))
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

-- ==========================================
-- 2. MAIN HUB (MOBILE OPTIMIZED)
-- ==========================================
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
           Name = "Julz Hub | V3 Ultimate",
           LoadingTitle = "Authenticating...",
           LoadingSubtitle = "by JULZ",
           ConfigurationSaving = { Enabled = false },
           KeySystem = false,
           Theme = "Default"
        })

        Rayfield:Notify({
            Title = "Welcome, " .. game.Players.LocalPlayer.DisplayName .. "!",
            Content = "Successfully logged into Julz Hub.",
            Duration = 5,
        })

        -- [UNIVERSAL]
        local UnivTab = Window:CreateTab("Universal 🌌", 4483362458)
        UnivTab:CreateButton({ Name = "Infinite Yield", Callback = function() loadstring(game:HttpGet('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source'))() end })
        UnivTab:CreateButton({ Name = "CMD-X", Callback = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/CMD-X/CMD-X/master/Source", true))() end })
        UnivTab:CreateButton({ Name = "SimpleSpy (Mobile)", Callback = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/exxtremestuffs/SimpleSpySource/master/SimpleSpy.lua"))() end })

        -- [JJS - JUJUTSU SHENANIGANS]
        local JJSTab = Window:CreateTab("JJS 👊", 4483362458)
        JJSTab:CreateButton({ 
            Name = "SMN2 Main Script (NEW)", 
            Callback = function() 
                loadstring(game:HttpGet("https://raw.githubusercontent.com/Idontknowhowtotype/SMN2/refs/heads/main/Main.lua", true))() 
            end 
        })
        JJSTab:CreateButton({ Name = "Kajun Hub", Callback = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/Kajun123/KajunHub/main/KajunHub.lua"))() end })
        JJSTab:CreateButton({ Name = "Talentless Crack", Callback = function() loadstring(game:HttpGet("https://egirlswow.pages.dev/cracks/talentless"))() end })
        
        -- [BEDWARS]
        local BedwarsTab = Window:CreateTab("Bedwars 🛏️", 4483362458)
        BedwarsTab:CreateButton({ Name = "Vape V4 Mobile", Callback = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/7GrandDadPGN/VapeV4ForRoblox/main/NewMainScript.lua", true))() end })

        -- [BLOX FRUITS]
        local BloxTab = Window:CreateTab("Blox Fruits 🏴‍☠️", 4483362458)
        BloxTab:CreateButton({ Name = "Redz Hub (Mobile Best)", Callback = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/realredz/BloxFruits/main/Source.lua"))() end })
        BloxTab:CreateButton({ Name = "Hoho Hub", Callback = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/acsu123/HOHO_H/main/Loading_UI"))() end })

        -- [PLAYER]
        local PlayerTab = Window:CreateTab("Local Player 🏃‍♂️", 4483362458)
        PlayerTab:CreateSlider({ Name = "WalkSpeed", Range = {16, 250}, Increment = 1, Suffix = "Speed", CurrentValue = 16, Flag = "SpeedSlider", Callback = function(Value) game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = Value end })
        local InfiniteJumpEnabled = false
        PlayerTab:CreateToggle({ Name = "Infinite Jump", CurrentValue = false, Flag = "InfJump", Callback = function(Value) InfiniteJumpEnabled = Value end })
        game:GetService("UserInputService").JumpRequest:Connect(function() if InfiniteJumpEnabled then game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):ChangeState("Jumping") end end)

        -- [SERVER]
        local ServerTab = Window:CreateTab("Server 🌐", 4483362458)
        ServerTab:CreateButton({ Name = "Anti-AFK", Callback = function() local vu = game:GetService("VirtualUser"); game:GetService("Players").LocalPlayer.Idled:Connect(function() vu:Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame); task.wait(1); vu:Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame) end) end })
        ServerTab:CreateButton({ Name = "Server Hop", Callback = function() local Http = game:GetService("HttpService"); local TPS = game:GetService("TeleportService"); local Api = "https://games.roblox.com/v1/games/"; local _place = game.PlaceId; local _servers = Api.._place.."/servers/Public?sortOrder=Asc&limit=100"; local function ListServers(cursor) local Raw = game:HttpGet(_servers .. ((cursor and "&cursor="..cursor) or "")); return Http:JSONDecode(Raw) end; local Server, Next; repeat local Servers = ListServers(Next); Server = Servers.data[1]; Next = Servers.nextPageCursor until Server; TPS:TeleportToPlaceInstance(_place, Server.id, game.Players.LocalPlayer) end })

    else
        WrongAttempts = WrongAttempts + 1
        if WrongAttempts >= 2 then
            game.Players.LocalPlayer:Kick("❌ Kicked by JULZ: Invalid Key.")
        else
            SubmitBtn.Text = "WRONG! (1/2)"
            SubmitBtn.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
            task.wait(1.5)
            SubmitBtn.Text = "LOGIN"
            SubmitBtn.BackgroundColor3 = Color3.new(0,0,0)
        end
    end
end)
