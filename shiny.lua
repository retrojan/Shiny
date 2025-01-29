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






































local Players = game:GetService("Players")
local player = Players.LocalPlayer
local mouse = player:GetMouse()
local userInput = game:GetService("UserInputService")

local screenGui = Instance.new("ScreenGui")
screenGui.Parent = player:WaitForChild("PlayerGui")

-- Создаём кнопку для строительства
local buildButton = Instance.new("TextButton")
buildButton.Size = UDim2.new(0, 140, 0, 40)
buildButton.Position = UDim2.new(0.5, 120, 0, 20)
buildButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
buildButton.TextColor3 = Color3.fromRGB(255, 255, 255)
buildButton.Text = "Строить"
buildButton.Parent = screenGui

local buttonCorner = Instance.new("UICorner")
buttonCorner.CornerRadius = UDim.new(0, 10)
buttonCorner.Parent = buildButton

local building = false
local selectedPartType = "Block"  -- Тип по умолчанию: обычный блок
local isBuilding = false  -- Флаг для отслеживания зажатия клавиши
local lastBuildTime = 0  -- Время последнего создания блока
local buildCooldown = 0.1  -- Задержка между созданиями (в секундах), теперь чуть быстрее

-- Функция для создания обычного блока
local function createBlock(position)
    local block = Instance.new("Part")
    block.Size = Vector3.new(5, 5, 5)
    block.Position = position
    block.Material = Enum.Material.Wood
    block.Anchored = true
    block.Parent = workspace
end

-- Функция для создания неоново-килл-парта
local function createKillPart(position)
    local killPart = Instance.new("Part")
    killPart.Size = Vector3.new(5, 5, 5)
    killPart.Position = position
    killPart.Material = Enum.Material.Neon  -- Используем неоновый материал
    killPart.Color = Color3.fromRGB(255, 0, 0)  -- Неоновый цвет (бирюзовый)
    killPart.Anchored = true
    killPart.Parent = workspace
    
    -- Добавляем убийственный эффект
    killPart.Touched:Connect(function(otherPart)
        if otherPart.Parent:FindFirstChild("Humanoid") then
            otherPart.Parent:FindFirstChild("Humanoid"):TakeDamage(100)  -- Наносит урон
        end
    end)
end

-- Функция для изменения типа блока
local function changePartType()
    local partTypes = {"Block", "KillPart"}
    local index = table.find(partTypes, selectedPartType) or 1
    selectedPartType = partTypes[(index % #partTypes) + 1]
    buildButton.Text = "Тип: " .. selectedPartType
end

-- Включение режима строительства
buildButton.MouseButton1Click:Connect(function()
    building = not building
    buildButton.Text = building and "Режим строительства: ON" or "Строить"
end)

-- Обработка зажатия и отпускания клавиши "R"
userInput.InputBegan:Connect(function(input, gameProcessed)
    if not gameProcessed then
        if input.KeyCode == Enum.KeyCode.R and building then
            isBuilding = true  -- Начинаем строить, если зажата клавиша
        elseif input.KeyCode == Enum.KeyCode.M then
            changePartType()
        end
    end
end)

userInput.InputEnded:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.R then
        isBuilding = false  -- Останавливаем строительство, когда клавиша отпускается
    end
end)

-- Создание блока с задержкой
game:GetService("RunService").Heartbeat:Connect(function()
    if isBuilding and building then
        local currentTime = tick()
        
        -- Проверяем, прошло ли достаточно времени для создания следующего блока
        if currentTime - lastBuildTime >= buildCooldown then
            lastBuildTime = currentTime  -- Обновляем время последнего создания
            local position = mouse.Hit.p
            if selectedPartType == "Block" then
                createBlock(position)
            elseif selectedPartType == "KillPart" then
                createKillPart(position)
            end
        end
    end
end)

-- Функция для активации бесконечного прыжка
local infiniteJumpEnabled = false

local function toggleInfiniteJump()
    infiniteJumpEnabled = not infiniteJumpEnabled
    if infiniteJumpEnabled then
        -- Подключаем событие для постоянного прыжка
        humanoid.Jumping:Connect(function()
            if infiniteJumpEnabled then
                humanoid:ChangeState(Enum.HumanoidStateType.Physics)
                humanoid:Move(Vector3.new(0, humanoid.JumpPower, 0))  -- Подаем силу прыжка
            end
        end)
    end
end

-- Кнопка для включения/выключения бесконечного прыжка
local jumpButton = Instance.new("TextButton")
jumpButton.Size = UDim2.new(0, 140, 0, 40)
jumpButton.Position = UDim2.new(0.5, -70, 0, 140)
jumpButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
jumpButton.TextColor3 = Color3.fromRGB(255, 255, 255)
jumpButton.Text = "Бесконечный прыжок"
jumpButton.Parent = menuFrame

local jumpCorner = Instance.new("UICorner")
jumpCorner.CornerRadius = UDim.new(0, 10)
jumpCorner.Parent = jumpButton

jumpButton.MouseButton1Click:Connect(toggleInfiniteJump)
