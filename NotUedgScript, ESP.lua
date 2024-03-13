-- Function to calculate distance between two points
local function distance(p1, p2)
    return (p2 - p1).magnitude
end

-- Boolean variable to control ESP visibility
local IsEspEnabled = false

-- Function to toggle ESP visibility
local function ToggleEspVisibility()
    IsEspEnabled = not IsEspEnabled
end

-- Create a GUI button for toggling ESP
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

-- Main loop to update ESP
while true do
    wait(0.5) -- Adjust the update frequency as needed

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
                    highlightFrame.BackgroundColor3 = Color3.new(0, 1, 0)  -- Adjust the color as needed
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
-- Helped by chat gpt, modified by xeterguyt, yes im lazy to script all of it cuz when there is an easy way why not?
