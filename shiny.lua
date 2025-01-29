local Players = game:GetService("Players")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local userInputService = game:GetService("UserInputService")

-- Создание экрана
local screenGui = Instance.new("ScreenGui")
screenGui.Parent = playerGui

-- Создание главного фрейма меню
local menuFrame = Instance.new("Frame")
menuFrame.Size = UDim2.new(0, 240, 0, 320)
menuFrame.Position = UDim2.new(0.5, -120, 0.5, -160)
menuFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
menuFrame.BorderSizePixel = 0
menuFrame.Visible = false
menuFrame.Parent = screenGui

local uiCorner = Instance.new("UICorner")
uiCorner.CornerRadius = UDim.new(0, 10)
uiCorner.Parent = menuFrame

-- Создание кнопки открытия меню
local openButton = Instance.new("TextButton")
openButton.Size = UDim2.new(0, 140, 0, 40)
openButton.Position = UDim2.new(0.5, -70, 0, 20)
openButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
openButton.TextColor3 = Color3.fromRGB(255, 255, 255)
openButton.Text = "Открыть меню"
openButton.Parent = screenGui

local openCorner = Instance.new("UICorner")
openCorner.CornerRadius = UDim.new(0, 10)
openCorner.Parent = openButton

-- Функция переключения видимости меню
local function toggleMenu()
    menuFrame.Visible = not menuFrame.Visible
end
openButton.MouseButton1Click:Connect(toggleMenu)

-- Функция создания ползунка
local function createSlider(text, position, min, max, default, callback)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, 220, 0, 50)
    frame.Position = UDim2.new(0, 10, 0, position)
    frame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    frame.Parent = menuFrame

    local frameCorner = Instance.new("UICorner")
    frameCorner.CornerRadius = UDim.new(0, 8)
    frameCorner.Parent = frame

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, 0, 0.4, 0)
    label.Text = text .. ": " .. default
    label.TextColor3 = Color3.fromRGB(255, 255, 255)
    label.BackgroundTransparency = 1
    label.Parent = frame

    local slider = Instance.new("TextBox")
    slider.Size = UDim2.new(1, 0, 0.6, 0)
    slider.Position = UDim2.new(0, 0, 0.4, 0)
    slider.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
    slider.Text = tostring(default)
    slider.TextColor3 = Color3.fromRGB(255, 255, 255)
    slider.Parent = frame

    local sliderCorner = Instance.new("UICorner")
    sliderCorner.CornerRadius = UDim.new(0, 8)
    sliderCorner.Parent = slider

    slider.FocusLost:Connect(function()
        local value = tonumber(slider.Text)
        if value and value >= min and value <= max then
            label.Text = text .. ": " .. value
            callback(value)
        else
            slider.Text = tostring(default)
        end
    end)
end

-- Ползунок для изменения скорости
createSlider("Скорость", 0, 0, 999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999, humanoid.WalkSpeed, function(value)
    humanoid.WalkSpeed = value
end)

-- Ползунок для изменения высоты прыжка
createSlider("Прыжок", 70, 10, 200, humanoid.JumpPower, function(value)
    humanoid.JumpPower = value
end)

-- Кнопка закрытия меню (в виде крестика в самом правом верхнем углу)
local closeButton = Instance.new("TextButton")
closeButton.Size = UDim2.new(0, 30, 0, 30)
closeButton.Position = UDim2.new(1, -40, 0, 10)
closeButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
closeButton.Text = "X"
closeButton.Parent = menuFrame

local closeCorner = Instance.new("UICorner")
closeCorner.CornerRadius = UDim.new(0, 10)
closeCorner.Parent = closeButton

closeButton.MouseButton1Click:Connect(function()
    menuFrame.Visible = false
end)
