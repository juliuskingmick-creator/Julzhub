--[[
    JULZ hub | V45 Mobile Optimized
    Updates: Added Infinite Jump, XVC Hub, Reworked ESP, Key Support, BABFT, Epstein
    Security: Manual Key Entry (Kick on Fail)
]]

local TargetKey = "JULZISTHEBEST"
local DiscordLink = "https://discord.gg/cukP3aqCe"
local IsAuthenticated = false

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

-- 1. MOBILE-READY KEY SYSTEM
local function LoadKeySystem()
    local AuthGui = Instance.new("ScreenGui", game:GetService("CoreGui"))
    local MainFrame = Instance.new("Frame", AuthGui)
    MainFrame.Size = UDim2.new(0, 320, 0, 260); MainFrame.Position = UDim2.new(0.5, -160, 0.5, -130); MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
    Instance.new("UICorner", MainFrame)
    
    local Title = Instance.new("TextLabel", MainFrame)
    Title.Text = "JULZ HUB V45"; Title.Size = UDim2.new(1, 0, 0, 50); Title.TextColor3 = Color3.new(1, 1, 1); Title.Font = Enum.Font.GothamBold; Title.BackgroundTransparency = 1

    local Input = Instance.new("TextBox", MainFrame)
    Input.PlaceholderText = "Enter Key..."; Input.Size = UDim2.new(0.85, 0, 0, 45); Input.Position = UDim2.new(0.075, 0, 0.25, 0); Input.BackgroundColor3 = Color3.fromRGB(30, 30, 30); Input.TextColor3 = Color3.new(1, 1, 1)
    Instance.new("UICorner", Input)

    local Submit = Instance.new("TextButton", MainFrame)
    Submit.Text = "LOG IN"; Submit.Size = UDim2.new(0.85, 0, 0, 45); Submit.Position = UDim2.new(0.075, 0, 0.48, 0); Submit.BackgroundColor3 = Color3.fromRGB(160, 0, 255); Submit.TextColor3 = Color3.new(1, 1, 1); Submit.Font = Enum.Font.GothamBold
    Instance.new("UICorner", Submit)

    local GetKey = Instance.new("TextButton", MainFrame)
    GetKey.Text = "GET KEY (DISCORD)"; GetKey.Size = UDim2.new(0.85, 0, 0, 40); GetKey.Position = UDim2.new(0.075, 0, 0.72, 0); GetKey.BackgroundColor3 = Color3.fromRGB(40, 40, 40); GetKey.TextColor3 = Color3.fromRGB(200, 200, 200); GetKey.Font = Enum.Font.Gotham
    Instance.new("UICorner", GetKey)

    GetKey.MouseButton1Click:Connect(function()
        setclipboard(DiscordLink)
        game:GetService("StarterGui"):SetCore("SendNotification", { Title = "JULZ HUB", Text = "Discord Link Copied!", Duration = 5 })
    end)

    Submit.MouseButton1Click:Connect(function()
        if Input.Text == TargetKey then 
            IsAuthenticated = true 
            AuthGui:Destroy() 
        else 
            LocalPlayer:Kick("\n[JULZ HUB]\nInvalid Key.\nDiscord: " .. DiscordLink)
        end
    end)
    repeat task.wait() until IsAuthenticated
end
LoadKeySystem()

-- 2. ENGINE CONFIG
local Config = {
    WalkSpeed = 16, 
    EspEnabled = false, 
    HitboxExpander = false, 
    HitboxSize = 2,
    SilentAim = false, 
    FOV = 150,
    InfiniteJump = false
}

-- 3. REWORKED HIGHLIGHT ESP
local function ApplyESP(player)
    local function CreateHighlight()
        if player == LocalPlayer then return end
        local char = player.Character or player.CharacterAdded:Wait()
        if char:FindFirstChild("JulzESP") then char.JulzESP:Destroy() end
        local Highlight = Instance.new("Highlight")
        Highlight.Name = "JulzESP"
        Highlight.Parent = char
        Highlight.FillColor = Color3.fromRGB(160, 0, 255)
        Highlight.OutlineColor = Color3.new(1, 1, 1)
        Highlight.FillTransparency = 0.5
        Highlight.Enabled = Config.EspEnabled
        RunService.RenderStepped:Connect(function() Highlight.Enabled = Config.EspEnabled end)
    end
    player.CharacterAdded:Connect(CreateHighlight)
    if player.Character then CreateHighlight() end
