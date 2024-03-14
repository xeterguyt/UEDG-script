-- Hp bar

-- Function to create health bar
local function createHealthBar()
    -- Create a ScreenGui for the health bar
    local healthGui = Instance.new("ScreenGui")
    healthGui.Name = "HealthGui"
    healthGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

    -- Create a Frame for the health bar background
    local backgroundFrame = Instance.new("Frame")
    backgroundFrame.Name = "BackgroundFrame"
    backgroundFrame.Size = UDim2.new(0.2, 0, 0.05, 0)
    backgroundFrame.Position = UDim2.new(0.4, 0, 0.01, 0)
    backgroundFrame.BackgroundColor3 = Color3.new(0, 0, 0)
    backgroundFrame.BorderSizePixel = 2
    backgroundFrame.Parent = healthGui

    -- Create a Frame for the health bar
    local healthFrame = Instance.new("Frame")
    healthFrame.Name = "HealthFrame"
    healthFrame.Size = UDim2.new(1, -4, 1, -4)
    healthFrame.Position = UDim2.new(0, 2, 0, 2)
    healthFrame.BackgroundColor3 = Color3.new(0, 1, 0)
    healthFrame.BorderSizePixel = 0
    healthFrame.Parent = backgroundFrame

    -- Create a TextLabel for the health percentage indicator
    local percentageLabel = Instance.new("TextLabel")
    percentageLabel.Name = "PercentageLabel"
    percentageLabel.Size = UDim2.new(0.2, 0, 0.5, 0)
    percentageLabel.Position = UDim2.new(0.4, 0, 0.25, 0)
    percentageLabel.AnchorPoint = Vector2.new(0.5, 0.5)
    percentageLabel.BackgroundTransparency = 1
    percentageLabel.TextColor3 = Color3.new(1, 1, 1)
    percentageLabel.Font = Enum.Font.SourceSansBold
    percentageLabel.TextSize = 14
    percentageLabel.Parent = backgroundFrame

    return backgroundFrame, healthFrame, percentageLabel
end

-- Function to update the health bar
local function updateHealth(healthFrame, percentageLabel)
    local player = game.Players.LocalPlayer
    if player.Character then
        local humanoid = player.Character:FindFirstChildOfClass("Humanoid")
        if humanoid then
            local maxHealth = humanoid.MaxHealth
            local currentHealth = math.clamp(humanoid.Health, 0, maxHealth)
            local healthPercentage = currentHealth / maxHealth
            
            -- Update the size of the health bar
            healthFrame.Size = UDim2.new(math.clamp(healthPercentage, 0, 1), -4, 1, -4)
            
            -- Change color based on health percentage
            if healthPercentage >= 0.5 then
                healthFrame.BackgroundColor3 = Color3.new(0, 1, 0) -- Green
            elseif healthPercentage >= 0.2 then
                healthFrame.BackgroundColor3 = Color3.new(1, 1, 0) -- Yellow
            else
                healthFrame.BackgroundColor3 = Color3.new(1, 0, 0) -- Red
            end
            
            -- Update the percentage label
            percentageLabel.Text = tostring(math.floor(healthPercentage * 100)) .. "%"
            percentageLabel.Position = UDim2.new(0.5, 0, 0.5, 0)
        end
    end
end

-- Function to handle character added event
local function characterAdded(character)
    wait() -- wait for the character to fully load
    updateHealth(healthFrame, percentageLabel)
    
    -- Connect to humanoid's health change event
    character:WaitForChild("Humanoid").Changed:Connect(function(property)
        if property == "Health" then
            updateHealth(healthFrame, percentageLabel)
        end
    end)
end

-- Recreate health bar whenever player respawns
game.Players.LocalPlayer.CharacterAdded:Connect(function(character)
    -- Create health bar
    backgroundFrame, healthFrame, percentageLabel = createHealthBar()
    
    -- Handle initial update
    characterAdded(character)
end)

-- Handle initial character
if game.Players.LocalPlayer.Character then
    -- Create health bar
    backgroundFrame, healthFrame, percentageLabel = createHealthBar()
    
    -- Handle initial update
    characterAdded(game.Players.LocalPlayer.Character)
end

--  ------------------------- hmmmm this us the BORDER SUR!!!





