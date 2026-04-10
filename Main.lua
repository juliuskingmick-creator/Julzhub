--[[
    ╔══════════════════════════════════════╗
    ║     JULZHUB | RIVALS ONLY  v6.0      ║
    ║     Dev: julzmon                     ║
    ║     Compat: Delta / Mobile           ║
    ║     Key: thinkpad                    ║
    ╚══════════════════════════════════════╝
]]

-- ──────────────────────────────────────────
--  Bootstrap
-- ──────────────────────────────────────────
if not game:IsLoaded() then game.Loaded:Wait() end

local Players      = game:GetService("Players")
local RunService   = game:GetService("RunService")
local UserInputSvc = game:GetService("UserInputService")
local TweenSvc     = game:GetService("TweenService")
local CoreGui      = game:GetService("CoreGui")
local Camera       = workspace.CurrentCamera
local LocalPlayer  = Players.LocalPlayer
local Mouse        = LocalPlayer:GetMouse()

-- ──────────────────────────────────────────
--  State Table  (all feature flags live here)
-- ──────────────────────────────────────────
local State = {
    -- Combat
    SilentAim      = false,
    Aimbot         = false,
    Smoothness     = 50,
    FOV            = 100,
    Triggerbot     = false,
    NoRecoil       = false,
    NoSpread       = false,
    HitboxSize     = 1,
    AutoReload     = false,
    AimPriority    = "Head",
    Prediction     = 0,
    AimKey         = Enum.UserInputType.MouseButton2,

    -- Visuals
    BoxESP         = false,
    Skeleton       = false,
    Names          = false,
    Distance       = false,
    Tracers        = false,
    HealthBar      = false,
    Chams          = false,
    Items          = false,
    Radar          = false,
    Indicators     = false,
    ESPColor       = Color3.fromRGB(255, 50, 50),
    BoxThickness   = 1,

    -- Movement
    Speed          = 16,
    JumpPower      = 50,
    InfJump        = false,
    Fly            = false,
    Noclip         = false,
    Bhop           = false,
    SpeedBoost     = false,
    Spinbot        = false,
    NoFall         = false,
    AutoSprint     = false,

    -- Utility
    Fullbright     = false,
    AutoQueue      = false,
    AntiAFK        = false,
    FPSBoost       = false,
    StreamerMode   = false,
    ChatBypass     = false,
}

-- ──────────────────────────────────────────
--  Load Luna UI Library
-- ──────────────────────────────────────────
local ok, Library = pcall(function()
    return loadstring(game:HttpGet(
        "https://raw.githubusercontent.com/shlexsoftware/Luna/main/source.lua"
    ))()
end)
if not ok then
    warn("[JulzHub] Luna failed to load: " .. tostring(Library))
    return
end

-- ──────────────────────────────────────────
--  Utility Helpers
-- ──────────────────────────────────────────
local function Tween(obj, info, props)
    TweenSvc:Create(obj, info, props):Play()
end

local function GetEnemies()
    local list = {}
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
            list[#list + 1] = p
        end
    end
    return list
end

local function GetClosestEnemy()
    local closest, dist = nil, State.FOV
    for _, p in ipairs(GetEnemies()) do
        local hrp = p.Character and p.Character:FindFirstChild("HumanoidRootPart")
        if hrp then
            local sp, vis = Camera:WorldToViewportPoint(hrp.Position)
            if vis then
                local d = (Vector2.new(sp.X, sp.Y) - Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y/2)).Magnitude
                if d < dist then closest, dist = p, d end
            end
        end
    end
    return closest
end

-- ──────────────────────────────────────────
--  FOV Circle
-- ──────────────────────────────────────────
local FOVCircle = Drawing.new("Circle")
FOVCircle.Visible  = false
FOVCircle.Radius   = State.FOV
FOVCircle.Color    = Color3.fromRGB(255, 255, 255)
FOVCircle.Thickness = 1
FOVCircle.Filled   = false
FOVCircle.Position = Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y/2)

RunService.RenderStepped:Connect(function()
    FOVCircle.Position = Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y/2)
    FOVCircle.Radius   = State.FOV
    FOVCircle.Visible  = State.Aimbot or State.SilentAim
end)

