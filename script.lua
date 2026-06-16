-- Keyboard escape hub v1 (FULLY FIXED)
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
MainFrame.Size = UDim2.new(0, 320, 0, 350)
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

styleButton(ToggleClickTpBtn, "Click Teleport: AUS", 160, Color3.fromRGB(168, 85, 247))
styleButton(ToggleInvisibleBtn, "Unsichtbar machen", 210, Color3.fromRGB(234, 179, 8))
styleButton(ToggleAntiAfkBtn, "Anti-AFK: Inaktiv", 260, Color3.fromRGB(22, 163, 74))

local player = game.Players.LocalPlayer
local mouse = player:GetMouse()

-- REPARIERTES TEMPO
ApplySpeedBtn.MouseButton1Click:Connect(function()
    local char = player.Character
    if char and char:FindFirstChild("Humanoid") then
        local targetSpeed = tonumber(SpeedInput.Text) or 16
        char.Humanoid.WalkSpeed = targetSpeed
        
        -- Verhindert, dass das Spiel die Geschwindigkeit sofort wieder zurücksetzt
        char.Humanoid:GetPropertyChangedSignal("WalkSpeed"):Connect(function()
            if char.Humanoid.WalkSpeed ~= targetSpeed then
                char.Humanoid.WalkSpeed = targetSpeed
            end
        end)
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
                if part.Name ~= "HumanoidRootPart" then
                    part.Transparency = invisible and 1 or 0
                end
            end
        end
        ToggleInvisibleBtn.Text = invisible and "Unsichtbar: AN" or "Unsichtbar machen"
    end
end)

-- REPARIERTES ANTI-AFK
local antiAfk = false
ToggleAntiAfkBtn.MouseButton1Click:Connect(function()
    antiAfk = not antiAfk
    ToggleAntiAfkBtn.Text = antiAfk and "Anti-AFK: AKTIV" or "Anti-AFK: Inaktiv"
end)

player.Idled:Connect(function()
    if antiAfk then
        local virtualUser = game:GetService("VirtualUser")
        virtualUser:CaptureController()
        virtualUser:ClickButton2(Vector2.new(0,0))
    end
end)

-- REPARIERTES FLIEGEN (Mit FlySpeed-Erkennung)
local flying = false
local flyBodyGyro, flyBodyVelocity
ToggleFlyBtn.MouseButton1Click:Connect(function()
    local char = player.Character
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    if not hrp then return end
    
    flying = not flying
    ToggleFlyBtn.Text = flying and "Fliegen: AN" or "Fliegen (Speed links eintragen)"
    
    if flying then
        flyBodyGyro = Instance.new("BodyGyro")
        flyBodyGyro.P = 9e4
        flyBodyGyro.maxTorque = Vector3.new(9e9, 9e9, 9e9)
        flyBodyGyro.cframe = hrp.CFrame
        flyBodyGyro.Parent = hrp
        
        flyBodyVelocity = Instance.new("BodyVelocity")
        flyBodyVelocity.velocity = Vector3.new(0, 0.1, 0)
        flyBodyVelocity.maxForce = Vector3.new(9e9, 9e9, 9e9)
        flyBodyVelocity.Parent = hrp
        
        local camera = workspace.CurrentCamera
        spawn(function()
            while flying and task.wait() do
                if char and char:FindFirstChild("Humanoid") then
                    local speed = tonumber(FlySpeedInput.Text) or 50
                    local moveDirection = char.Humanoid.MoveDirection
                    flyBodyVelocity.velocity = moveDirection * speed
                    flyBodyGyro.cframe = camera.CFrame
                    if moveDirection == Vector3.new(0,0,0) then
                        flyBodyVelocity.velocity = Vector3.new(0, 0.1, 0)
                    end
                end
            end
        end)
    else
        if flyBodyGyro then flyBodyGyro:Destroy() end
        if flyBodyVelocity then flyBodyVelocity:Destroy() end
    end
end)
