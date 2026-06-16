-- Keyboard escape hub v1 (PERFECT ANIMATION & BUTTONS WORKING)
local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local Title = Instance.new("TextLabel")

-- Schließen und Minimieren Buttons
local CloseBtn = Instance.new("TextButton")
local MinimizeBtn = Instance.new("TextButton")
local OpenBtn = Instance.new("TextButton")

ScreenGui.Parent = game.CoreGui
MainFrame.Name = "KeyboardEscapeHub"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 23, 42)
MainFrame.Position = UDim2.new(0.3, 0, 0.2, 0)
MainFrame.Size = UDim2.new(0, 320, 0, 350)
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

-- Schließen Button (X) - ERZWUNGEN OBEN RECHTS
CloseBtn.Parent = MainFrame
CloseBtn.Size = UDim2.new(0, 40, 0, 40)
CloseBtn.Position = UDim2.new(0.85, 0, 0, 2)
CloseBtn.BackgroundColor3 = Color3.fromRGB(239, 68, 68)
CloseBtn.Text = "X"
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseBtn.Font = Enum.Font.SourceSansBold
CloseBtn.TextSize = 18
CloseBtn.ZIndex = 10

-- Minimieren Button (_) - ERZWUNGEN NEBEN X
MinimizeBtn.Parent = MainFrame
MinimizeBtn.Size = UDim2.new(0, 40, 0, 40)
MinimizeBtn.Position = UDim2.new(0.70, 0, 0, 2)
MinimizeBtn.BackgroundColor3 = Color3.fromRGB(100, 116, 139)
MinimizeBtn.Text = "_"
MinimizeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
MinimizeBtn.Font = Enum.Font.SourceSansBold
MinimizeBtn.TextSize = 18
MinimizeBtn.ZIndex = 10

-- Öffnen Button (Wird erst sichtbar, wenn minimiert)
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
local ApplySpeedBtn = Instance.new("TextButton")
local FlySpeedInput = Instance.new("TextBox")
local ToggleFlyBtn = Instance.new("TextButton")
local ToggleClickTpBtn = Instance.new("TextButton")
local ToggleInvisibleBtn = Instance.new("TextButton")
local ToggleAntiAfkBtn = Instance.new("TextButton")

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

styleButton(ToggleClickTpBtn, "Click Teleport: AUS", 160, Color3.fromRGB(168, 85, 247))
styleButton(ToggleInvisibleBtn, "Unsichtbar machen", 210, Color3.fromRGB(234, 179, 8))
styleButton(ToggleAntiAfkBtn, "Anti-AFK: Inaktiv", 260, Color3.fromRGB(22, 163, 74))

local player = game.Players.LocalPlayer
local mouse = player:GetMouse()

-- Klick-Funktionen für Schließen/Minimieren
CloseBtn.MouseButton1Click:Connect(function() ScreenGui:Destroy() end)
MinimizeBtn.MouseButton1Click:Connect(function() MainFrame.Visible = false OpenBtn.Visible = true end)
OpenBtn.MouseButton1Click:Connect(function() MainFrame.Visible = true OpenBtn.Visible = false end)

-- Tempo
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
    ToggleClickTpBtn.Text = clickTpEnabled and "Click Teleport: AN" or "Click Teleport: AUS"
end)

mouse.Button1Down:Connect(function()
    if clickTpEnabled then
        local char = player.Character
        if char and char:FindFirstChild("HumanoidRootPart") then
            char.HumanoidRootPart.CFrame = CFrame.new(mouse.Hit.p + Vector3.new(0, 3, 0))
        end
    end
end)

-- Unsichtbarkeit
local invisible = false
ToggleInvisibleBtn.MouseButton1Click:Connect(function()
    local char = player.Character
    if char then
        invisible = not invisible
        for _, part in pairs(char:GetDescendants()) do
            if part:IsA("BasePart") or part:IsA("Decal") then
                if part.Name ~= "HumanoidRootPart" then part.Transparency = invisible and 1 or 0 end
            end
        end
        ToggleInvisibleBtn.Text = invisible and "Unsichtbar: AN" or "Unsichtbar machen"
    end
end)

-- LAUF-ANIMATION ANTI-AFK (Laufband-Effekt ohne Bewegung)
local antiAfk = false
ToggleAntiAfkBtn.MouseButton1Click:Connect(function()
    antiAfk = not antiAfk
    ToggleAntiAfkBtn.Text = antiAfk and "Anti-AFK: AKTIV" or "Anti-AFK: Inaktiv"
end)

task.spawn(function()
    while true do
        task.wait(1)
        if antiAfk then
            local char = player.Character
            local hum = char and char:FindFirstChild("Humanoid")
            if hum and hum.Animator then
                -- Sucht nach der Standard-Laufanimation im Charakter und spielt sie im Stand ab
                local anims = char:FindFirstChild("Animate")
                local runAnim = anims and (anims:FindFirstChild("run") or anims:FindFirstChild("walk"))
                local id = runAnim and runAnim:FindFirstChildOfClass("Animation")
                if id then
                    local track = hum.Animator:LoadAnimation(id)
                    track:Play()
                    task.wait(0.5)
                    track:Stop()
                end
            end
        end
    end
end)

-- FLY MODUS REPARIERT
local flying = false
local flyGyro, flyVelocity
ToggleFlyBtn.MouseButton1Click:Connect(function()
    local char = player.Character
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    if not hrp then return end
    
    flying = not flying
    ToggleFlyBtn.Text = flying and "Fliegen: AN" or "Fliegen (Speed links eintragen)"
    
    if flying then
        flyGyro = Instance.new("BodyGyro", hrp)
        flyGyro.P = 9e4
        flyGyro.maxTorque = Vector3.new(9e9, 9e9, 9e9)
        flyGyro.cframe = hrp.CFrame
        
        flyVelocity = Instance.new("BodyVelocity", hrp)
        flyVelocity.velocity = Vector3.new(0, 0.1, 0)
        flyVelocity.maxForce = Vector3.new(9e9, 9e9, 9e9)
        
        task.spawn(function()
            while flying and task.wait() do
                if char and char:FindFirstChild("Humanoid") then
                    local speed = tonumber(FlySpeedInput.Text) or 50
                    flyVelocity.velocity = char.Humanoid.MoveDirection * speed
                    flyGyro.cframe = workspace.CurrentCamera.CFrame
                    if char.Humanoid.MoveDirection == Vector3.new(0,0,0) then
                        flyVelocity.velocity = Vector3.new(0, 0.1, 0)
                    end
                end
            end
        end)
    else
        if flyGyro then flyGyro:Destroy() end
        if flyVelocity then flyVelocity:Destroy() end
    end
end)
