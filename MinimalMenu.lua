-- MinimalMenu Library
-- Sapphire UI Library (Minimal)
-- Made for Roblox

local MinimalMenu = {}
MinimalMenu.__index = MinimalMenu

-- Library Theme
local theme = {
    Background = Color3.fromRGB(25, 25, 25),
    Accent = Color3.fromRGB(0, 200, 0),
    Text = Color3.fromRGB(255, 255, 255),
    Font = Enum.Font.Gotham,
    CornerRadius = UDim.new(0, 6)
}

-- Helper: Create UI element
local function create(instanceType, properties)
    local inst = Instance.new(instanceType)
    for prop, val in pairs(properties) do
        inst[prop] = val
    end
    return inst
end

-- Main Library Function
function MinimalMenu.new(title)
    local self = setmetatable({}, MinimalMenu)

    -- UI Container
    local screenGui = create("ScreenGui", {
        Name = "MinimalMenu",
        ResetOnSpawn = false,
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    })
    screenGui.Parent = game:GetService("CoreGui")

    local mainFrame = create("Frame", {
        Size = UDim2.new(0, 450, 0, 300),
        Position = UDim2.new(0.5, -225, 0.5, -150),
        AnchorPoint = Vector2.new(0.5, 0.5),
        BackgroundColor3 = theme.Background,
        BorderSizePixel = 0,
        Name = "MainFrame"
    })
    mainFrame.Parent = screenGui

    create("UICorner", { CornerRadius = theme.CornerRadius, Parent = mainFrame })

    local titleLabel = create("TextLabel", {
        Size = UDim2.new(1, 0, 0, 30),
        BackgroundTransparency = 1,
        Text = title or "MinimalMenu",
        TextColor3 = theme.Text,
        Font = theme.Font,
        TextSize = 20,
        Parent = mainFrame
    })

    -- Tab Container
    local tabHolder = create("Frame", {
        Size = UDim2.new(1, 0, 1, -30),
        Position = UDim2.new(0, 0, 0, 30),
        BackgroundTransparency = 1,
        Name = "TabHolder",
        Parent = mainFrame
    })

    local tabButtons = {}
    local tabs = {}

    -- Add Tab
    function self:AddTab(name)
        local tabButton = create("TextButton", {
            Size = UDim2.new(0, 100, 0, 30),
            BackgroundColor3 = theme.Accent,
            Text = name,
            Font = theme.Font,
            TextSize = 16,
            TextColor3 = theme.Text,
            Parent = mainFrame
        })

        tabButton.Position = UDim2.new(0, #tabButtons * 100, 0, 0)

        local tabContent = create("ScrollingFrame", {
            Size = UDim2.new(1, -10, 1, -10),
            Position = UDim2.new(0, 5, 0, 5),
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            ScrollBarThickness = 6,
            CanvasSize = UDim2.new(0, 0, 0, 0),
            Visible = false,
            Parent = tabHolder
        })

        create("UIListLayout", {
            Padding = UDim.new(0, 6),
            SortOrder = Enum.SortOrder.LayoutOrder,
            Parent = tabContent
        })

        table.insert(tabButtons, tabButton)
        table.insert(tabs, tabContent)

        tabButton.MouseButton1Click:Connect(function()
            for i, tab in pairs(tabs) do
                tab.Visible = false
                tabButtons[i].BackgroundColor3 = theme.Accent
            end
            tabContent.Visible = true
            tabButton.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
        end)

        if #tabs == 1 then
            tabContent.Visible = true
        end

        local tabApi = {}

        -- Add Button
        function tabApi:AddButton(text, callback)
            local btn = create("TextButton", {
                Size = UDim2.new(1, 0, 0, 30),
                BackgroundColor3 = Color3.fromRGB(40, 40, 40),
                BorderSizePixel = 0,
                Text = text,
                Font = theme.Font,
                TextSize = 16,
                TextColor3 = theme.Text,
                Parent = tabContent
            })

            btn.MouseButton1Click:Connect(function()
                if callback then callback() end
            end)

            return btn
        end

        return tabApi
    end

    return self
end

return setmetatable({}, MinimalMenu)
