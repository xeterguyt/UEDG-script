local args = {
    [1] = "Sword Smash",
    [2] = true,
    [3] = true,
    [4] = 1000,
    [5] = 0
}

local cooldown = 2 -- Cooldown time in seconds
local isEventEnabled = false -- Flag untuk melacak apakah event diaktifkan, awalnya diatur sebagai false
local isAutoMode = true -- Flag untuk menandai mode (otomatis/manual), awalnya diatur sebagai otomatis

-- Fungsi untuk toggle event
local function toggleEvent()
    isEventEnabled = not isEventEnabled
    if isEventEnabled then
        button1.Text = "Turn Off Smash Attack"
        button1.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
    else
        button1.Text = "Turn On Smash Attack"
        button1.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
    end
end

-- Fungsi untuk menangani klik tombol Attack (manual mode)
local function handleManualAttack()
    if not isAutoMode then
        game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("Player"):WaitForChild("Skill"):FireServer(unpack(args))
    end
end

-- Fungsi untuk toggle mode (otomatis/manual)
local function toggleMode()
    isAutoMode = not isAutoMode
    if isAutoMode then
        button2.Text = "Mode: Otomatis"
        button2.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    else
        button2.Text = "Mode: Manual"
        button2.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    end
end

-- Buat UI tombol dengan tema gelap dan desain yang lebih profesional
local player = game.Players.LocalPlayer
local gui = Instance.new("ScreenGui")
gui.Parent = player.PlayerGui

local frame = Instance.new("Frame")
frame.Position = UDim2.new(0.5, -100, 0.5, -75)
frame.Size = UDim2.new(0, 200, 0, 150)
frame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
frame.BorderSizePixel = 0
frame.ClipsDescendants = true
frame.Parent = gui

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -20, 0, 20)
title.Position = UDim2.new(0, 0, 0, 0)
title.Text = "Xeter UEDG Cheat"
title.TextColor3 = Color3.new(1, 1, 1)
title.TextSize = 14
title.BackgroundTransparency = 1
title.Parent = frame

local divider = Instance.new("Frame")
divider.Size = UDim2.new(1, 0, 0, 1)
divider.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
divider.Position = UDim2.new(0, 0, 0, 20)
divider.Parent = frame

local button1 = Instance.new("TextButton")
button1.Position = UDim2.new(0.5, -75, 0, 30)
button1.Size = UDim2.new(0, 150, 0, 40)
button1.Text = "Turn On Smash Attack"
button1.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
button1.BorderSizePixel = 0
button1.TextColor3 = Color3.new(1, 1, 1)
button1.Font = Enum.Font.Ubuntu
button1.Parent = frame

local button2 = Instance.new("TextButton")
button2.Position = UDim2.new(0.5, -75, 0, 80)
button2.Size = UDim2.new(0, 150, 0, 40)
button2.Text = "Mode: Otomatis"
button2.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
button2.BorderSizePixel = 0
button2.TextColor3 = Color3.new(1, 1, 1)
button2.Font = Enum.Font.Ubuntu
button2.Parent = frame

-- Buat tombol minimize
local minimizeButton = Instance.new("TextButton")
minimizeButton.Position = UDim2.new(1, -20, 0, 0)
minimizeButton.Size = UDim2.new(0, 20, 0, 20)
minimizeButton.Text = "-"
minimizeButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
minimizeButton.BorderSizePixel = 0
minimizeButton.TextColor3 = Color3.new(1, 1, 1)
minimizeButton.Font = Enum.Font.Ubuntu
minimizeButton.Parent = title

-- Fungsi untuk minimize frame
local isMinimized = false
local originalSize

local function minimizeFrame()
    isMinimized = true
    originalSize = frame.Size
    frame.Size = UDim2.new(0, 200, 0, 20)
end

-- Fungsi untuk open frame
local function openFrame()
    isMinimized = false
    frame.Size = originalSize
end

-- Fungsi untuk toggle frame (minimize/open)
local function toggleFrame()
    if isMinimized then
        openFrame()
    else
        minimizeFrame()
    end
end

-- Fungsi untuk menangani klik tombol minimize
minimizeButton.MouseButton1Click:Connect(function()
    toggleFrame() -- Toggle frame
end)

-- Fungsi untuk menangani klik tombol 1
button1.MouseButton1Click:Connect(function()
    toggleEvent() -- Toggle event
end)

-- Fungsi untuk menangani klik tombol 2 (mode)
button2.MouseButton1Click:Connect(function()
    toggleMode() -- Toggle mode
end)

-- Fungsi untuk menangani klik tombol Attack (manual mode)
button1.MouseButton1Click:Connect(function()
    handleManualAttack() -- Handle manual attack
end)

-- Fungsi untuk drag frame
local dragging
local dragInput
local dragStart
local startPos

local function update(input)
    local delta = input.Position - dragStart
    frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
end

local function isInsideTitle(position)
    local titlePosition = title.AbsolutePosition
    local titleSize = title.AbsoluteSize
    return position.X >= titlePosition.X and position.X <= titlePosition.X + titleSize.X and
           position.Y >= titlePosition.Y and position.Y <= titlePosition.Y + titleSize.Y
end

frame.InputBegan:Connect(function(input)
    if (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) and isInsideTitle(input.Position) then
        dragging = true
        dragStart = input.Position
        startPos = frame.Position

        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

frame.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)

game:GetService("UserInputService").InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        update(input)
    end
end)

-- Loop utama (untuk mode otomatis)
while true do
    -- Periksa apakah event diaktifkan dan mode otomatis sebelum melakukan firing
    if isEventEnabled and isAutoMode then
        -- Fire server event
        game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("Player"):WaitForChild("Skill"):FireServer(unpack(args))
    end

    -- Tunggu cooldown
    wait(cooldown)
end