-- ──────────────────────────────────────────
--  Aimbot / Silent Aim
-- ──────────────────────────────────────────
RunService.RenderStepped:Connect(function()
    if not (State.Aimbot or State.SilentAim) then return end
    if not UserInputSvc:IsMouseButtonPressed(State.AimKey) then return end

    local target = GetClosestEnemy()
    if not target then return end
    local char = target.Character
    local part = char:FindFirstChild(State.AimPriority) or char:FindFirstChild("HumanoidRootPart")
    if not part then return end

    -- Velocity prediction
    local hrp = char:FindFirstChild("HumanoidRootPart")
    local predPos = part.Position + (hrp and hrp.AssemblyLinearVelocity * State.Prediction or Vector3.zero)
    local sp = Camera:WorldToViewportPoint(predPos)

    if State.Aimbot then
        local center = Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y/2)
        local target2D = Vector2.new(sp.X, sp.Y)
        local smooth = State.Smoothness / 10
        Camera.CFrame = Camera.CFrame:Lerp(
            CFrame.new(Camera.CFrame.Position, part.Position),
            1 / smooth
        )
    end
end)

-- ──────────────────────────────────────────
--  Triggerbot
-- ──────────────────────────────────────────
RunService.RenderStepped:Connect(function()
    if not State.Triggerbot then return end
    local target = Mouse.Target
    if target and target.Parent then
        local p = Players:GetPlayerFromCharacter(target.Parent)
        if p and p ~= LocalPlayer then
            -- Fire weapon (game-specific; stub)
            -- fireserver(...)
        end
    end
end)

-- ──────────────────────────────────────────
--  Noclip
-- ──────────────────────────────────────────
RunService.Stepped:Connect(function()
    if not State.Noclip then return end
    local char = LocalPlayer.Character
    if not char then return end
    for _, part in ipairs(char:GetDescendants()) do
        if part:IsA("BasePart") then
            part.CanCollide = false
        end
    end
end)

-- ──────────────────────────────────────────
--  Infinite Jump + Bhop
-- ──────────────────────────────────────────
UserInputSvc.JumpRequest:Connect(function()
    local char = LocalPlayer.Character
    local hum  = char and char:FindFirstChildOfClass("Humanoid")
    if hum and State.InfJump then
        hum:ChangeState(Enum.HumanoidStateType.Jumping)
    end
end)

RunService.Heartbeat:Connect(function()
    local char = LocalPlayer.Character
    local hum  = char and char:FindFirstChildOfClass("Humanoid")
    local hrp  = char and char:FindFirstChild("HumanoidRootPart")
    if not (hum and hrp) then return end

    -- Speed
    local targetSpeed = State.SpeedBoost and State.Speed or 16
    hum.WalkSpeed = targetSpeed

    -- Jump
    hum.JumpPower = State.JumpPower

    -- No Fall Damage
    if State.NoFall then hum.MaxHealth = 100; hum.Health = 100 end

    -- Bhop
    if State.Bhop and hum.FloorMaterial ~= Enum.Material.Air then
        hum:ChangeState(Enum.HumanoidStateType.Jumping)
    end

    -- Spinbot
    if State.Spinbot then
        hrp.CFrame = hrp.CFrame * CFrame.Angles(0, math.rad(10), 0)
    end

    -- Auto Sprint
    if State.AutoSprint and hum.MoveDirection.Magnitude > 0 then
        hum.WalkSpeed = State.Speed
    end
end)

-- ──────────────────────────────────────────
--  Fly
-- ──────────────────────────────────────────
local flyConn
local function StartFly()
    local char = LocalPlayer.Character
    local hrp  = char and char:FindFirstChild("HumanoidRootPart")
    local hum  = char and char:FindFirstChildOfClass("Humanoid")
    if not (hrp and hum) then return end
    hum.PlatformStand = true
    local bg = Instance.new("BodyGyro",     hrp); bg.MaxTorque = Vector3.new(9e9,9e9,9e9); bg.D = 50
    local bv = Instance.new("BodyVelocity", hrp); bv.MaxForce  = Vector3.new(9e9,9e9,9e9)
    flyConn = RunService.Heartbeat:Connect(function()
        if not State.Fly then
            bg:Destroy(); bv:Destroy()
            hum.PlatformStand = false
            flyConn:Disconnect()
            return
        end
        local dir = Vector3.zero
        if UserInputSvc:IsKeyDown(Enum.KeyCode.W) then dir += Camera.CFrame.LookVector end
        if UserInputSvc:IsKeyDown(Enum.KeyCode.S) then dir -= Camera.CFrame.LookVector end
        if UserInputSvc:IsKeyDown(Enum.KeyCode.A) then dir -= Camera.CFrame.RightVector end
        if UserInputSvc:IsKeyDown(Enum.KeyCode.D) then dir += Camera.CFrame.RightVector end
        if UserInputSvc:IsKeyDown(Enum.KeyCode.Space) then dir += Vector3.yAxis end
        if UserInputSvc:IsKeyDown(Enum.KeyCode.LeftControl) then dir -= Vector3.yAxis end
        bv.Velocity = dir * 50
        bg.CFrame = Camera.CFrame
    end)