end
for _, p in pairs(Players:GetPlayers()) do ApplyESP(p) end
Players.PlayerAdded:Connect(ApplyESP)

-- 4. SILENT AIM (METATABLE HOOK)
local mt = getrawmetatable(game)
local old = mt.__namecall
setreadonly(mt, false)
mt.__namecall = newcclosure(function(self, ...)
    local method = getnamecallmethod()
    if Config.SilentAim and (method == "FindPartOnRayWithIgnoreList" or method == "Raycast") then
        local target = nil
        local dist = Config.FOV
        for _, p in pairs(Players:GetPlayers()) do
            if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                local pos, onScreen = Camera:WorldToViewportPoint(p.Character.HumanoidRootPart.Position)
                if onScreen then
                    local mag = (Vector2.new(pos.X, pos.Y) - Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y/2)).Magnitude
                    if mag < dist then target = p.Character.HumanoidRootPart; dist = mag end
                end
            end
        end
        if target then return target, target.Position, target.Position, target.Material end
    end
    return old(self, ...)
end)
setreadonly(mt, true)

-- 5. INFINITE JUMP LOGIC
UserInputService.JumpRequest:Connect(function()
    if Config.InfiniteJump then
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid") then
            LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):ChangeState(Enum.HumanoidStateType.Jumping)
        end
    end
end)

-- 6. INTERFACE (LUNA)
local Luna = loadstring(game:HttpGet("https://raw.githubusercontent.com/Nebula-Softworks/Luna-Interface-Suite/main/source.lua"))()
local Window = Luna:CreateWindow({ Name = "JULZ hub", Subtitle = "V45 Mobile", LoadingEnabled = true })

local Combat = Window:CreateTab({ Name = "Combat", Icon = "shutter_speed" })
local Visuals = Window:CreateTab({ Name = "Visuals", Icon = "visibility" })
local Movement = Window:CreateTab({ Name = "Movement", Icon = "bolt" })
local Extra = Window:CreateTab({ Name = "Scripts", Icon = "auto_awesome" })

-- COMBAT
Combat:CreateToggle({ Name = "Silent Aim", Callback = function(v) Config.SilentAim = v end })
Combat:CreateSlider({ Name = "Silent FOV", Range = {50, 800}, CurrentValue = 150, Callback = function(v) Config.FOV = v end })
Combat:CreateToggle({ Name = "Hitbox Expander", Callback = function(v) Config.HitboxExpander = v end })
Combat:CreateSlider({ Name = "Hitbox Size", Range = {2, 35}, CurrentValue = 2, Callback = function(v) Config.HitboxSize = v end })

