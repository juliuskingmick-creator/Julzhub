local CorrectKey = "JULZTHEPWN"
local WrongAttempts = 0 
local DiscordLink = "https://discord.gg/cukP3aqCe"

-- ==========================================
-- 1. THE LOGIN SCREEN (Dark Splashes)
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
-- 2. LOGIN LOGIC & MASSIVE MAIN HUB
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
           LoadingTitle = "Loading Scripts...",
           LoadingSubtitle = "by JULZ", -- UPDATED CREDIT
           ConfigurationSaving = { Enabled = false },
           KeySystem = false,
           Theme = "Default"
        })

        -- CUSTOM WELCOME
        Rayfield:Notify({
            Title = "Welcome, " .. game.Players.LocalPlayer.DisplayName .. "!",
            Content = "Successfully logged into Julz Hub. Enjoy!",
            Duration = 5,
            Image = 4483362458,
        })

        -- [UNIVERSAL HUBS]
        local UnivTab = Window:CreateTab("Universal 🌌", 4483362458)
        UnivTab:CreateButton({ Name = "Infinite Yield", Callback = function() loadstring(game:HttpGet('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source'))() end })
        UnivTab:CreateButton({ Name = "CMD-X", Callback = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/CMD-X/CMD-X/master/Source", true))() end })
        UnivTab:CreateButton({ Name = "Jango Premium", Callback = function() loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-jango-premium-crack-131377"))() end })
        UnivTab:CreateButton({ Name = "Orca Hub", Callback = function() loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/richie0866/orca/master/public/latest.lua"))() end })

        -- [JJS]
        local JJSTab = Window:CreateTab("JJS 👊", 4483362458)
        JJSTab:CreateButton({ Name = "SMN2 Main Script", Callback = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/Idontknowhowtotype/SMN2/refs/heads/main/Main.lua", true))() end })
        JJSTab:CreateButton({ Name = "Talentless Crack", Callback = function() loadstring(game:HttpGet("https://egirlswow.pages.dev/cracks/talentless"))() end })
        JJSTab:CreateButton({ Name = "Kajun Hub (JJS)", Callback = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/Kajun123/KajunHub/main/KajunHub.lua"))() end })
        
        -- [BEDWARS]
        local BedwarsTab = Window:CreateTab("Bedwars 🛏️", 4483362458)
        BedwarsTab:CreateButton({ Name = "Vape V4", Callback = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/7GrandDadPGN/VapeV4ForRoblox/main/NewMainScript.lua", true))() end })
        BedwarsTab:CreateButton({ Name = "Alsploit", Callback = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/AlSploit/AlSploit/main/Bedwars"))() end })

        -- [BLOX FRUITS]
        local BloxTab = Window:CreateTab("Blox Fruits 🏴‍☠️", 4483362458)
        BloxTab:CreateButton({ Name = "Hoho Hub", Callback = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/acsu123/HOHO_H/main/Loading_UI"))() end })
        BloxTab:CreateButton({ Name = "W-Azure", Callback = function() loadstring(game:HttpGet("https://api.luarmor.net/files/v3/loaders/3b2169cf53bc6104dabe8e19562e5cc2.lua"))() end })
        BloxTab:CreateButton({ Name = "Mukuro Hub", Callback = function() loadstring(game:HttpGet"https://raw.githubusercontent.com/xQuartyx/DonateMe/main/ScriptLoader")() end })

        -- [DA HOOD]
        local DaHoodTab = Window:CreateTab("Da Hood 🔫", 4483362458)
        DaHoodTab:CreateButton({ Name = "SwagMode", Callback = function() loadstring(game:HttpGet('https://raw.githubusercontent.com/lerkermer/lua-projects/master/SwagModeV002'))() end })
        DaHoodTab:CreateButton({ Name = "RayX Hub", Callback = function() loadstring(game:HttpGet('https://raw.githubusercontent.com/SpaceEX0/Space/main/RayX/Main.lua'))() end })

        -- [MINI-GAMES]
        local GamesTab = Window:CreateTab("More Games 🎮", 4483362458)
        GamesTab:CreateButton({ Name = "Eclipse Hub (MM2)", Callback = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/Doggo-cryto/EclipseMM2/master/Script", true))() end })
        GamesTab:CreateButton({ Name = "FFJ Hub (Blade Ball)", Callback = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/FFJ1/Roblox-Exploits/main/scripts/BladeBallV3.lua"))() end })
        GamesTab:CreateButton({ Name = "DarkHub (Arsenal)", Callback = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/RandomPlayerrr/roblox-scripts/main/darkhub", true))() end })

        -- [PLAYER]
        local PlayerTab = Window:CreateTab("Local Player 🏃‍♂️", 4483362458)
        PlayerTab:CreateSlider({ Name = "WalkSpeed", Range = {16, 250}, Increment = 1, Suffix = "Speed", CurrentValue = 16, Flag = "SpeedSlider", Callback = function(Value) game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = Value end })
        PlayerTab:CreateSlider({ Name = "JumpPower", Range = {50, 300}, Increment = 1, Suffix = "Power", CurrentValue = 50, Flag = "JumpSlider", Callback = function(Value) game.Players.LocalPlayer.Character.Humanoid.JumpPower = Value end })
        local InfiniteJumpEnabled = false
        PlayerTab:CreateToggle({ Name = "Infinite Jump", CurrentValue = false, Flag = "InfJump", Callback = function(Value) InfiniteJumpEnabled = Value end })
        game:GetService("UserInputService").JumpRequest:Connect(function() if InfiniteJumpEnabled then game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):ChangeState("Jumping") end end)

        -- [VISUALS]
        local VisualsTab = Window:CreateTab("Visuals 👁️", 4483362458)
        VisualsTab:CreateButton({ Name = "Enable Universal ESP", Callback = function() loadstring(game:HttpGet('https://raw.githubusercontent.com/ic3w0lf22/Unnamed-ESP/master/UnnamedESP.lua'))() end })
        VisualsTab:CreateToggle({ Name = "Fullbright", CurrentValue = false, Flag = "Fullbright", Callback = function(Value) if Value then game.Lighting.Ambient = Color3.new(1, 1, 1); game.Lighting.Brightness = 2 else game.Lighting.Ambient = Color3.fromRGB(128, 128, 128); game.Lighting.Brightness = 1 end end })

        -- [COMBAT]
        local CombatTab = Window:CreateTab("Combat ⚔️", 4483362458)
        local hitboxSize = 5
        CombatTab:CreateSlider({ Name = "Hitbox Size", Range = {5, 50}, Increment = 1, Suffix = "Studs", CurrentValue = 5, Flag = "HitboxSlider", Callback = function(Value) hitboxSize = Value end })
        CombatTab:CreateButton({ Name = "Apply Giant Hitboxes", Callback = function() for _, v in pairs(game.Players:GetPlayers()) do if v ~= game.Players.LocalPlayer and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then v.Character.HumanoidRootPart.Size = Vector3.new(hitboxSize, hitboxSize, hitboxSize); v.Character.HumanoidRootPart.Transparency = 0.7; v.Character.HumanoidRootPart.BrickColor = BrickColor.new("Really red"); v.Character.HumanoidRootPart.CanCollide = false end end end })

        -- [TROLL]
        local TrollTab = Window:CreateTab("Troll / Fun 🤡", 4483362458)
        TrollTab:CreateButton({ Name = "Femboy Morph (R6/R15)", Callback = function() local char = game.Players.LocalPlayer.Character; if not char then return end; local hum = char:FindFirstChildOfClass("Humanoid"); if not hum then return end; pcall(function() if hum.RigType == Enum.HumanoidRigType.R15 then local desc = hum:GetAppliedDescription(); desc.Height, desc.Width, desc.Proportion = 0.85, 0.75, 1; desc.Shirt, desc.Pants = 6917631589, 7192301130; desc.HairAccessory, desc.Face = "14603416757", 12142220; hum:ApplyDescription(desc) else local s = char:FindFirstChildOfClass("Shirt") or Instance.new("Shirt", char); local p = char:FindFirstChildOfClass("Pants") or Instance.new("Pants", char); s.ShirtTemplate, p.PantsTemplate = "rbxassetid://6917631589", "rbxassetid://7192301130" end end) end })
        local spinPower = 0
        TrollTab:CreateToggle({ Name = "Spinbot", CurrentValue = false, Flag = "Spin", Callback = function(Value) if Value then spinPower = 50; game:GetService("RunService").RenderStepped:Connect(function() game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.Angles(0, math.rad(spinPower), 0) end) else spinPower = 0 end end })

        -- [SERVER]
        local ServerTab = Window:CreateTab("Server 🌐", 4483362458)
        ServerTab:CreateButton({ Name = "Anti-AFK", Callback = function() local vu = game:GetService("VirtualUser"); game:GetService("Players").LocalPlayer.Idled:Connect(function() vu:Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame); task.wait(1); vu:Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame) end) end })
        ServerTab:CreateButton({ Name = "Server Hop", Callback = function() local Http = game:GetService("HttpService"); local TPS = game:GetService("TeleportService"); local Api = "https://games.roblox.com/v1/games/"; local _place = game.PlaceId; local _servers = Api.._place.."/servers/Public?sortOrder=Asc&limit=100"; local function ListServers(cursor) local Raw = game:HttpGet(_servers .. ((cursor and "&cursor="..cursor) or "")); return Http:JSONDecode(Raw) end; local Server, Next; repeat local Servers = ListServers(Next); Server = Servers.data[1]; Next = Servers.nextPageCursor until Server; TPS:TeleportToPlaceInstance(_place, Server.id, game.Players.LocalPlayer) end })
        ServerTab:CreateButton({ Name = "Rejoin Server", Callback = function() game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, game.JobId, game.Players.LocalPlayer) end })

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