end

-- ──────────────────────────────────────────
--  Fullbright
-- ──────────────────────────────────────────
local function ApplyFullbright(on)
    game:GetService("Lighting").Brightness = on and 10  or 1
    game:GetService("Lighting").ClockTime  = on and 14  or game:GetService("Lighting").ClockTime
    game:GetService("Lighting").FogEnd     = on and 9e9 or 100000
end

-- ──────────────────────────────────────────
--  Anti-AFK
-- ──────────────────────────────────────────
LocalPlayer.Idled:Connect(function()
    if State.AntiAFK then
        fireserver = fireserver or function() end -- stub
        LocalPlayer:Move(Vector3.new(1,0,0), true)
    end
end)

-- ──────────────────────────────────────────
--  FPS Boost
-- ──────────────────────────────────────────
local function ApplyFPSBoost(on)
    for _, obj in ipairs(workspace:GetDescendants()) do
        if obj:IsA("ParticleEmitter") or obj:IsA("Smoke") or obj:IsA("Fire") or obj:IsA("Sparkles") then
            obj.Enabled = not on
        end
        if obj:IsA("Decal") or obj:IsA("Texture") then
            obj.Transparency = on and 1 or 0
        end
    end
end

-- ──────────────────────────────────────────
--  Server Hop
-- ──────────────────────────────────────────
local function ServerHop()
    local placeId = game.PlaceId
    local ok2, servers = pcall(function()
        return game:HttpGet(
            "https://games.roblox.com/v1/games/" .. placeId .. "/servers/Public?sortOrder=Asc&limit=100"
        )
    end)
    if not ok2 then return end
    local data = game:GetService("HttpService"):JSONDecode(servers)
    for _, s in ipairs(data.data or {}) do
        if s.id ~= game.JobId and s.playing < s.maxPlayers then
            game:GetService("TeleportService"):TeleportToPlaceInstance(placeId, s.id)
            return
        end
    end
end

