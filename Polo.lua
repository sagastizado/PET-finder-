-- CONFIGURACIÓN
local MIN_VALUE = 100000000 -- 100M
local VALUE_ATTRIBUTE = "Value" -- Nombre del objeto NumberValue dentro del modelo

-- Servidores
local Players = game:GetService("Players")
local player = Players.LocalPlayer

-- CREAR GUI
local gui = Instance.new("ScreenGui")
gui.Name = "HighValueFinder"
gui.Parent = player.PlayerGui

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.fromScale(0.4,0.5)
frame.Position = UDim2.fromScale(0.3,0.25)
frame.BackgroundColor3 = Color3.fromRGB(20,20,20)
Instance.new("UICorner", frame).CornerRadius = UDim.new(0,15)

local title = Instance.new("TextLabel", frame)
title.Size = UDim2.fromScale(1,0.15)
title.BackgroundTransparency = 1
title.Text = "🔎 HIGH VALUE FINDER"
title.TextColor3 = Color3.new(1,1,1)
title.Font = Enum.Font.GothamBold
title.TextScaled = true

local list = Instance.new("ScrollingFrame", frame)
list.Position = UDim2.fromScale(0.05,0.18)
list.Size = UDim2.fromScale(0.9,0.55)
list.ScrollBarImageTransparency = 0.5
Instance.new("UIListLayout", list).Padding = UDim.new(0,6)

local searchBtn = Instance.new("TextButton", frame)
searchBtn.Position = UDim2.fromScale(0.1,0.78)
searchBtn.Size = UDim2.fromScale(0.35,0.13)
searchBtn.Text = "🔍 Buscar >100M"
searchBtn.Font = Enum.Font.GothamBold
searchBtn.TextScaled = true
searchBtn.BackgroundColor3 = Color3.fromRGB(70,70,70)
searchBtn.TextColor3 = Color3.new(1,1,1)
Instance.new("UICorner", searchBtn)

-- FUNCIONES
local function clearList()
    for _, v in ipairs(list:GetChildren()) do
        if v:IsA("TextButton") then
            v:Destroy()
        end
    end
end

local function findHighValueItems()
    clearList()

    for _, obj in ipairs(workspace:GetDescendants()) do
        if obj:IsA("Model") and obj:FindFirstChild(VALUE_ATTRIBUTE) then
            local val = obj[VALUE_ATTRIBUTE].Value
            if type(val) == "number" and val >= MIN_VALUE then
                local itemBtn = Instance.new("TextButton", list)
                itemBtn.Size = UDim2.fromScale(1,0)
                itemBtn.AutomaticSize = Enum.AutomaticSize.Y
                itemBtn.TextWrapped = true
                itemBtn.Text = "⭐ ".. obj.Name .. " — Val: ".. val
                itemBtn.TextColor3 = Color3.new(1,1,1)
                itemBtn.BackgroundColor3 = Color3.fromRGB(45,45,45)
                Instance.new("UICorner", itemBtn)
            end
        end
    end
end

-- Conectar
searchBtn.MouseButton1Click:Connect(findHighValueItems)
