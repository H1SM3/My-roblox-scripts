-- [[ ЗАГРУЗКА МОБИЛЬНОЙ БИБЛИОТЕКИ ORION ]] --
local OrionLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/shlexware/Orion/main/source", true))()

-- [[ СОЗДАНИЕ ОКНА (С КНОПКОЙ СВОРАЧИВАНИЯ ДЛЯ ТЕЛЕФОНА) ]] --
local Window = OrionLib:MakeWindow({
    Name = "Гусь Hub | Restaurant Tycoon 2", 
    HidePremium = false, 
    SaveConfig = false, 
    IntroText = "Привет, Бро!", -- Надпись при загрузке скрипта
    Icon = "rbxassetid://4483345998" -- Иконка для круглой кнопки на экране
})

-- [[ ПЕРЕМЕННЫЕ ДЛЯ ФУНКЦИЙ ]] --
_G.AutoCollect = false
_G.AutoCookServe = false

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- [[ СОЗДАНИЕ ВКЛАДКИ ]] --
local MainTab = Window:MakeTab({
    Name = "Автофарм",
    Icon = "rbxassetid://4483345998",
    Premium = false
})

-- [[ ДОБАВЛЕНИЕ ПЕРЕКЛЮЧАТЕЛЕЙ (TOGGLES) ]] --

MainTab:AddToggle({
    Name = "Авто-сбор денег",
    Default = false,
    Callback = function(Value)
        _G.AutoCollect = Value
    end    
})

MainTab:AddToggle({
    Name = "Авто-готовка и выдача",
    Default = false,
    Callback = function(Value)
        _G.AutoCookServe = Value
    end    
})

-- [[ ГЛАВНЫЙ ЦИКЛ ФАРМА ]] --
task.spawn(function()
    while true do
        pcall(function()
            for _, tycoon in pairs(workspace.Tycoons:GetChildren()) do
                if tycoon:FindFirstChild("Owner") and tycoon.Owner.Value == LocalPlayer then
                    
                    -- Сбор денег со столов
                    if _G.AutoCollect then
                        for _, obj in pairs(tycoon:GetDescendants()) do
                            if obj:IsA("ClickDetector") and obj.Name == "ClickRegion" then
                                fireclickdetector(obj)
                            end
                        end
                    end
                    
                    -- Сверхзвуковая кухня
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

-- [[ ИНИЦИАЛИЗАЦИЯ (Обязательно для Orion в конце скрипта) ]] --
OrionLib:Init()
