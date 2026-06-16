-- Keyboard escape hub v1 (PERFECT ADJUSTED VERSION)
local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local Title = Instance.new("TextLabel")

local CloseBtn = Instance.new("TextButton")
local MinimizeBtn = Instance.new("TextButton")
local OpenBtn = Instance.new("TextButton")

ScreenGui.Parent = game.CoreGui
MainFrame.Name = "KeyboardEscapeHub"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 23, 42)
MainFrame.Position = UDim2.new(0.3, 0, 0.2, 0)
MainFrame.Size = UDim2.new(0, 320, 0, 260)
MainFrame.Active = true
MainFrame.Draggable = true

-- Titel Leiste
Title.Parent = MainFrame
Title.Size = UDim2.new(1, 0, 0, 45)
Title.BackgroundColor3 = Color3.fromRGB(30, 41, 59)
Title.Text = "  ⌨️ KEYBOARD ESCAPE HUB"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Font = Enum.Font.SourceSansBold
Title.TextSize = 14
Title.TextXAlignment = Enum.TextXAlignment.Left

-- Schließen (X) - Oben Rechts
CloseBtn.Parent = MainFrame
CloseBtn.Size = UDim2.new(0, 35, 0, 35)
CloseBtn.Position = UDim2.new(0.85, 0, 0.02, 0)
CloseBtn.BackgroundColor3 = Color3.fromRGB(239, 68, 68)
CloseBtn.Text = "X"
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseBtn.Font = Enum.Font.SourceSansBold
CloseBtn.TextSize = 16
CloseBtn.ZIndex = 5

-- Minimieren (_) - Oben Rechts
MinimizeBtn.Parent = MainFrame
MinimizeBtn.Size = UDim2.new(0, 35, 0, 35)
MinimizeBtn.Position = UDim2.new(0.72, 0, 0.02, 0)
MinimizeBtn.BackgroundColor3 = Color3.fromRGB(100, 116, 139)
MinimizeBtn.Text = "_"
MinimizeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
MinimizeBtn.Font = Enum.Font.SourceSansBold
MinimizeBtn.TextSize = 16
MinimizeBtn.ZIndex = 5

-- Öffnen Button
OpenBtn.Parent = ScreenGui
OpenBtn.Size = UDim2.new(0, 100, 0, 35)
OpenBtn.Position = UDim2.new(0, 10, 0, 10)
OpenBtn.BackgroundColor3 = Color3.fromRGB(30, 41, 59)
OpenBtn.Text = "⌨️ Öffnen"
OpenBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
OpenBtn.Font = Enum.Font.SourceSansBold
OpenBtn.TextSize = 14
OpenBtn.Visible = false

local SpeedInput = Instance.new("TextBox")
local SpeedLabel = Instance.new("TextLabel")
local FlySpeedInput = Instance.new("TextBox")
local ToggleFlyBtn = Instance.new("TextButton")
local ToggleAntiAfkBtn = Instance.new("TextButton")

local function styleElement(el, yPos, color)
    el.Parent = MainFrame
    el.Position = UDim2.new(0.1, 0, 0, yPos)
    el.Size = UDim2.new(0.8, 0, 0, 40)
    el.BackgroundColor3 = color
    el.TextColor3 = Color3.fromRGB(255, 255, 255)
    el.Font = Enum.Font.SourceSansBold
    el.TextSize = 14
end

-- GESCHWINDIGKEIT DIREKT EINGEBEN (Kein Drücken nötig)
styleElement(SpeedInput, 60, Color3.fromRGB(51, 65, 85))
SpeedInput.Text = "16"
SpeedInput.PlaceholderText = "Tempo (1 - 1000000000)"

SpeedLabel.Parent = SpeedInput
SpeedLabel.Size = UDim2.new(1, 0, 0, 20)
SpeedLabel.Position = UDim2.new(0, 0, -0.5, 0)
SpeedLabel.Text = "Tempo tippen (ändert sich sofort):"
SpeedLabel.TextColor3 = Color3.fromRGB(148, 163, 184)
SpeedLabel.BackgroundTransparency = 1
SpeedLabel.Font = Enum.Font.SourceSansBold
SpeedLabel.TextSize = 12

-- FLY MIT WASD (Genauso wie oben verlangt)
styleElement(ToggleFlyBtn, 120, Color3.fromRGB(14, 165, 233))
ToggleFlyBtn.Text = "Fliegen (WASD)"