-- ──────────────────────────────────────────
--  Main UI
-- ──────────────────────────────────────────
local function LaunchMain()

    local Window = Library:CreateWindow({
        Name         = "JulzHub  ·  Rivals",
        Subtitle     = "v6.0  ·  by julzmon",
        Logo         = "rbxassetid://16255151491",
        ConfigFolder = "JulzHubRivals",
    })

    Library:SetNotification({
        Title   = "JulzHub Loaded",
        Content = "Welcome back. Stay safe out there.",
        Duration = 4,
    })

    -- ── COMBAT TAB ─────────────────────────
    local Combat = Window:CreateTab({ Name = "Combat", Icon = "rbxassetid://10734950309" })

    Combat:CreateSection("Aimbot")
    Combat:CreateToggle({
        Name = "Silent Aim",
        CurrentValue = false,
        Callback = function(v) State.SilentAim = v end,
    })
    Combat:CreateToggle({
        Name = "Aimbot",
        CurrentValue = false,
        Callback = function(v)
            State.Aimbot = v
            Library:Notify({ Title = "Aimbot", Content = v and "Enabled" or "Disabled", Duration = 2 })
        end,
    })
    Combat:CreateSlider({
        Name = "Smoothness", Min = 1, Max = 100, CurrentValue = 50,
        Callback = function(v) State.Smoothness = v end,
    })
    Combat:CreateSlider({
        Name = "FOV Circle", Min = 30, Max = 800, CurrentValue = 100,
        Callback = function(v) State.FOV = v end,
    })
    Combat:CreateSlider({
        Name = "Prediction (ms)", Min = 0, Max = 200, CurrentValue = 0,
        Callback = function(v) State.Prediction = v / 1000 end,
    })
    Combat:CreateDropdown({
        Name = "Aim Priority",
        Options = { "Head", "Neck", "Torso", "HumanoidRootPart" },
        CurrentOption = "Head",
        Callback = function(v) State.AimPriority = v end,
    })
    Combat:CreateDropdown({
        Name = "Aim Key",
        Options = { "RightMouse", "LeftMouse", "Q", "E", "X" },
        CurrentOption = "RightMouse",
        Callback = function(v)
            local map = {
                RightMouse = Enum.UserInputType.MouseButton2,
                LeftMouse  = Enum.UserInputType.MouseButton1,
                Q = Enum.KeyCode.Q, E = Enum.KeyCode.E, X = Enum.KeyCode.X,
            }
            State.AimKey = map[v] or Enum.UserInputType.MouseButton2
        end,
    })

    Combat:CreateSection("Weapon Mods")
    Combat:CreateToggle({
        Name = "Triggerbot",
        CurrentValue = false,
        Callback = function(v) State.Triggerbot = v end,
    })
    Combat:CreateToggle({
        Name = "No Recoil",
        CurrentValue = false,
        Callback = function(v) State.NoRecoil = v end,
    })
    Combat:CreateToggle({
        Name = "No Spread",
        CurrentValue = false,
        Callback = function(v) State.NoSpread = v end,
    })
    Combat:CreateToggle({
        Name = "Auto Reload",
        CurrentValue = false,
        Callback = function(v) State.AutoReload = v end,
    })
    Combat:CreateSlider({
        Name = "Hitbox Expander", Min = 1, Max = 20, CurrentValue = 1,
        Callback = function(v)
            State.HitboxSize = v
            for _, p in ipairs(GetEnemies()) do
                local char = p.Character
                if char then
                    for _, part in ipairs(char:GetChildren()) do
                        if part:IsA("BasePart") then
                            part.Size = part.Size * (v / State.HitboxSize)
                        end
                    end
                end
            end
        end,
    })

    -- ── VISUALS TAB ────────────────────────
    local Visuals = Window:CreateTab({ Name = "Visuals", Icon = "rbxassetid://10734897102" })

    Visuals:CreateSection("ESP")
    Visuals:CreateToggle({ Name = "Box ESP",     CurrentValue = false, Callback = function(v) State.BoxESP   = v end })
    Visuals:CreateToggle({ Name = "Skeleton",    CurrentValue = false, Callback = function(v) State.Skeleton  = v end })
    Visuals:CreateToggle({ Name = "Names",       CurrentValue = false, Callback = function(v) State.Names     = v end })
    Visuals:CreateToggle({ Name = "Distance",    CurrentValue = false, Callback = function(v) State.Distance  = v end })
    Visuals:CreateToggle({ Name = "Tracers",     CurrentValue = false, Callback = function(v) State.Tracers   = v end })
    Visuals:CreateToggle({ Name = "Health Bar",  CurrentValue = false, Callback = function(v) State.HealthBar = v end })
    Visuals:CreateToggle({ Name = "Chams",       CurrentValue = false, Callback = function(v) State.Chams     = v end })
    Visuals:CreateToggle({ Name = "Items",       CurrentValue = false, Callback = function(v) State.Items     = v end })
    Visuals:CreateSlider({ Name = "Box Thickness", Min = 1, Max = 5, CurrentValue = 1,
        Callback = function(v) State.BoxThickness = v end })
    Visuals:CreateColorPicker({
        Name = "ESP Color",
        Color = Color3.fromRGB(255, 50, 50),
        Callback = function(c) State.ESPColor = c end,
    })

    Visuals:CreateSection("Overlay")
    Visuals:CreateToggle({ Name = "Radar",      CurrentValue = false, Callback = function(v) State.Radar      = v end })
    Visuals:CreateToggle({ Name = "Indicators", CurrentValue = false, Callback = function(v) State.Indicators = v end })

    -- ── MOVEMENT TAB ───────────────────────
    local Move = Window:CreateTab({ Name = "Movement", Icon = "rbxassetid://10747373176" })

    Move:CreateSection("Physics")
    Move:CreateSlider({
        Name = "Walk Speed", Min = 16, Max = 200, CurrentValue = 16,
        Callback = function(v) State.Speed = v end,
    })
    Move:CreateSlider({
        Name = "Jump Power", Min = 50, Max = 350, CurrentValue = 50,
        Callback = function(v) State.JumpPower = v end,
    })
    Move:CreateToggle({
        Name = "Speed Boost",
        CurrentValue = false,
        Callback = function(v) State.SpeedBoost = v end,
    })
    Move:CreateToggle({
        Name = "Infinite Jump",
        CurrentValue = false,
        Callback = function(v) State.InfJump = v end,
    })
    Move:CreateToggle({
        Name = "Bhop",
        CurrentValue = false,
        Callback = function(v) State.Bhop = v end,
    })
    Move:CreateToggle({
        Name = "No Fall Damage",
        CurrentValue = false,
        Callback = function(v) State.NoFall = v end,
    })
    Move:CreateToggle({
        Name = "Auto Sprint",
        CurrentValue = false,
        Callback = function(v) State.AutoSprint = v end,
    })

    Move:CreateSection("Advanced")
    Move:CreateToggle({
        Name = "Fly  [W/A/S/D + Space/Ctrl]",
        CurrentValue = false,
        Callback = function(v)
            State.Fly = v
            if v then StartFly() end
        end,
    })
    Move:CreateToggle({
        Name = "Noclip",
        CurrentValue = false,
        Callback = function(v) State.Noclip = v end,
    })
    Move:CreateToggle({
        Name = "Spinbot",
        CurrentValue = false,
        Callback = function(v) State.Spinbot = v end,
    })

    -- ── UTILITY TAB ────────────────────────
    local Util = Window:CreateTab({ Name = "Utility", Icon = "rbxassetid://10734947300" })

    Util:CreateSection("World")
    Util:CreateToggle({
        Name = "Fullbright",
        CurrentValue = false,
        Callback = function(v) State.Fullbright = v; ApplyFullbright(v) end,
    })
    Util:CreateToggle({
        Name = "FPS Boost",
        CurrentValue = false,
        Callback = function(v) State.FPSBoost = v; ApplyFPSBoost(v) end,
    })
    Util:CreateToggle({
        Name = "Anti AFK",
        CurrentValue = false,
        Callback = function(v) State.AntiAFK = v end,
    })

    Util:CreateSection("Lobby")
    Util:CreateToggle({
        Name = "Auto Queue",
        CurrentValue = false,
        Callback = function(v) State.AutoQueue = v end,
    })
    Util:CreateButton({
        Name = "Server Hop",
        Callback = function()
            Library:Notify({ Title = "Server Hop", Content = "Finding server...", Duration = 3 })
            task.spawn(ServerHop)
        end,
    })
    Util:CreateButton({
        Name = "Rejoin",
        Callback = function()
            game:GetService("TeleportService"):Teleport(game.PlaceId, LocalPlayer)
        end,
    })

    Util:CreateSection("Social")
    Util:CreateToggle({
        Name = "Chat Bypass",
        CurrentValue = false,
        Callback = function(v) State.ChatBypass = v end,
    })
    Util:CreateToggle({
        Name = "Streamer Mode  (hides UI)",
        CurrentValue = false,
        Callback = function(v)
            State.StreamerMode = v
            -- hide/show handled by Luna's built-in toggle if supported
        end,
    })
    Util:CreateButton({
        Name = "Copy Discord",
        Callback = function()
            setclipboard("https://discord.gg/julzhub")
            Library:Notify({ Title = "Copied!", Content = "discord.gg/julzhub", Duration = 2 })
        end,
    })

    -- ── SETTINGS TAB ───────────────────────
    local Settings = Window:CreateTab({ Name = "Settings", Icon = "rbxassetid://10747384785" })

    Settings:CreateSection("Interface")
    Settings:CreateKeybind({
        Name = "Toggle UI",
        CurrentKeybind = "RightShift",
        Callback = function()
            Library:ToggleUI()
        end,
    })
    Settings:CreateDropdown({
        Name = "Theme",
        Options = { "Default", "Ocean", "Cherry", "Midnight", "Lime" },
        CurrentOption = "Default",
        Callback = function(v)
            local themes = {
                Default  = Color3.fromRGB(30,  30,  30),
                Ocean    = Color3.fromRGB(10,  40,  80),
                Cherry   = Color3.fromRGB(80,  10,  30),
                Midnight = Color3.fromRGB(10,  10,  25),
                Lime     = Color3.fromRGB(20,  50,  10),
            }
            -- Library:SetTheme({ Background = themes[v] })  -- if Luna supports it
        end,
    })
    Settings:CreateToggle({
        Name = "Show Watermark",
        CurrentValue = true,
        Callback = function(v)
            Library:ToggleWatermark(v)
        end,
    })

    Settings:CreateSection("Config")
    Settings:CreateButton({
        Name = "Save Config",
        Callback = function()
            Library:SaveConfig("default")
            Library:Notify({ Title = "Config", Content = "Saved!", Duration = 2 })
        end,
    })
    Settings:CreateButton({
        Name = "Load Config",
        Callback = function()
            Library:LoadConfig("default")
            Library:Notify({ Title = "Config", Content = "Loaded!", Duration = 2 })
        end,
    })

    Settings:CreateSection("Info")
    Settings:CreateLabel({ Name = "Build: v6.0  ·  Delta / Mobile" })
    Settings:CreateLabel({ Name = "Dev: julzmon  ·  discord.gg/julzhub" })

    Library:Init()
