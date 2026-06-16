
-- Keyboard escape hub v1 (UPDATED)
local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local Title = Instance.new("TextLabel")

local SpeedInput = Instance.new("TextBox")
local ApplySpeedBtn = Instance.new("TextButton")
local FlySpeedInput = Instance.new("TextBox")
local ToggleFlyBtn = Instance.new("TextButton")
local ToggleClickTpBtn = Instance.new("TextButton")
local ToggleInvisibleBtn = Instance.new("TextButton")
local ToggleAntiAfkBtn = Instance.new("TextButton")

ScreenGui.Parent = game.CoreGui
MainFrame.Name = "KeyboardEscapeHub"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 23, 42)
MainFrame.Position = UDim2.new(0.35, 0, 0.15, 0)
MainFrame.Size = UDim2.new(0, 320, 0, 350) -- Größe angepasst, da die Buttons weg sind
MainFrame.Active = true
MainFrame.Draggable = true

Title.Parent = MainFrame
Title.Size = UDim2.new(1, 0, 0, 45)
Title.BackgroundColor3 = Color3.fromRGB(30, 41, 59)
Title.Text = "⌨️ KEYBOARD ESCAPE HUB"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Font = Enum.Font.SourceSansBold
Title.TextSize = 18

local function styleButton(btn, text, yPos, color)
    btn.Parent = MainFrame
    btn.Position = UDim2.new(0.1, 0, 0, yPos)
    btn.Size = UDim2.new(0.8, 0, 0, 35)
    btn.Text = text
    btn.BackgroundColor3 = color
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Font = Enum.Font.SourceSansBold
    btn.TextSize = 14
end

styleButton(ApplySpeedBtn, "Tempo erzwingen (links eintragen)", 60, Color3.fromRGB(14, 165, 233))
SpeedInput.Parent = ApplySpeedBtn
SpeedInput.Size = UDim2.new(0.3, 0, 1, 0)
SpeedInput.Position = UDim2.new(-0.35, 0, 0, 0)
SpeedInput.BackgroundColor3 = Color3.fromRGB(51, 65, 85)
SpeedInput.TextColor3 = Color3.fromRGB(255, 255, 255)
SpeedInput.Text = "16"
SpeedInput.Font = Enum.Font.SourceSans
SpeedInput.TextSize = 14

styleButton(ToggleFlyBtn, "Fliegen (Speed links eintragen)", 110, Color3.fromRGB(14, 165, 233))
FlySpeedInput.Parent = ToggleFlyBtn
FlySpeedInput.Size = UDim2.new(0.3, 0, 1, 0)
FlySpeedInput.Position = UDim2.new(-0.35, 0, 0, 0)
FlySpeedInput.BackgroundColor3 = Color3.fromRGB(51, 65, 85)
FlySpeedInput.TextColor3 = Color3.fromRGB(255, 255, 255)
FlySpeedInput.Text = "50"
FlySpeedInput.Font = Enum.Font.SourceSans
FlySpeedInput.TextSize = 14

styleButton(ToggleClickTpBtn, "Click Teleport (STRG + Klick)", 160, Color3.fromRGB(168, 85, 247))
styleButton(ToggleInvisibleBtn, "Unsichtbar machen (Verbessert)", 210, Color3.fromRGB(234, 179, 8))
styleButton(ToggleAntiAfkBtn, "Anti-AFK: Inaktiv", 260, Color3.fromRGB(22, 163, 74))

-- FUNKTIONEN (Rest bleibt wie besprochen)
local player = game.Players.LocalPlayer
local mouse = player:GetMouse()
local uis = game:GetService("UserInputService")

-- Speed
ApplySpeedBtn.MouseButton1Click:Connect(function()
    local char = player.Character
    if char and char:FindFirstChild("Humanoid") then
        char.Humanoid.WalkSpeed = tonumber(SpeedInput.Text) or 16
    end
end)

-- Click TP
local clickTpEnabled = false
ToggleClickTpBtn.MouseButton1Click:Connect(function()
    clickTpEnabled = not clickTpEnabled
    ToggleClickTpBtn.Text = clickTpEnabled and "Click Teleport: AN" or "Click Teleport (STRG + Klick)"
end)

uis.InputBegan:Connect(function(input, processed)
    if processed then return end
    if clickTpEnabled and input.UserInputType == Enum.UserInputType.MouseButton1 and uis:IsKeyDown(Enum.KeyCode.LeftControl) then
        local char = player.Character
        if char and char:FindFirstChild("HumanoidRootPart") then
            char.HumanoidRootPart.CFrame = CFrame.new(mouse.Hit.p + Vector3.new(0, 3, 0))
        end
    end
end)

-- VERBESSERTE UNSICHTBARKEIT (Macht dich jetzt auch für dich selbst unsichtbar)
local invisible = false
ToggleInvisibleBtn.MouseButton1Click:Connect(function()
    local char = player.Character
    if char then
        invisible = not invisible
        for _, part in pairs(char:GetDescendants()) do
            if part:IsA("BasePart") or part:IsA("Decal") then
                if part.Name ~= "HumanoidRootPart" then
                    part.Transparency = invisible and 1 or 0
                end
            end
        end
        ToggleInvisibleBtn.Text = invisible and "Unsichtbar: AN" or "Unsichtbar machen (Verbessert)"
    end
end)

-- Anti AFK
local antiAfk = false
ToggleAntiAfkBtn.MouseButton1Click:Connect(function()
    antiAfk = not antiAfk
    ToggleAntiAfkBtn.Text = antiAfk and "Anti-AFK: AKTIV" or "Anti-AFK: Inaktiv"
end)

player.Idled:Connect(function()
    if antiAfk then
        local virtualUser = game:GetService("VirtualUser")
        virtualUser:Button2Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
        wait(1)
        virtualUser:Button2Up(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
    end
end)

-- Fly Logik (Vereinfacht beibehalten)
local flying = false
ToggleFlyBtn.MouseButton1Click:Connect(function()
    flying = not flying
    ToggleFlyBtn.Text = flying and "Fliegen: AN" or "Fliegen (Speed links eintragen)"
    -- [Hier würde deine bestehende Fly-Logik greifen]
end)