-- VISUALS
Visuals:CreateToggle({ Name = "Highlight ESP", Callback = function(v) Config.EspEnabled = v end })
Visuals:CreateButton({ Name = "JJS Shaders", Callback = function() loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-jango-premium-crack-131377"))() end })

-- MOVEMENT
Movement:CreateToggle({ Name = "Infinite Jump", Callback = function(v) Config.InfiniteJump = v end })
Movement:CreateButton({ Name = "Give Click TP Tool", Callback = function() 
    local TPTool = Instance.new("Tool")
    TPTool.Name = "JULZ TP TOOL"; TPTool.RequiresHandle = false; TPTool.Parent = LocalPlayer.Backpack
    TPTool.Activated:Connect(function()
        local res = workspace:Raycast(Camera:ViewportPointToRay(UserInputService:GetMouseLocation().X, UserInputService:GetMouseLocation().Y).Origin, Camera:ViewportPointToRay(UserInputService:GetMouseLocation().X, UserInputService:GetMouseLocation().Y).Direction * 1000)
        if res then LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(res.Position + Vector3.new(0, 3, 0)) end
    end)
end })
Movement:CreateSlider({ Name = "WalkSpeed", Range = {16, 250}, CurrentValue = 16, Callback = function(v) Config.WalkSpeed = v end })

-- EXTRA (SCRIPTS)
Extra:CreateButton({ Name = "Load XVC Hub", Callback = function() loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-XVC-Hub-79830"))() end })
Extra:CreateButton({ Name = "Load Epstein Script", Callback = function() loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-Jeffrey-epstein-script-115494"))() end })
Extra:CreateButton({ Name = "BABFT Ultimate", Callback = function() loadstring(game:HttpGet("https://rawscripts.net/raw/Build-A-Boat-For-Treasure-Ultimte-B3BFT-Script-28601"))() end })
Extra:CreateButton({ Name = "Load TBO Hub (JJS)", Callback = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/cool5013/TBO/main/TBOscript"))() end })
Extra:CreateButton({ Name = "Auto Piano", Callback = function() loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-talentless-crack-75521"))() end })
Extra:CreateButton({ Name = "Apply R6 Femboy", Callback = function()
    local char = LocalPlayer.Character
    for _, v in pairs(char:GetChildren()) do if v:IsA("Accessory") or v:IsA("Shirt") or v:IsA("Pants") or v:IsA("CharacterMesh") then v:Destroy() end end
    local s = Instance.new("Shirt", char); s.ShirtTemplate = "rbxassetid://6833930199"
    local p = Instance.new("Pants", char); p.PantsTemplate = "rbxassetid://6003675248"
    local bc = char:FindFirstChildOfClass("BodyColors") or Instance.new("BodyColors", char)
    bc.HeadColor3 = Color3.fromRGB(255, 225, 225); bc.TorsoColor3 = Color3.fromRGB(255, 225, 225)
end})

-- 7. CORE HEARTBEAT
RunService.Heartbeat:Connect(function()
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid.WalkSpeed = Config.WalkSpeed
    end
    if Config.HitboxExpander then
        for _, p in pairs(Players:GetPlayers()) do
            if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                p.Character.HumanoidRootPart.Size = Vector3.new(Config.HitboxSize, Config.HitboxSize, Config.HitboxSize)
                p.Character.HumanoidRootPart.Transparency = 0.8; p.Character.HumanoidRootPart.CanCollide = false
            end
        end
    end
end)

Luna:Notification({ Title = "JULZ hub", Content = "V45 Loaded! Infinite Jump Active." })
--[[
    JULZ hub | V45 Mobile Optimized
    Updates: Added Infinite Jump, XVC Hub, Reworked ESP, Key Support, BABFT, Epstein
    Security: Manual Key Entry (Kick on Fail)
]]

local TargetKey = "JULZISTHEBEST"
local DiscordLink = "https://discord.gg/cukP3aqCe"
local IsAuthenticated = false

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

-- 1. MOBILE-READY KEY SYSTEM
local function LoadKeySystem()
    local AuthGui = Instance.new("ScreenGui", game:GetService("CoreGui"))
    local MainFrame = Instance.new("Frame", AuthGui)
    MainFrame.Size = UDim2.new(0, 320, 0, 260); MainFrame.Position = UDim2.new(0.5, -160, 0.5, -130); MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
    Instance.new("UICorner", MainFrame)
    
    local Title = Instance.new("TextLabel", MainFrame)
    Title.Text = "JULZ HUB V45"; Title.Size = UDim2.new(1, 0, 0, 50); Title.TextColor3 = Color3.new(1, 1, 1); Title.Font = Enum.Font.GothamBold; Title.BackgroundTransparency = 1

    local Input = Instance.new("TextBox", MainFrame)
    Input.PlaceholderText = "Enter Key..."; Input.Size = UDim2.new(0.85, 0, 0, 45); Input.Position = UDim2.new(0.075, 0, 0.25, 0); Input.BackgroundColor3 = Color3.fromRGB(30, 30, 30); Input.TextColor3 = Color3.new(1, 1, 1)
    Instance.new("UICorner", Input)

    local Submit = Instance.new("TextButton", MainFrame)
    Submit.Text = "LOG IN"; Submit.Size = UDim2.new(0.85, 0, 0, 45); Submit.Position = UDim2.new(0.075, 0, 0.48, 0); Submit.BackgroundColor3 = Color3.fromRGB(160, 0, 255); Submit.TextColor3 = Color3.new(1, 1, 1); Submit.Font = Enum.Font.GothamBold
    Instance.new("UICorner", Submit)

    local GetKey = Instance.new("TextButton", MainFrame)
    GetKey.Text = "GET KEY (DISCORD)"; GetKey.Size = UDim2.new(0.85, 0, 0, 40); GetKey.Position = UDim2.new(0.075, 0, 0.72, 0); GetKey.BackgroundColor3 = Color3.fromRGB(40, 40, 40); GetKey.TextColor3 = Color3.fromRGB(200, 200, 200); GetKey.Font = Enum.Font.Gotham
    Instance.new("UICorner", GetKey)

    GetKey.MouseButton1Click:Connect(function()
        setclipboard(DiscordLink)
        game:GetService("StarterGui"):SetCore("SendNotification", { Title = "JULZ HUB", Text = "Discord Link Copied!", Duration = 5 })
    end)

    Submit.MouseButton1Click:Connect(function()
        if Input.Text == TargetKey then 
            IsAuthenticated = true 
            AuthGui:Destroy() 
        else 
            LocalPlayer:Kick("\n[JULZ HUB]\nInvalid Key.\nDiscord: " .. DiscordLink)
        end
    end)
    repeat task.wait() until IsAuthenticated
end
LoadKeySystem()

-- 2. ENGINE CONFIG
local Config = {
    WalkSpeed = 16, 
    EspEnabled = false, 
    HitboxExpander = false, 
    HitboxSize = 2,
    SilentAim = false, 
    FOV = 150,
    InfiniteJump = false
}

-- 3. REWORKED HIGHLIGHT ESP
local function ApplyESP(player)
    local function CreateHighlight()
        if player == LocalPlayer then return end
        local char = player.Character or player.CharacterAdded:Wait()
        if char:FindFirstChild("JulzESP") then char.JulzESP:Destroy() end
        local Highlight = Instance.new("Highlight")
        Highlight.Name = "JulzESP"
        Highlight.Parent = char
        Highlight.FillColor = Color3.fromRGB(160, 0, 255)
        Highlight.OutlineColor = Color3.new(1, 1, 1)
        Highlight.FillTransparency = 0.5
        Highlight.Enabled = Config.EspEnabled
        RunService.RenderStepped:Connect(function() Highlight.Enabled = Config.EspEnabled end)
    end
    player.CharacterAdded:Connect(CreateHighlight)
    if player.Character then CreateHighlight() end
end
for _, p in pairs(Players:GetPlayers()) do ApplyESP(p) end
Players.PlayerAdded:Connect(ApplyESP)

-- 4. SILENT AIM (METATABLE HOOK)
local mt = getrawmetatable(game)
local old = mt.__namecall
setreadonly(mt, false)
mt.__namecall = newcclosure(function(self, ...)
    local method = getnamecallmethod()
    if Config.SilentAim and (method == "FindPartOnRayWithIgnoreList" or method == "Raycast") then
        local target = nil
        local dist = Config.FOV
        for _, p in pairs(Players:GetPlayers()) do
            if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                local pos, onScreen = Camera:WorldToViewportPoint(p.Character.HumanoidRootPart.Position)
                if onScreen then
                    local mag = (Vector2.new(pos.X, pos.Y) - Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y/2)).Magnitude
                    if mag < dist then target = p.Character.HumanoidRootPart; dist = mag end
                end
            end
        end
        if target then return target, target.Position, target.Position, target.Material end
    end
    return old(self, ...)
end)
setreadonly(mt, true)

-- 5. INFINITE JUMP LOGIC
UserInputService.JumpRequest:Connect(function()
    if Config.InfiniteJump then
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid") then
            LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):ChangeState(Enum.HumanoidStateType.Jumping)
        end
    end
end)

-- 6. INTERFACE (LUNA)
local Luna = loadstring(game:HttpGet("https://raw.githubusercontent.com/Nebula-Softworks/Luna-Interface-Suite/main/source.lua"))()
local Window = Luna:CreateWindow({ Name = "JULZ hub", Subtitle = "V45 Mobile", LoadingEnabled = true })

local Combat = Window:CreateTab({ Name = "Combat", Icon = "shutter_speed" })
local Visuals = Window:CreateTab({ Name = "Visuals", Icon = "visibility" })
local Movement = Window:CreateTab({ Name = "Movement", Icon = "bolt" })
local Extra = Window:CreateTab({ Name = "Scripts", Icon = "auto_awesome" })

-- COMBAT
Combat:CreateToggle({ Name = "Silent Aim", Callback = function(v) Config.SilentAim = v end })
Combat:CreateSlider({ Name = "Silent FOV", Range = {50, 800}, CurrentValue = 150, Callback = function(v) Config.FOV = v end })
Combat:CreateToggle({ Name = "Hitbox Expander", Callback = function(v) Config.HitboxExpander = v end })
Combat:CreateSlider({ Name = "Hitbox Size", Range = {2, 35}, CurrentValue = 2, Callback = function(v) Config.HitboxSize = v end })

-- VISUALS
Visuals:CreateToggle({ Name = "Highlight ESP", Callback = function(v) Config.EspEnabled = v end })
Visuals:CreateButton({ Name = "JJS Shaders", Callback = function() loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-jango-premium-crack-131377"))() end })

-- MOVEMENT
Movement:CreateToggle({ Name = "Infinite Jump", Callback = function(v) Config.InfiniteJump = v end })
Movement:CreateButton({ Name = "Give Click TP Tool", Callback = function() 
    local TPTool = Instance.new("Tool")
    TPTool.Name = "JULZ TP TOOL"; TPTool.RequiresHandle = false; TPTool.Parent = LocalPlayer.Backpack
    TPTool.Activated:Connect(function()
        local res = workspace:Raycast(Camera:ViewportPointToRay(UserInputService:GetMouseLocation().X, UserInputService:GetMouseLocation().Y).Origin, Camera:ViewportPointToRay(UserInputService:GetMouseLocation().X, UserInputService:GetMouseLocation().Y).Direction * 1000)
        if res then LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(res.Position + Vector3.new(0, 3, 0)) end
    end)
end })
Movement:CreateSlider({ Name = "WalkSpeed", Range = {16, 250}, CurrentValue = 16, Callback = function(v) Config.WalkSpeed = v end })

-- EXTRA (SCRIPTS)
Extra:CreateButton({ Name = "XVC Hub", Callback = function() loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-XVC-Hub-79830"))() end })
Extra:CreateButton({ Name = "player fucker", Callback = function() loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-Jeffrey-epstein-script-115494"))() end })
Extra:CreateButton({ Name = "asuscript", Callback = function() loadstring(game:HttpGet("https://rawscripts.net/raw/Build-A-Boat-For-Treasure-Ultimte-B3BFT-Script-28601"))() end })
Extra:CreateButton({ Name = "JJS", Callback = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/cool5013/TBO/main/TBOscript"))() end })
Extra:CreateButton({ Name = "TALENTLESS PIANO", Callback = function() loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-talentless-crack-75521"))() end })
Extra:CreateButton({ Name = "Apply R6 Femboy", Callback = function()
    local char = LocalPlayer.Character
    for _, v in pairs(char:GetChildren()) do if v:IsA("Accessory") or v:IsA("Shirt") or v:IsA("Pants") or v:IsA("CharacterMesh") then v:Destroy() end end
    local s = Instance.new("Shirt", char); s.ShirtTemplate = "rbxassetid://6833930199"
    local p = Instance.new("Pants", char); p.PantsTemplate = "rbxassetid://6003675248"
    local bc = char:FindFirstChildOfClass("BodyColors") or Instance.new("BodyColors", char)
    bc.HeadColor3 = Color3.fromRGB(255, 225, 225); bc.TorsoColor3 = Color3.fromRGB(255, 225, 225)
end})

-- 7. CORE HEARTBEAT
RunService.Heartbeat:Connect(function()
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid.WalkSpeed = Config.WalkSpeed
    end
    if Config.HitboxExpander then
        for _, p in pairs(Players:GetPlayers()) do
            if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                p.Character.HumanoidRootPart.Size = Vector3.new(Config.HitboxSize, Config.HitboxSize, Config.HitboxSize)
                p.Character.HumanoidRootPart.Transparency = 0.8; p.Character.HumanoidRootPart.CanCollide = false
            end
        end
    end
end)

Luna:Notification({ Title = "JULZ hub", Content = "V45 Loaded! Infinite Jump Active." })
