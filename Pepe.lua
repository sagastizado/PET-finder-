-- ========= CONFIG =========
local MIN_VALUE = 100000000 -- 100M
local REQUIRE_SECRET = true -- solo secretos
-- ==========================

local Players = game:GetService("Players")
local player = Players.LocalPlayer

local finderOn = false

-- GUI
local gui = Instance.new("ScreenGui")
gui.Name = "MobileFinderToggle"
gui.ResetOnSpawn = false
gui.Parent = player.PlayerGui

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.fromScale(0.9,0.8)
frame.Position = UDim2.fromScale(0.05,0.1)
frame.BackgroundColor3 = Color3.fromRGB(20,20,20)
frame.BorderSizePixel = 0
Instance.new("UICorner", frame).CornerRadius = UDim.new(0,20)

local title = Instance.new("TextLabel", frame)
title.Size = UDim2.fromScale(1,0.1)
title.BackgroundTransparency = 1
title.Text = "🔎 SECRET FINDER"
title.Font = Enum.Font.GothamBold
title.TextScaled = true
title.TextColor3 = Color3.new(1,1,1)

-- LISTA
local list = Instance.new("ScrollingFrame", frame)
list.Position = UDim2.fromScale(0.05,0.12)
list.Size = UDim2.fromScale(0.9,0.6)
list.CanvasSize = UDim2.new(0,0,0,0)
list.ScrollBarThickness = 10

local layout = Instance.new("UIListLayout", list)
layout.Padding = UDim.new(0,10)

-- BOTÓN TOGGLE
local toggleBtn = Instance.new("TextButton", frame)
