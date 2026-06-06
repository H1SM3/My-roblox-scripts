-- [[ НЕУБИВАЕМЫЙ МОБИЛЬНЫЙ СКРИПТ (БЕЗ ТЯЖЕЛОЙ ГРАФИКИ) ]] --
print("=== Мобильный фарм запущен, Гусь! ===")

local ScreenGui = Instance.new("ScreenGui")
local ToggleButton1 = Instance.new("TextButton")
local ToggleButton2 = Instance.new("TextButton")

-- Настройки контейнера кнопок
ScreenGui.Parent = game:GetService("CoreGui")
ScreenGui.ResetOnSpawn = false

-- Кнопка 1: Деньги
ToggleButton1.Parent = ScreenGui
ToggleButton1.Size = UDim2.new(0, 150, 0, 50)
ToggleButton1.Position = UDim2.new(0, 10, 0, 150) -- Слева на экране
ToggleButton1.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
ToggleButton1.Text = "Деньги: ВЫКЛ"
ToggleButton1.TextColor3 = Color3.fromRGB(255, 255, 255)

-- Кнопка 2: Кухня
ToggleButton2.Parent = ScreenGui
ToggleButton2.Size = UDim2.new(0, 150, 0, 50)
ToggleButton2.Position = UDim2.new(0, 10, 0, 210) -- Чуть ниже первой
ToggleButton2.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
ToggleButton2.Text = "Кухня: ВЫКЛ"
ToggleButton2.TextColor3 = Color3.fromRGB(255, 255, 255)

_G.AutoCollect = false
_G.AutoCookServe = false

-- Логика нажатия на кнопки пальцем
ToggleButton1.MouseButton1Click:Connect(function()
    _G.AutoCollect = not _G.AutoCollect
    if _G.AutoCollect then
        ToggleButton1.BackgroundColor3 = Color3.fromRGB(50, 255, 50)
        ToggleButton1.Text = "Деньги: ВКЛ"
    else
        ToggleButton1.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
        ToggleButton1.Text = "Деньги: ВЫКЛ"
    end
end)

ToggleButton2.MouseButton1Click:Connect(function()
    _G.AutoCookServe = not _G.AutoCookServe
    if _G.AutoCookServe then
        ToggleButton2.BackgroundColor3 = Color3.fromRGB(50, 255, 50)
        ToggleButton2.Text = "Кухня: ВКЛ"
    else
        ToggleButton2.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
        ToggleButton2.Text = "Кухня: ВЫКЛ"
    end
end)

-- Сам цикл автофарма (остается рабочим)
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

task.spawn(function()
    while true do
        pcall(function()
            for _, tycoon in pairs(workspace.Tycoons:GetChildren()) do
                if tycoon:FindFirstChild("Owner") and tycoon.Owner.Value == LocalPlayer then
                    if _G.AutoCollect then
                        for _, obj in pairs(tycoon:GetDescendants()) do
                            if obj:IsA("ClickDetector") and obj.Name == "ClickRegion" then fireclickdetector(obj) end
                        end
                    end
                    if _G.AutoCookServe then
                        for _, order in pairs(tycoon:GetDescendants()) do
                            if order.Name == "Order" then
                                game:GetService("ReplicatedStorage").Events.CookDish:FireServer(order)
                                game:GetService("ReplicatedStorage").Events.ServeDish:FireServer(order)
                            end
                        end
                    end
                end
            end
        end)
        task.wait(0.3)
    end
end)