-- Function to create a notification message
local function sendNotification(title, description)
    local NotificationGui = Instance.new("ScreenGui")
    NotificationGui.Name = "NotificationGui"
    NotificationGui.Parent = game.Players.LocalPlayer.PlayerGui

    local Frame = Instance.new("Frame")
    Frame.Name = "NotificationFrame"
    Frame.Size = UDim2.new(0.25, 0, 0.1, 0)
    Frame.Position = UDim2.new(0.375, 0, 0.9, 0)
    Frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    Frame.BorderSizePixel = 2
    Frame.Parent = NotificationGui

    local TitleLabel = Instance.new("TextLabel")
    TitleLabel.Name = "TitleLabel"
    TitleLabel.Size = UDim2.new(1, 0, 0.5, 0)
    TitleLabel.Position = UDim2.new(0, 0, 0, 0)
    TitleLabel.Text = title
    TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    TitleLabel.BackgroundTransparency = 1
    TitleLabel.Font = Enum.Font.SourceSansBold
    TitleLabel.TextSize = 18
    TitleLabel.Parent = Frame

    local DescriptionLabel = Instance.new("TextLabel")
    DescriptionLabel.Name = "DescriptionLabel"
    DescriptionLabel.Size = UDim2.new(1, 0, 0.5, 0)
    DescriptionLabel.Position = UDim2.new(0, 0, 0.5, 0)
    DescriptionLabel.Text = description
    DescriptionLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
    DescriptionLabel.BackgroundTransparency = 1
    DescriptionLabel.Font = Enum.Font.SourceSans
    DescriptionLabel.TextSize = 16
    DescriptionLabel.Parent = Frame

    -- Auto remove after a certain time (e.g., 3 seconds)
    wait(3)
    NotificationGui:Destroy()
end

-- Example usage
sendNotification("Running XESP", "Please wait")




-- BORDAR SIR!----------------------____-_-------------!!!!!

-- Function to create the notification text
local function createNotificationText(message)
    local NotificationGui = Instance.new("ScreenGui")
    NotificationGui.Name = "NotificationGui"
    NotificationGui.Parent = game.Players.LocalPlayer.PlayerGui

    local TextLabel = Instance.new("TextLabel")
    TextLabel.Name = "NotificationText"
    TextLabel.Size = UDim2.new(0.8, 0, 0.1, 0)
    TextLabel.Position = UDim2.new(0.1, 0, 0.45, 0)
    TextLabel.Text = message
    TextLabel.TextColor3 = Color3.fromRGB(255, 0, 0) -- Red color
    TextLabel.BackgroundTransparency = 1
    TextLabel.Font = Enum.Font.SourceSansBold
    TextLabel.TextSize = 18
    TextLabel.TextWrapped = true  -- Ensure text is wrapped
    TextLabel.TextXAlignment = Enum.TextXAlignment.Center  -- Center align text horizontally
    TextLabel.Parent = NotificationGui

    -- Auto remove
    wait(8)
    NotificationGui:Destroy()
end

-- Create the notification text
createNotificationText("Team indicator won't update, you must re-toggle the ESP to update the team indicator")

-- OI OI OI OI OI BORDER


-- Function to calculate distance between two points
local function distance(p1, p2)
    return (p2 - p1).magnitude
end

-- Boolean variable to control ESP visibility
local IsEspEnabled = false
-- Variables (not really important)
local UpdateTime = 0.1

-- Function to toggle ESP visibility
local function ToggleEspVisibility()
    IsEspEnabled = not IsEspEnabled
end

-- Create a GUI button for toggling ESP
local function createEspButton()
    local Buttons1 = Instance.new("ScreenGui")
    Buttons1.Parent = game.Players.LocalPlayer.PlayerGui
    
    local EspToggleFrame = Instance.new("Frame")
    EspToggleFrame.Size = UDim2.new(0, 60, 0, 60)
    EspToggleFrame.Position = UDim2.new(1, -100, 0.5, -15)
    EspToggleFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    EspToggleFrame.BorderSizePixel = 4
    EspToggleFrame.Parent = Buttons1
    
    local buttonEsp = Instance.new("TextButton")
    buttonEsp.Name = "ButtonEsp"
    buttonEsp.Size = UDim2.new(0.8, 0, 0.8, 0)
    buttonEsp.Position = UDim2.new(0.1, 0, 0.1, 0)
    buttonEsp.Text = "Toggle ESP"
    buttonEsp.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
    buttonEsp.BorderSizePixel = 0
    buttonEsp.Parent = EspToggleFrame

    -- Connect the button click event to toggle ESP visibility
    buttonEsp.MouseButton1Click:Connect(ToggleEspVisibility)
