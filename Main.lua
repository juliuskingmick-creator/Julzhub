--[[
JULZ hub | V46 Overhauled - Mobile Optimized
Updates: Added Fly (smooth + gyro), Noclip, JumpPower, Camera FOV, Unload Button
Fixed ALL syntax (curly quotes → straight), cleaner code, better organization
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
local StarterGui = game:GetService("StarterGui")

-- 1. MOBILE-READY KEY SYSTEM
local function LoadKeySystem()
    local AuthGui = Instance.new("ScreenGui", game:GetService("CoreGui"))
    AuthGui.Name = "JULZKeySystem"
    
    local MainFrame = Instance.new("Frame", AuthGui)
    MainFrame.Size = UDim2.new(0, 320, 0, 260)
    MainFrame.Position = UDim2.new(0.5, -160, 0.5, -130)
    MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
    MainFrame.Active = true
    MainFrame.Draggable = true
    
    Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 8)

    local Title = Instance.new("TextLabel", MainFrame)
    Title.Text = "JULZ HUB V46"
    Title.Size = UDim2.new(1, 0, 0, 50)
    Title.BackgroundTransparency = 1
    Title.TextColor3 = Color3.new(1, 1, 1)
    Title.Font = Enum.Font.GothamBold
    Title.TextSize = 18

    local Input = Instance.new("TextBox", MainFrame)
    Input.PlaceholderText = "Enter Key..."
    Input.Size = UDim2.new(0.85, 0, 0, 45)
    Input.Position = UDim2.new(0.075, 0, 0.25, 0)
    Input.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    Input.TextColor3 = Color3.new(1, 1, 1)
    Instance.new("UICorner", Input).CornerRadius = UDim.new(0, 6)

    local Submit = Instance.new("TextButton", MainFrame)
    Submit.Text = "LOG IN"
    Submit.Size = UDim2.new(0.85, 0, 0, 45)
    Submit.Position = UDim2.new(0.075, 0, 0.48,