end

-- ──────────────────────────────────────────
--  Key System  (animated, polished)
-- ──────────────────────────────────────────
local function InitAuth()
    local Screen = Instance.new("ScreenGui")
    Screen.Name             = "JulzHub_Auth"
    Screen.ResetOnSpawn     = false
    Screen.ZIndexBehavior   = Enum.ZIndexBehavior.Sibling
    pcall(function() Screen.Parent = CoreGui end)

    -- Backdrop blur
    local Backdrop = Instance.new("Frame", Screen)
    Backdrop.Size            = UDim2.fromScale(1, 1)
    Backdrop.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    Backdrop.BackgroundTransparency = 1
    Backdrop.ZIndex = 0

    -- Animated gradient background
    local GradientFrame = Instance.new("Frame", Screen)
    GradientFrame.Size  = UDim2.fromScale(1, 1)
    GradientFrame.BackgroundColor3 = Color3.fromRGB(8, 8, 12)
    GradientFrame.ZIndex = 1

    local UIGrad = Instance.new("UIGradient", GradientFrame)
    UIGrad.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0,   Color3.fromRGB(8,  8,  20)),
        ColorSequenceKeypoint.new(0.5, Color3.fromRGB(15, 10, 30)),
        ColorSequenceKeypoint.new(1,   Color3.fromRGB(8,  8,  20)),
    })
    UIGrad.Rotation = 45

    -- Subtle rotation animation for gradient
    local gradAngle = 45
    local gradConn = RunService.Heartbeat:Connect(function(dt)
        gradAngle = (gradAngle + dt * 8) % 360
        UIGrad.Rotation = gradAngle
    end)

    -- Card
    local Card = Instance.new("Frame", Screen)
    Card.Size             = UDim2.new(0, 440, 0, 380)
    Card.Position         = UDim2.new(0.5, -220, 0.6, -190)  -- starts below centre
    Card.BackgroundColor3 = Color3.fromRGB(12, 12, 18)
    Card.BorderSizePixel  = 0
    Card.ZIndex           = 2
    Tween(Card, TweenInfo.new(0.6, Enum.EasingStyle.Expo, Enum.EasingDirection.Out),
        { Position = UDim2.new(0.5, -220, 0.5, -190) })

    Instance.new("UICorner", Card).CornerRadius = UDim.new(0, 16)

    -- Animated border (using a slightly larger frame behind card)
    local BorderFrame = Instance.new("Frame", Screen)
    BorderFrame.Size             = UDim2.new(0, 444, 0, 384)
    BorderFrame.Position         = UDim2.new(0.5, -222, 0.5, -192)
    BorderFrame.BackgroundColor3 = Color3.fromRGB(60, 40, 120)
    BorderFrame.BorderSizePixel  = 0
    BorderFrame.ZIndex           = 1
    Instance.new("UICorner", BorderFrame).CornerRadius = UDim.new(0, 17)

    local BorderGrad = Instance.new("UIGradient", BorderFrame)
    BorderGrad.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0,   Color3.fromRGB(120, 60, 220)),
        ColorSequenceKeypoint.new(0.5, Color3.fromRGB(60, 100, 200)),
        ColorSequenceKeypoint.new(1,   Color3.fromRGB(120, 60, 220)),
    })
    local bAngle = 0
    local borderConn = RunService.Heartbeat:Connect(function(dt)
        bAngle = (bAngle + dt * 60) % 360
        BorderGrad.Rotation = bAngle
    end)

    -- Logo / avatar
    local Logo = Instance.new("ImageLabel", Card)
    Logo.Size                = UDim2.new(0, 90, 0, 90)
    Logo.Position            = UDim2.new(0.5, -45, 0, 24)
    Logo.BackgroundTransparency = 1
    Logo.Image               = "rbxassetid://16255151491"
    Logo.ZIndex              = 3
    Instance.new("UICorner", Logo).CornerRadius = UDim.new(0.5, 0)

    -- Glow under logo
    local Glow = Instance.new("ImageLabel", Card)
    Glow.Size               = UDim2.new(0, 130, 0, 130)
    Glow.Position           = UDim2.new(0.5, -65, 0, 4)
    Glow.BackgroundTransparency = 1
    Glow.Image              = "rbxassetid://5028857084"  -- radial gradient asset
    Glow.ImageColor3        = Color3.fromRGB(100, 60, 200)
    Glow.ImageTransparency  = 0.6
    Glow.ZIndex             = 2

    -- "um... Can I help you?" typewriter
    local Headline = Instance.new("TextLabel", Card)
    Headline.Size            = UDim2.new(1, -20, 0, 30)
    Headline.Position        = UDim2.new(0, 10, 0, 124)
    Headline.Text            = ""
    Headline.TextColor3      = Color3.fromRGB(230, 230, 255)
    Headline.BackgroundTransparency = 1
    Headline.Font            = Enum.Font.GothamBold
    Headline.TextSize        = 20
    Headline.ZIndex          = 3

    local Sub = Instance.new("TextLabel", Card)
    Sub.Size                 = UDim2.new(1, -60, 0, 44)
    Sub.Position             = UDim2.new(0, 30, 0, 160)
    Sub.Text                 = "Unauthorized access detected.\nEnter your ThinkPad key to continue."
    Sub.TextColor3           = Color3.fromRGB(100, 100, 130)
    Sub.BackgroundTransparency = 1
    Sub.TextWrapped          = true
    Sub.Font                 = Enum.Font.Gotham
    Sub.TextSize             = 13
    Sub.ZIndex               = 3

    -- Textbox
    local BoxWrap = Instance.new("Frame", Card)
    BoxWrap.Size             = UDim2.new(0, 310, 0, 42)
    BoxWrap.Position         = UDim2.new(0.5, -155, 0, 218)
    BoxWrap.BackgroundColor3 = Color3.fromRGB(22, 22, 32)
    BoxWrap.BorderSizePixel  = 0
    BoxWrap.ZIndex           = 3
    Instance.new("UICorner", BoxWrap).CornerRadius = UDim.new(0, 10)
    local BoxStroke = Instance.new("UIStroke", BoxWrap)
    BoxStroke.Color = Color3.fromRGB(50, 40, 80)

    local Box = Instance.new("TextBox", BoxWrap)
    Box.Size                = UDim2.new(1, -20, 1, 0)
    Box.Position            = UDim2.new(0, 10, 0, 0)
    Box.BackgroundTransparency = 1
    Box.TextColor3          = Color3.fromRGB(220, 220, 255)
    Box.PlaceholderText     = "Enter key..."
    Box.PlaceholderColor3   = Color3.fromRGB(70, 70, 100)
    Box.Text                = ""
    Box.Font                = Enum.Font.Gotham
    Box.TextSize            = 14
    Box.ZIndex              = 4
    Box.ClearTextOnFocus    = false

    -- Focus glow
    Box.Focused:Connect(function()
        Tween(BoxStroke, TweenInfo.new(0.2), { Color = Color3.fromRGB(120, 80, 220) })
    end)
    Box.FocusLost:Connect(function()
        Tween(BoxStroke, TweenInfo.new(0.2), { Color = Color3.fromRGB(50, 40, 80) })
    end)

    -- Verify button
    local Btn = Instance.new("TextButton", Card)
    Btn.Size             = UDim2.new(0, 310, 0, 42)
    Btn.Position         = UDim2.new(0.5, -155, 0, 272)
    Btn.BackgroundColor3 = Color3.fromRGB(80, 50, 160)
    Btn.Text             = "VERIFY"
    Btn.TextColor3       = Color3.fromRGB(220, 220, 255)
    Btn.Font             = Enum.Font.GothamBold
    Btn.TextSize         = 14
    Btn.BorderSizePixel  = 0
    Btn.ZIndex           = 3
    Instance.new("UICorner", Btn).CornerRadius = UDim.new(0, 10)

    local BtnGrad = Instance.new("UIGradient", Btn)
    BtnGrad.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0,   Color3.fromRGB(100, 60, 200)),
        ColorSequenceKeypoint.new(1,   Color3.fromRGB(60,  80, 200)),
    })
    BtnGrad.Rotation = 90

    -- Hover effects
    Btn.MouseEnter:Connect(function()
        Tween(Btn, TweenInfo.new(0.15), { BackgroundColor3 = Color3.fromRGB(100, 65, 180) })
    end)
    Btn.MouseLeave:Connect(function()
        Tween(Btn, TweenInfo.new(0.15), { BackgroundColor3 = Color3.fromRGB(80, 50, 160) })
    end)

    -- Status label
    local Status = Instance.new("TextLabel", Card)
    Status.Size              = UDim2.new(1, 0, 0, 20)
    Status.Position          = UDim2.new(0, 0, 0, 322)
    Status.Text              = ""
    Status.TextColor3        = Color3.fromRGB(200, 80, 80)
    Status.BackgroundTransparency = 1
    Status.Font              = Enum.Font.Gotham
    Status.TextSize          = 12
    Status.ZIndex            = 3

    -- Loading bar (hidden by default)
    local LoadBG = Instance.new("Frame", Card)
    LoadBG.Size              = UDim2.new(0, 310, 0, 4)
    LoadBG.Position          = UDim2.new(0.5, -155, 0, 352)
    LoadBG.BackgroundColor3  = Color3.fromRGB(30, 25, 50)
    LoadBG.BorderSizePixel   = 0
    LoadBG.ZIndex            = 3
    LoadBG.Visible           = false
    Instance.new("UICorner", LoadBG).CornerRadius = UDim.new(1, 0)

    local LoadBar = Instance.new("Frame", LoadBG)
    LoadBar.Size             = UDim2.new(0, 0, 1, 0)
    LoadBar.BackgroundColor3 = Color3.fromRGB(120, 80, 220)
    LoadBar.BorderSizePixel  = 0
    Instance.new("UICorner", LoadBar).CornerRadius = UDim.new(1, 0)

    -- Typewriter for headline
    task.spawn(function()
        task.wait(0.4)
        local msg = "um... Can I help you?"
        for i = 1, #msg do
            Headline.Text = msg:sub(1, i)
            task.wait(0.04)
        end
    end)

    -- Verify logic
    Btn.MouseButton1Click:Connect(function()
        local entered = Box.Text:lower():gsub("%s+", "")
        if entered == "thinkpad" then
            Status.Text = ""
            Btn.Text    = "LOADING..."
            Btn.Active  = false

            -- Animate loading bar
            LoadBG.Visible = true
            Tween(LoadBar, TweenInfo.new(1.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                { Size = UDim2.new(1, 0, 1, 0) })

            task.wait(1.3)

            -- Fade out & destroy
            gradConn:Disconnect()
            borderConn:Disconnect()
            Tween(Screen, TweenInfo.new(0.4), {})  -- fade via backdrop
            Tween(Backdrop, TweenInfo.new(0.4), { BackgroundTransparency = 0 })
            task.wait(0.5)
            Screen:Destroy()
            LaunchMain()
        else
            -- Shake animation
            local orig = Card.Position
            local shakeInfo = TweenInfo.new(0.05, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, 4, true)
            Tween(Card, shakeInfo, { Position = orig + UDim2.new(0, 8, 0, 0) })
            Status.Text = "✗  Invalid key"
            Tween(BoxStroke, TweenInfo.new(0.15), { Color = Color3.fromRGB(200, 60, 60) })
            task.delay(1.5, function()
                Status.Text = ""
                Tween(BoxStroke, TweenInfo.new(0.2), { Color = Color3.fromRGB(50, 40, 80) })
            end)
        end
    end)
end

InitAuth()
