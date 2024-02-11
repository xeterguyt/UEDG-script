local isAutoMode = true
local autoCooldown = 2 -- Default cooldown for automatic attack
local currentSkill = "Sword Smash" -- Default skill

local function toggleMode()
    isAutoMode = not isAutoMode
    switchModeButton.Text = isAutoMode and "Automatic Mode" or "Manual Mode"
    
    if attackButton then
        attackButton.Visible = not isAutoMode
    end
end

local function executeSkill(skillName)
    local args = {
        [1] = skillName,
        [2] = true,
        [3] = false,
        [4] = 100,
        [5] = 0 -- Changed from 1 to 0
    }
    game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("Player"):WaitForChild("Skill"):FireServer(unpack(args))
end

local function createGui()
    local mainGui = Instance.new("ScreenGui")
    mainGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

    local mainFrame = Instance.new("Frame")
    mainFrame.Size = UDim2.new(0, 200, 0, 180) -- Increased height to accommodate input field
    mainFrame.Position = UDim2.new(0.5, -100, 0.5, -90) -- Adjusted position accordingly
    mainFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    mainFrame.BorderSizePixel = 0
    mainFrame.Active = true
    mainFrame.Draggable = true
    mainFrame.Parent = mainGui

    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, 0, 0, 20)
    title.Position = UDim2.new(0, 0, 0, 0)
    title.Text = "Xeter UEDG Cheat | v0.4"
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

    -- Add cooldown input field
    local cooldownLabel = Instance.new("TextLabel")
    cooldownLabel.Size = UDim2.new(1, 0, 0, 20)
    cooldownLabel.Position = UDim2.new(0, 0, 0, 80)
    cooldownLabel.Text = "Cooldown (s):"
    cooldownLabel.TextColor3 = Color3.new(1, 1, 1)
    cooldownLabel.BackgroundTransparency = 1
    cooldownLabel.Parent = mainFrame

    local cooldownInput = Instance.new("TextBox")
    cooldownInput.Size = UDim2.new(0, 150, 0, 30)
    cooldownInput.Position = UDim2.new(0.5, -75, 0, 100)
    cooldownInput.Text = tostring(autoCooldown) -- Default value
    cooldownInput.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    cooldownInput.BorderSizePixel = 0
    cooldownInput.TextColor3 = Color3.new(0, 0, 0)
    cooldownInput.Parent = mainFrame

    -- Create skill selection buttons
    local skillLabel = Instance.new("TextLabel")
    skillLabel.Size = UDim2.new(1, 0, 0, 20)
    skillLabel.Position = UDim2.new(0, 0, 0, 140)
    skillLabel.Text = "Select Skill:"
    skillLabel.TextColor3 = Color3.new(1, 1, 1)
    skillLabel.BackgroundTransparency = 1
    skillLabel.Parent = mainFrame

    local swordSmashButton = Instance.new("TextButton")
    swordSmashButton.Size = UDim2.new(0, 100, 0, 30)
    swordSmashButton.Position = UDim2.new(0.25, -50, 0, 160)
    swordSmashButton.Text = "Sword Smash"
    swordSmashButton.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
    swordSmashButton.BorderSizePixel = 0
    swordSmashButton.TextColor3 = Color3.new(1, 1, 1)
    swordSmashButton.Parent = mainFrame

    local heavySlashButton = Instance.new("TextButton")
    heavySlashButton.Size = UDim2.new(0, 100, 0, 30)
    heavySlashButton.Position = UDim2.new(0.75, -50, 0, 160)
    heavySlashButton.Text = "Heavy Slash"
    heavySlashButton.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
    heavySlashButton.BorderSizePixel = 0
    heavySlashButton.TextColor3 = Color3.new(1, 1, 1)
    heavySlashButton.Parent = mainFrame

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

    swordSmashButton.MouseButton1Click:Connect(function()
        currentSkill = "Sword Smash"
    end)

    heavySlashButton.MouseButton1Click:Connect(function()
        currentSkill = "Heavy Slash"
    end)

    attackButton.MouseButton1Click:Connect(function()
        if not isAutoMode then
            executeSkill(currentSkill)
        end
    end)

    cooldownInput.FocusLost:Connect(function(enterPressed)
        if not enterPressed then
            return
        end

        local newCooldown = tonumber(cooldownInput.Text)
        if newCooldown and newCooldown >= 0 then
            autoCooldown = newCooldown
        else
            cooldownInput.Text = tostring(autoCooldown) -- Revert to previous value
        end
    end)
end

createGui()

while true do
    if isAutoMode then
        executeSkill(currentSkill)
        wait(autoCooldown)
    else
        wait(0.1)
    end
end