end

-- Function to handle player respawn
local function handleRespawn()
    -- Recreate ESP button when player respawns
    createEspButton()
end

-- Listen for new players
game.Players.PlayerAdded:Connect(function(player)
    player.CharacterAdded:Connect(function(character)
        handleRespawn() -- Handle respawn
    end)
end)

-- Create ESP button initially
createEspButton()

-- Handle initial respawn
game.Players.LocalPlayer.CharacterAdded:Connect(handleRespawn)

-- Main loop to update ESP
while true do
    wait(UpdateTime) -- Adjust the update frequency as needed

    -- Check if ESP is enabled
    if IsEspEnabled then
        -- Get local player's position
        local localPlayerPos = game.Players.LocalPlayer.Character.HumanoidRootPart.Position

        -- Loop through all players
        for _, player in pairs(game:GetService("Players"):GetPlayers()) do
            -- Check if player is not the local player and is alive
            if player ~= game.Players.LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                local playerChar = player.Character
                local playerPos = playerChar.HumanoidRootPart.Position
                
                -- Calculate distance
                local dist = distance(localPlayerPos, playerPos)
                
                -- Check if player's name tag doesn't exist
                if not playerChar:FindFirstChild("PlayerESPNameTag") then
                    -- Create a BillboardGui for the name tag
                    local billboard = Instance.new("BillboardGui")
                    billboard.Name = "PlayerESPNameTag"
                    billboard.Adornee = playerChar:FindFirstChild("Head")
                    billboard.Size = UDim2.new(0, 100, 0, 50)
                    billboard.StudsOffset = Vector3.new(0,3,0)
                    billboard.AlwaysOnTop = true
                    billboard.Enabled = true

                    -- Create a TextLabel for the player's name and distance
                    local nameLabel = Instance.new("TextLabel")
                    nameLabel.Size = UDim2.new(1, 0, 1, 0)
                    nameLabel.Text = player.Name .. "\nDistance: " .. tostring(math.floor(dist))
                    nameLabel.TextColor3 = Color3.new(1, 1, 1)
                    nameLabel.BackgroundTransparency = 1
                    nameLabel.Font = Enum.Font.SourceSansBold
                    nameLabel.TextSize = 14
                    nameLabel.TextWrapped = true
                    nameLabel.Parent = billboard

                    -- Attach the BillboardGui to the player's head
                    billboard.Parent = playerChar
                    
                    -- Determine color based on player's team
                    local teamColor = player.TeamColor.Color
                    if player.Team then
                        teamColor = player.Team.TeamColor.Color
                    end
                    
                    -- Create a BillboardGui for highlighting torso
                    local highlightBillboard = Instance.new("BillboardGui")
                    highlightBillboard.Name = "PlayerESPHighlight"
                    highlightBillboard.Adornee = playerChar:FindFirstChild("HumanoidRootPart")
                    highlightBillboard.Size = UDim2.new(4, 0, 4, 0)
                    highlightBillboard.StudsOffset = Vector3.new(0,0.5,0)
                    highlightBillboard.AlwaysOnTop = true
                    highlightBillboard.Enabled = true

                    -- Create a Frame for highlighting the torso
                    local highlightFrame = Instance.new("Frame")
                    highlightFrame.Size = UDim2.new(1, 0, 1, 0)
                    highlightFrame.BackgroundColor3 = teamColor  -- Use team color
                    highlightFrame.BackgroundTransparency = 0.5  -- Adjust the transparency as needed
                    highlightFrame.Parent = highlightBillboard

                    -- Attach the BillboardGui to the player's torso
                    highlightBillboard.Parent = playerChar
                else
                    -- Update the existing name tag with updated distance
                    local nameTag = playerChar.PlayerESPNameTag
                    nameTag.TextLabel.Text = player.Name .. "\nDistance: " .. tostring(math.floor(dist))
                end
            end
        end
    else
        -- Disable ESP if it's not enabled
        for _, player in pairs(game:GetService("Players"):GetPlayers()) do
            if player.Character then
                local playerChar = player.Character
                if playerChar:FindFirstChild("PlayerESPNameTag") then
                    playerChar.PlayerESPNameTag:Destroy()
                end
                if playerChar:FindFirstChild("PlayerESPHighlight") then
                    playerChar.PlayerESPHighlight:Destroy()
                end
            end
        end
    end
end

-- BORDED SIR GOO AAWAY
