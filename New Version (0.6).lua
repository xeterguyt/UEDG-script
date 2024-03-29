local Version = "0.6.2"
-- Create UI frame and button

local isAutoMode = true

local autoCooldown = 2 -- Default cooldown for automatic attack
local currentSkillIndex = 1 -- Default index for selected skill

local skills = {"Sword Smash", "Heavy Slash", "Zephyr Cut", "Healing Wave", "Mini Heal", "Rapid Slashes","Halfmoon Slash","Triple Slash"} -- List of available skills

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
        [5] = 0 -- Mana consumption
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
    title.Text = "Xeter UEDG Cheat | v" .. Version
    title.TextColor3 = Color3.new(1, 1, 1)
    title.BackgroundTransparency = 1
    title.Parent = mainFrame

    
local warning = Instance.new("TextLabel")
warning.Size = UDim2.new(1, 0, 0.5, -200)
warning.Position = UDim2.new(0, 0, 0, 0)
warning.TextWrapped = true
warning.Text = "Note: if you were using this cheat, remember, I'M NOT RESPONSIBLE FOR ANYTHING THAT COULD HAPPEN"
warning.TextColor3 = Color3.new(1, 0, 0)
warning.BackgroundTransparency = 1
warning.Parent = mainFrame

local closeButton = Instance.new("TextButton")
closeButton.Size = UDim2.new(0, 20, 0, 20)
closeButton.Position = UDim2.new(1, -20, 0, 5)
closeButton.Text = "X"
closeButton.Parent = warning

closeButton.MouseButton1Click:Connect(function()
    warning.Visible = false
end)


    
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


-- Create outline for mainFrame
    local mainFrameOutline = Instance.new("Frame")
    mainFrameOutline.Size = UDim2.new(1, 4, 1, 4)
    mainFrameOutline.Position = UDim2.new(0, -2, 0, -2)
    mainFrameOutline.BackgroundColor3 = Color3.fromRGB(192, 192, 192)
    mainFrameOutline.BorderSizePixel = 0
    mainFrameOutline.ZIndex = mainFrame.ZIndex - 1
    mainFrameOutline.Parent = mainFrame

    -- Attack button
    local attackGui = Instance.new("ScreenGui")
    attackGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

    local attackFrame = Instance.new("Frame")
    attackFrame.Size = UDim2.new(0, 60, 0, 60)
    attackFrame.Position = UDim2.new(1, -100, 0.5, -15)
    attackFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    attackFrame.BorderSizePixel = 0
    attackFrame.Parent = attackGui

    attackButton = Instance.new("TextButton")
    attackButton.Size = UDim2.new(0.8, 0, 0.8, 0)
    attackButton.Position = UDim2.new(0.1, 0, 0.1, 0)
    attackButton.Text = "A"
    attackButton.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
    attackButton.BorderSizePixel = 0
    attackButton.TextColor3 = Color3.new(1, 1, 1)
    attackButton.Visible = false
    attackButton.Parent = attackFrame

--Attack Button Outline
    local AttackFrameOutline = Instance.new("Frame")
    AttackFrameOutline.Size = UDim2.new(1, 4, 1, 4)
    AttackFrameOutline.Position = UDim2.new(0, -2, 0, -2)
    AttackFrameOutline.BackgroundColor3 = Color3.fromRGB(192, 192, 192)
    AttackFrameOutline.BorderSizePixel = 0
    AttackFrameOutline.ZIndex = attackFrame.ZIndex - 1
    AttackFrameOutline.Parent = attackFrame

    
    -- Create skill selection buttons
    local skillLabel = Instance.new("TextLabel")
    skillLabel.Size = UDim2.new(1, 0, 0, 20)
    skillLabel.Position = UDim2.new(0, 0, 0, 140)
    skillLabel.Text = "Select Skill:"
    skillLabel.TextColor3 = Color3.new(1, 1, 1)
    skillLabel.BackgroundTransparency = 1
    skillLabel.Parent = mainFrame

    local arrowLeft = Instance.new("TextButton")
    arrowLeft.Size = UDim2.new(0, 20, 0, 20)
    arrowLeft.Position = UDim2.new(0.25, -30, 0, 160)
    arrowLeft.Text = "<"
    arrowLeft.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
    arrowLeft.BorderSizePixel = 0
    arrowLeft.TextColor3 = Color3.new(1, 1, 1)
    arrowLeft.Parent = mainFrame

    local skillNameLabel = Instance.new("TextLabel")
    skillNameLabel.Size = UDim2.new(0, 100, 0, 20)
    skillNameLabel.Position = UDim2.new(0.5, -50, 0, 160)
    skillNameLabel.Text = skills[currentSkillIndex]
    skillNameLabel.TextColor3 = Color3.new(1, 1, 1)
    skillNameLabel.BackgroundTransparency = 1
    skillNameLabel.Parent = mainFrame

    local arrowRight = Instance.new("TextButton")
    arrowRight.Size = UDim2.new(0, 20, 0, 20)
    arrowRight.Position = UDim2.new(0.75, 10, 0, 160)
    arrowRight.Text = ">"
    arrowRight.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
    arrowRight.BorderSizePixel = 0
    arrowRight.TextColor3 = Color3.new(1, 1, 1)
    arrowRight.Parent = mainFrame

    arrowLeft.MouseButton1Click:Connect(function()
        currentSkillIndex = currentSkillIndex - 1
        if currentSkillIndex < 1 then
            currentSkillIndex = #skills
        end
        skillNameLabel.Text = skills[currentSkillIndex]
    end)

    arrowRight.MouseButton1Click:Connect(function()
        currentSkillIndex = currentSkillIndex + 1
        if currentSkillIndex > #skills then
            currentSkillIndex = 1
        end
        skillNameLabel.Text = skills[currentSkillIndex]
    end)

    switchModeButton.MouseButton1Click:Connect(function()
        toggleMode()
    end)

    attackButton.MouseButton1Click:Connect(function()
        if not isAutoMode then
            executeSkill(skills[currentSkillIndex])
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
        executeSkill(skills[currentSkillIndex])
        wait(autoCooldown)
    else
        wait(0.1)
    end
end