FlySpeedInput.Parent = ToggleFlyBtn
FlySpeedInput.Size = UDim2.new(0.3, 0, 1, 0)
FlySpeedInput.Position = UDim2.new(-0.35, 0, 0, 0)
FlySpeedInput.BackgroundColor3 = Color3.fromRGB(51, 65, 85)
FlySpeedInput.TextColor3 = Color3.fromRGB(255, 255, 255)
FlySpeedInput.Text = "70"
FlySpeedInput.Font = Enum.Font.SourceSans
FlySpeedInput.TextSize = 14

-- ANTI-AFK LAUFBAND ANIMATION
styleElement(ToggleAntiAfkBtn, 180, Color3.fromRGB(22, 163, 74))
ToggleAntiAfkBtn.Text = "Anti-AFK (Laufband): AUS"

local player = game.Players.LocalPlayer

-- GUI Steuerung
CloseBtn.MouseButton1Click:Connect(function() ScreenGui:Destroy() end)
MinimizeBtn.MouseButton1Click:Connect(function() MainFrame.Visible = false OpenBtn.Visible = true end)
OpenBtn.MouseButton1Click:Connect(function() MainFrame.Visible = true OpenBtn.Visible = false end)

-- TEMPO ÄNDERT SICH BEIM TIPPEN SOFORT
SpeedInput:GetPropertyChangedSignal("Text"):Connect(function()
    local val = tonumber(SpeedInput.Text)
    if val then
        local char = player.Character
        local hum = char and char:FindFirstChildOfClass("Humanoid")
        if hum then
            hum.WalkSpeed = val
        end
    end
end)

-- Immer aufpassen, falls der Charakter neu spawnt, dass die eingestellte Geschwindigkeit bleibt
player.CharacterAdded:Connect(function(char)
    local hum = char:WaitForChild("Humanoid", 5)
    local val = tonumber(SpeedInput.Text)
    if hum and val then hum.WalkSpeed = val end
end)

-- FLIEGEN (Stabil über WASD/Steuerkreuz)
local flying = false
local bv, bg
ToggleFlyBtn.MouseButton1Click:Connect(function()
    local char = player.Character
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    local hum = char and char:FindFirstChildOfClass("Humanoid")
    if not hrp or not hum then return end
    
    flying = not flying
    ToggleFlyBtn.Text = flying and "Fliegen: AN" or "Fliegen (WASD)"
    
    if flying then
        bv = Instance.new("BodyVelocity", hrp)
        bv.MaxForce = Vector3.new(9e9, 9e9, 9e9)
        bv.Velocity = Vector3.new(0, 0.1, 0)
        
        bg = Instance.new("BodyGyro", hrp)
        bg.MaxTorque = Vector3.new(9e9, 9e9, 9e9)
        bg.CFrame = hrp.CFrame
        
        task.spawn(function()
            while flying and task.wait() do
                local speed = tonumber(FlySpeedInput.Text) or 50
                bv.Velocity = hum.MoveDirection * speed
                bg.CFrame = hrp.CFrame
                if hum.MoveDirection == Vector3.new(0,0,0) then
                    bv.Velocity = Vector3.new(0, 0.1, 0)
                end
            end
        end)
    else
        if bv then bv:Destroy() end
        if bg then bg:Destroy() end
    end
end)

-- ANTI-AFK MIT LAUFBAND-EFFEKT (Bewegt Beine im Stand + Anti Kick)
local antiAfk = false
local currentTrack
ToggleAntiAfkBtn.MouseButton1Click:Connect(function()
    antiAfk = not antiAfk
    ToggleAntiAfkBtn.Text = antiAfk and "Anti-AFK (Laufband): AN" or "Anti-AFK (Laufband): AUS"
    
    local char = player.Character
    local hum = char and char:FindFirstChildOfClass("Humanoid")
    
    if antiAfk then
        if hum and hum:FindFirstChildOfClass("Animator") then
            local anims = char:FindFirstChild("Animate")
            local runAnim = anims and (anims:FindFirstChild("run") or anims:FindFirstChild("walk"))
            local id = runAnim and runAnim:FindFirstChildOfClass("Animation")
            if id then
                currentTrack = hum:FindFirstChildOfClass("Animator"):LoadAnimation(id)
                currentTrack.Looped = true
                currentTrack:Play()
                currentTrack:AdjustSpeed(4) -- Macht die Beine extraschnell fürs Laufband-Aussehen
            end
        end
    else
        if currentTrack then
            currentTrack:Stop()
            currentTrack:Destroy()
        end
    end
end)

-- Anti-Kick Signal zusätzlich im Hintergrund
player.Idled:Connect(function()
    local vu = game:GetService("VirtualUser")
    vu:CaptureController()
    vu:ClickButton2(Vector2.new(0,0))
end)
