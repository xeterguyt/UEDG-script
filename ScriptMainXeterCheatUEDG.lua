local isAutoMode = true

local function toggleMode()
    isAutoMode = not isAutoMode
    switchModeButton.Text = isAutoMode and "Automatic Mode" or "Manual Mode"
    
    if attackButton then
        attackButton.Visible = not isAutoMode
    end
end

local function executeSmashAttack()
    local args = {
        [1] = "Sword Smash",
        [2] = true,
        [3] = true,
        [4] = 10000,
        [5] = 0
    }
    game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("Player"):WaitForChild("Skill"):FireServer(unpack(args))
end

local function createGui()
    local mainGui = Instance.new("ScreenGui")
    mainGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

    local mainFrame = Instance.new("Frame")
    mainFrame.Size = UDim2.new(0, 200, 0, 150)
    mainFrame.Position = UDim2.new(0.5, -100, 0.5, -75)
    mainFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    mainFrame.BorderSizePixel = 0
    mainFrame.Active = true
    mainFrame.Draggable = true
    mainFrame.Parent = mainGui

    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, 0, 0, 20)
    title.Position = UDim2.new(0, 0, 0, 0)
    title.Text = "Xeter UEDG Cheat"
    title.TextColor3 = Color3.new(1, 1, 1)
    title.BackgroundTransparency = 1
    title.Parent = mainFrame

    switchModeButton = Instance.new("TextButton")
    switchModeButton.Size = UDim2.new(0, 150, 0, 30)
    switchModeButton.Position = UDim2.new(0.5, -75, 0, 40)
    switchModeButton.Text = "Automatic Mode"
    switchModeButton.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
    switchModeButton.BorderSizePixel = 0
    switchModeButton.TextColor3 = Color3.new(1, 1, 1)
    switchModeButton.Parent = mainFrame

    -- Create outline for mainFrame
    local mainFrameOutline = Instance.new("Frame")
    mainFrameOutline.Size = UDim2.new(1, 4, 1, 4)
    mainFrameOutline.Position = UDim2.new(0, -2, 0, -2)
    mainFrameOutline.BackgroundColor3 = Color3.fromRGB(192, 192, 192)
    mainFrameOutline.BorderSizePixel = 0
    mainFrameOutline.ZIndex = mainFrame.ZIndex - 1
    mainFrameOutline.Parent = mainFrame

    local attackGui = Instance.new("ScreenGui")
    attackGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

    local attackFrame = Instance.new("Frame")
    attackFrame.Size = UDim2.new(0, 30, 0, 30)
    attackFrame.Position = UDim2.new(1, -40, 0.5, -15)
    attackFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    attackFrame.BorderSizePixel = 0
    attackFrame.Parent = attackGui

    attackButton = Instance.new("TextButton")
    attackButton.Size = UDim2.new(1, 0, 1, 0)
    attackButton.Position = UDim2.new(0, 0, 0, 0)
    attackButton.Text = "A"
    attackButton.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
    attackButton.BorderSizePixel = 0
    attackButton.TextColor3 = Color3.new(1, 1, 1)
    attackButton.Visible = false
    attackButton.Parent = attackFrame

    switchModeButton.MouseButton1Click:Connect(function()
        toggleMode()
    end)

    attackButton.MouseButton1Click:Connect(function()
        if not isAutoMode then
            executeSmashAttack()
        end
    end)
end

createGui()

while true do
    if isAutoMode then
        executeSmashAttack()
        wait(2)
    else
        wait(0.1)
    end
end
