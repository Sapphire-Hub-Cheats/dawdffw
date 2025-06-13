--[[ SapphireLib UI (Orion-Style) ]]--

local Library = {}
Library.__index = Library

local TweenService = game:GetService("TweenService")

function Library:CreateWindow(config)
	local ScreenGui = Instance.new("ScreenGui")
	ScreenGui.Name = "SapphireUI"
	ScreenGui.ResetOnSpawn = false
	ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
	ScreenGui.Parent = game:GetService("CoreGui")

	local Main = Instance.new("Frame")
	Main.Size = UDim2.new(0, 600, 0, 400)
	Main.Position = UDim2.new(0.5, -300, 0.5, -200)
	Main.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
	Main.BorderSizePixel = 0
	Main.Parent = ScreenGui

	local UICorner = Instance.new("UICorner", Main)
	UICorner.CornerRadius = UDim.new(0, 10)

	local TabList = Instance.new("Frame", Main)
	TabList.Size = UDim2.new(0, 150, 1, 0)
	TabList.BackgroundColor3 = Color3.fromRGB(25, 25, 25)

	local TabLayout = Instance.new("UIListLayout", TabList)
	TabLayout.SortOrder = Enum.SortOrder.LayoutOrder
	TabLayout.Padding = UDim.new(0, 4)

	local ContentFrame = Instance.new("Frame", Main)
	ContentFrame.Position = UDim2.new(0, 150, 0, 0)
	ContentFrame.Size = UDim2.new(1, -150, 1, 0)
	ContentFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)

	local Tabs = {}

	function Library:CreateTab(name)
		local Button = Instance.new("TextButton", TabList)
		Button.Size = UDim2.new(1, 0, 0, 40)
		Button.Text = name
		Button.TextColor3 = Color3.fromRGB(255, 255, 255)
		Button.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
		Button.Font = Enum.Font.Gotham
		Button.TextSize = 16
		Button.BorderSizePixel = 0

		local Tab = Instance.new("ScrollingFrame", ContentFrame)
		Tab.Size = UDim2.new(1, 0, 1, 0)
		Tab.CanvasSize = UDim2.new(0, 0, 0, 0)
		Tab.ScrollBarThickness = 6
		Tab.BackgroundTransparency = 1
		Tab.Visible = false
		local Layout = Instance.new("UIListLayout", Tab)
		Layout.Padding = UDim.new(0, 6)
		Layout.SortOrder = Enum.SortOrder.LayoutOrder

		local TabAPI = {}

		function TabAPI:AddButton(text, callback)
			local Btn = Instance.new("TextButton", Tab)
			Btn.Size = UDim2.new(1, -10, 0, 30)
			Btn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
			Btn.TextColor3 = Color3.fromRGB(255, 255, 255)
			Btn.Font = Enum.Font.Gotham
			Btn.TextSize = 14
			Btn.BorderSizePixel = 0
			Btn.Text = text
			Btn.MouseButton1Click:Connect(function()
				if callback then callback() end
			end)
		end

		function TabAPI:AddToggle(text, callback)
			local Toggle = Instance.new("TextButton", Tab)
			Toggle.Size = UDim2.new(1, -10, 0, 30)
			Toggle.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
			Toggle.TextColor3 = Color3.fromRGB(255, 255, 255)
			Toggle.Font = Enum.Font.Gotham
			Toggle.TextSize = 14
			Toggle.BorderSizePixel = 0
			Toggle.Text = "[OFF] " .. text

			local state = false
			Toggle.MouseButton1Click:Connect(function()
				state = not state
				Toggle.Text = (state and "[ON] " or "[OFF] ") .. text
				if callback then callback(state) end
			end)
		end

		function TabAPI:AddLabel(text)
			local Label = Instance.new("TextLabel", Tab)
			Label.Size = UDim2.new(1, -10, 0, 30)
			Label.BackgroundTransparency = 1
			Label.TextColor3 = Color3.fromRGB(200, 200, 200)
			Label.Font = Enum.Font.Gotham
			Label.TextSize = 14
			Label.Text = text
		end

		Button.MouseButton1Click:Connect(function()
			for _, tab in pairs(ContentFrame:GetChildren()) do
				if tab:IsA("ScrollingFrame") then tab.Visible = false end
			end
			for _, btn in pairs(TabList:GetChildren()) do
				if btn:IsA("TextButton") then
					TweenService:Create(btn, TweenInfo.new(0.2), {
						BackgroundColor3 = Color3.fromRGB(40, 40, 40)
					}):Play()
				end
			end
			TweenService:Create(Button, TweenInfo.new(0.2), {
				BackgroundColor3 = Color3.fromRGB(0, 170, 0)
			}):Play()
			Tab.Visible = true
		end)

		if #Tabs == 0 then
			Tab.Visible = true
			Button.BackgroundColor3 = Color3.fromRGB(0, 170, 0)
		end

		table.insert(Tabs, Tab)
		return TabAPI
	end

	return Library
end

return setmetatable({}, Library)
