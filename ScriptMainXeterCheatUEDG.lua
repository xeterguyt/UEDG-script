-- Create UI frame and buttons
local gui = Instance.new("ScreenGui")
gui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

local frame = Instance.new("Frame")
frame.Position = UDim2.new(0.5, -100, 0.5, -75)
frame.Size = UDim2.new(0, 200, 0, 150)
frame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
frame.BorderSizePixel = 0
frame.Active = true  -- Set frame to be interactable
frame.Draggable = true  -- Allow frame to be draggable
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

-- Function untuk toggle mode (otomatis/manual)
local isAutoMode = true
local isEventEnabled = false

local attackButton -- Tambahkan inisialisasi attackButton di sini

local function toggleMode()
    isAutoMode = not isAutoMode
    switchModeButton.Text = isAutoMode and "Automatic Mode" or "Manual Mode"
    
    -- Tampilkan tombol attack saat mode diubah menjadi "Manual Mode"
    if attackButton then
        attackButton.Visible = not isAutoMode 
    end
    print("Mode telah diubah menjadi", isAutoMode and "Automatic" or "Manual")
end

-- Function untuk menjalankan perintah Smash Attack (Sword Smash)
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

-- Function untuk menjalankan perintah Smash Attack secara berulang dengan cooldown
local function repeatAttack()
    while isEventEnabled and isAutoMode do
        executeSmashAttack()
        wait(2) -- Cooldown 2 detik
    end
end

-- Create separate UI for manual mode
local manualFrame = Instance.new("Frame")
manualFrame.Position = UDim2.new(1, -50, 0.5, -50)
manualFrame.Size = UDim2.new(0, 30, 0, 30)  -- Ubah ukuran sesuai dengan ukuran tombol
manualFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
manualFrame.BorderSizePixel = 0
manualFrame.Parent = gui

-- Inisialisasi tombol Attack
attackButton = Instance.new("TextButton")
attackButton.Position = UDim2.new(0, 0, 0, 0)
attackButton.Size = UDim2.new(1, 0, 1, 0)  -- Ukuran frame sesuai dengan ukuran tombol
attackButton.Text = "A"  -- Ubah teks menjadi singkat, misalnya "A"
attackButton.TextScaled = true  -- Tekstur otomatis diubah ke dalam ukuran tombol
attackButton.BackgroundColor3 = Color3.fromRGB(0, 255, 0)  -- Ubah warna menjadi hijau
attackButton.BorderSizePixel = 0
attackButton.TextColor3 = Color3.new(1, 1, 1)
attackButton.Visible = false  -- Awalnya tombol attack tidak terlihat
attackButton.Parent = manualFrame  -- Masukkan tombol ke dalam manualFrame

-- Function untuk menangani klik tombol Attack pada mode manual
attackButton.MouseButton1Click:Connect(function()
    executeSmashAttack() -- Jalankan perintah Smash Attack ketika tombol Attack diklik
end)

-- Function untuk menangani klik tombol toggle mode
switchModeButton.MouseButton1Click:Connect(function()
    toggleMode() -- Toggle mode
    if isAutoMode and isEventEnabled then
        spawn(repeatAttack) -- Mulai menyerang secara berulang jika mode otomatis dan event dinyalakan
    end
end)
