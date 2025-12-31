-- ========= CONFIG =========
local MIN_VALUE = 100000000 -- 100M (opcional)
local REQUIRE_SECRET = true -- solo secretos
-- ==========================

local Players = game:GetService("Players")
local player = Players.LocalPlayer

-- GUI
local gui = Instance.new("ScreenGui", player.PlayerGui)
gui.Name = "SecretFinderGUI"
gui.ResetOnSpawn = false

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.fromScale(0.42,0.55)
frame.Position = UDim2.fromScale(0.29,0.22)
frame.BackgroundColor3 = Color3.fromRGB(25,25,25)
frame.BorderSizePixel = 0
Instance.new("UICorner", frame).CornerRadius = UDim.new(0,18)

local title = Instance.new("TextLabel", frame)
title.Size = UDim2.fromScale(1,0.14)
title.BackgroundTransparency = 1
title.Text = "🔒 SECRET FINDER"
title.Font = Enum.Font.GothamBold
title.TextScaled = true
title.TextColor3 = Color3.new(1,1,1)

local list = Instance.new("ScrollingFrame", frame)
list.Position = UDim2.fromScale(0.05,0.17)
list.Size = UDim2.fromScale(0.9,0.58)
list.ScrollBarImageTransparency = 0.5
Instance.new("UIListLayout", list).Padding = UDim.new(0,8)

local searchBtn = Instance.new("TextButton", frame)
searchBtn.Position = UDim2.fromScale(0.1,0.78)
searchBtn.Size = UDim2.fromScale(0.35,0.12)
searchBtn.Text = "🔍 Buscar Secretos"
searchBtn.Font = Enum.Font.GothamBold
searchBtn.TextScaled = true
searchBtn.BackgroundColor3 = Color3.fromRGB(70,70,70)
searchBtn.TextColor3 = Color3.new(1,1,1)
Instance.new("UICorner", searchBtn)

local closeBtn = Instance.new("TextButton", frame)
closeBtn.Position = UDim2.fromScale(0.55,0.78)
closeBtn.Size = UDim2.fromScale(0.35,0.12)
closeBtn.Text = "❌ Cerrar"
closeBtn.Font = Enum.Font.GothamBold
closeBtn.TextScaled = true
closeBtn.BackgroundColor3 = Color3.fromRGB(90,40,40)
closeBtn.TextColor3 = Color3.new(1,1,1)
Instance.new("UICorner", closeBtn)

-- Funciones
local function clear()
	for _, c in ipairs(list:GetChildren()) do
		if c:IsA("TextButton") then c:Destroy() end
	end
end

local function addItem(model)
	local combo = model:GetAttribute("Combo") or "—"
	local val = model:GetAttribute("Value")

	local txt = "⭐ "..model.Name.." | Combo: "..combo
	if typeof(val) == "number" then
		txt ..= " | Val: "..val
	end

	local b = Instance.new("TextButton", list)
	b.Size = UDim2.fromScale(1,0)
	b.AutomaticSize = Enum.AutomaticSize.Y
	b.TextWrapped = true
	b.Text = txt
	b.Font = Enum.Font.Gotham
	b.TextScaled = true
	b.BackgroundColor3 = Color3.fromRGB(45,45,45)
	b.TextColor3 = Color3.new(1,1,1)
	Instance.new("UICorner", b)
end

local function findSecrets()
	clear()
	for _, obj in ipairs(workspace:GetDescendants()) do
		if obj:IsA("Model") then
			if REQUIRE_SECRET and obj:GetAttribute("Secret") ~= true then
				continue
			end
			local val = obj:GetAttribute("Value")
			if typeof(val) == "number" and val < MIN_VALUE then
				continue
			end
			addItem(obj)
		end
	end
end

searchBtn.MouseButton1Click:Connect(findSecrets)
closeBtn.MouseButton1Click:Connect(function() gui:Destroy() end)
