local args = {
    [1] = "Sword Smash",
    [2] = true,
    [3] = true,
    [4] = 10000,
    [5] = 0
}

local cooldown = 2 -- Cooldown time in seconds
local isEventEnabled = false -- Flag untuk melacak apakah event diaktifkan, awalnya diatur sebagai false
local isAutoMode = true -- Flag untuk menandai mode (otomatis/manual), awalnya diatur sebagai otomatis

-- Function untuk toggle event
local function toggleEvent()
    isEventEnabled = not isEventEnabled
end

-- Function untuk toggle mode (otomatis/manual)
local function toggleMode()
    isAutoMode = not isAutoMode
end

-- Create UI frame and buttons
local player = game.Players.LocalPlayer
local gui = Instance.new("ScreenGui")
gui.Parent = player.PlayerGui

local frame = Instance.new("Frame")
frame.Position = UDim2.new(0.5, -100, 0.5, -75)
frame.Size = UDim2.new(0, 200, 0, 150)
frame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
frame.BorderSizePixel = 0
frame.Parent = gui

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 20)
title.Position = UDim2.new(0, 0, 0, 0)
title.Text = "Cheat Menu"
title.TextColor3 = Color3.new(1, 1, 1)
title.BackgroundTransparency = 1
title.Parent = frame

local switchModeButton = Instance.new("TextButton")
switchModeButton.Position = UDim2.new(0.5, -75, 0, 40)
switchModeButton.Size = UDim2.new(0, 150, 0, 30)
switchModeButton.Text = "Automatic Mode"
switchModeButton.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
switchModeButton.BorderSizePixel = 0
switchModeButton.TextColor3 = Color3.new(1, 1, 1)
switchModeButton.Parent = frame

local toggleEventButton = Instance.new("TextButton")
toggleEventButton.Position = UDim2.new(0.5, -75, 0, 80)
toggleEventButton.Size = UDim2.new(0, 150, 0, 30)
toggleEventButton.Text = "Turn On"
toggleEventButton.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
toggleEventButton.BorderSizePixel = 0
toggleEventButton.TextColor3 = Color3.new(1, 1, 1)
toggleEventButton.Parent = frame

-- Function untuk menangani klik tombol toggle mode
switchModeButton.MouseButton1Click:Connect(function()
    toggleMode() -- Toggle mode
    if isAutoMode then
        switchModeButton.Text = "Automatic Mode"
    else
        switchModeButton.Text = "Manual Mode"
    end
end)

-- Function untuk menangani klik tombol toggle event
toggleEventButton.MouseButton1Click:Connect(function()
    toggleEvent() -- Toggle event
    if isEventEnabled then
        toggleEventButton.Text = "Turn Off"
        toggleEventButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
    else
        toggleEventButton.Text = "Turn On"
        toggleEventButton.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
    end
end)

-- Loop utama (untuk mode otomatis)
while true do
    if isEventEnabled and isAutoMode then
        game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("Player"):WaitForChild("Skill"):FireServer(unpack(args))
    end
    wait(cooldown)
end
