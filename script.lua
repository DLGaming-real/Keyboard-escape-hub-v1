-- 1+ Keyboard escape hub (ADVANCED UNLOCK EDITION)
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

-- DIE BEIDEN NEUEN FREISCHALT-BUTTONS
local GamepassBypassBtn = Instance.new("TextButton")
local DeleteBarriersBtn = Instance.new("TextButton")

ScreenGui.Parent = game.CoreGui
MainFrame.Name = "KeyboardEscapeHub"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 23, 42)
MainFrame.Position = UDim2.new(0.35, 0, 0.15, 0)
MainFrame.Size = UDim2.new(0, 320, 0, 460) -- Leicht vergrößert für die neuen Funktionen
MainFrame.Active = true
MainFrame.Draggable = true

Title.Parent = MainFrame
Title.Size = UDim2.new(1, 0, 0, 45)
Title.BackgroundColor3 = Color3.fromRGB(30, 41, 59)
Title.Text = "1+ KEYBOARD ESCAPE HUB"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Font = Enum.Font.SourceSansBold
Title.TextSize = 15

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

-- Alte Funktionen (unverändert perfekt)
styleButton(ApplySpeedBtn, "Tempo erzwingen (links eintragen)", 60, Color3.fromRGB(14, 165, 233))
SpeedInput.Parent = ApplySpeedBtn
SpeedInput.Size = UDim2.new(0.3, 0, 1, 0)
SpeedInput.Position = UDim2.new(-0.35, 0, 0, 0)
SpeedInput.BackgroundColor3 = Color3.fromRGB(51, 65, 85)
SpeedInput.Text = "300"
SpeedInput.TextColor3 = Color3.fromRGB(255, 255, 255)

styleButton(ToggleFlyBtn, "Fliegen: AUS (Tempo links)", 110, Color3.fromRGB(225, 29, 72))
FlySpeedInput.Parent = ToggleFlyBtn
FlySpeedInput.Size = UDim2.new(0.3, 0, 1, 0)
FlySpeedInput.Position = UDim2.new(-0.35, 0, 0, 0)
FlySpeedInput.BackgroundColor3 = Color3.fromRGB(51, 65, 85)
FlySpeedInput.Text = "2"
FlySpeedInput.TextColor3 = Color3.fromRGB(255, 255, 255)

styleButton(ToggleClickTpBtn, "Klick-Teleport: AUS", 160, Color3.fromRGB(168, 85, 247))
styleButton(ToggleInvisibleBtn, "UNSICHTBAR (Invisible): AUS", 210, Color3.fromRGB(245, 158, 11))

-- NEUE FREISCHALT-BUTTONS IM INTERFACE
styleButton(GamepassBypassBtn, "METHODE 1: Gamepass austricksen", 260, Color3.fromRGB(34, 197, 94))
styleButton(DeleteBarriersBtn, "METHODE 2: Barrieren komplett löschen", 310, Color3.fromRGB(16, 185, 129))

styleButton(ToggleAntiAfkBtn, "PRO ANIM-AFK (Dauer-Rennen): AUS", 370, Color3.fromRGB(225, 29, 72))

-- ==================== LOGIKEN ====================

-- SPEED & FLY & TP SYSTEM (Deine bewährten Funktionen)
local TargetSpeed = 16
ApplySpeedBtn.MouseButton1Click:Connect(function()
    local num = tonumber(SpeedInput.Text)
    if num then TargetSpeed = num end
end)
game:GetService("RunService").Heartbeat:Connect(function()
    pcall(function()
        local humanoid = game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
        if humanoid and humanoid.WalkSpeed ~= TargetSpeed then humanoid.WalkSpeed = TargetSpeed end
    end)
end)

local flying = false
local uis = game:GetService("UserInputService")
local flyConnection
ToggleFlyBtn.MouseButton1Click:Connect(function()
    local char = game.Players.LocalPlayer.Character
    if not char or not char:FindFirstChild("HumanoidRootPart") then return end
    local hrp = char.HumanoidRootPart
    local hum = char:FindFirstChildOfClass("Humanoid")
    flying = not flying
    if flying then
        ToggleFlyBtn.Text = "Fliegen: AN"
        ToggleFlyBtn.BackgroundColor3 = Color3.fromRGB(34, 197, 94)
        if hum then hum.PlatformStand = true end
        flyConnection = game:GetService("RunService").RenderStepped:Connect(function()
            if not flying then return end
            local currentFlySpeed = tonumber(FlySpeedInput.Text) or 2
            local camCFrame = workspace.CurrentCamera.CFrame
            local direction = Vector3.new(0,0,0)
            if uis:IsKeyDown(Enum.KeyCode.W) then direction = direction + camCFrame.LookVector end
            if uis:IsKeyDown(Enum.KeyCode.S) then direction = direction - camCFrame.LookVector end
            if uis:IsKeyDown(Enum.KeyCode.A) then direction = direction - camCFrame.RightVector end
            if uis:IsKeyDown(Enum.KeyCode.D) then direction = direction + camCFrame.RightVector end
            if direction.Magnitude > 0 then
                hrp.CFrame = CFrame.new(hrp.Position + direction.Unit * currentFlySpeed) * CFrame.Angles(camCFrame:ToEulerAnglesXYZ())
            end
            hrp.Velocity = Vector3.new(0,0,0)
        end)
    else
        ToggleFlyBtn.Text = "Fliegen: AUS"
        ToggleFlyBtn.BackgroundColor3 = Color3.fromRGB(225, 29, 72)
        if flyConnection then flyConnection:Disconnect() end
        if hum then hum.PlatformStand = false end
    end
end)

local clickTpActive = false
local mouse = game.Players.LocalPlayer:GetMouse()
ToggleClickTpBtn.MouseButton1Click:Connect(function()
    clickTpActive = not clickTpActive
    if clickTpActive then ToggleClickTpBtn.Text = "Klick-Teleport: AKTIV" ToggleClickTpBtn.BackgroundColor3 = Color3.fromRGB(34, 197, 94)
    else ToggleClickTpBtn.Text = "Klick-Teleport: AUS" ToggleClickTpBtn.BackgroundColor3 = Color3.fromRGB(168, 85, 247) end
end)
mouse.Button1Down:Connect(function()
    if clickTpActive then
        local char = game.Players.LocalPlayer.Character
        local hrp = char and char:FindFirstChild("HumanoidRootPart")
        if hrp and mouse.Target then hrp.CFrame = CFrame.new(mouse.Hit.X, mouse.Hit.Y + 3, mouse.Hit.Z) end
    end
end)

-- INVISIBLE SYSTEM
local invisibleActive = false
ToggleInvisibleBtn.MouseButton1Click:Connect(function()
    local player = game.Players.LocalPlayer
    local char = player.Character
    local root = char and char:FindFirstChild("HumanoidRootPart")
    local lowerTorso = char and (char:FindFirstChild("LowerTorso") or char:FindFirstChild("Torso"))
    if not root or not lowerTorso then return end
    invisibleActive = not invisibleActive
    if invisibleActive then
        ToggleInvisibleBtn.Text = "Invisible: AN (Server-Ghost)"
        ToggleInvisibleBtn.BackgroundColor3 = Color3.fromRGB(34, 197, 94)
        local rootJoint = lowerTorso:FindFirstChild("RootJoint") or root:FindFirstChild("RootJoint")
        if rootJoint then
            rootJoint:Destroy()
            for _, v in pairs(char:GetDescendants()) do
                if v:IsA("BasePart") and v.Name ~= "HumanoidRootPart" then v.CFrame = CFrame.new(0, -500, 0) end
            end
        end
    else
        ToggleInvisibleBtn.Text = "UNSICHTBAR (Invisible): AUS"
        ToggleInvisibleBtn.BackgroundColor3 = Color3.fromRGB(245, 158, 11)
        if player.Character then player.Character:BreakJoints() end
    end
end)

-- ==================== NEUE FREISCHALT-LOGIKEN ====================

-- METHODE 1: ECHTEN GAMEPASS-CHECK IM SPEICHER AUSTRICKSEN
GamepassBypassBtn.MouseButton1Click:Connect(function()
    GamepassBypassBtn.Text = "Bypasse Abfragen..."
    pcall(function()
        -- Hooking des MarketplaceService (Wie es große Hubs machen)
        local mps = game:GetService("MarketplaceService")
        local oldUserOwnsGamePassAsync
        
        oldUserOwnsGamePassAsync = hookfunction(mps.UserOwnsGamePassAsync, function(self, userId, gamepassId)
            -- Sagt dem Spiel bei JEDEM Pass, dass du ihn besitzt
            return true
        end)
    end)
    
    -- Zweite Absicherung über die lokalen Werte im Spiel-Gui
    pcall(function()
        for _, v in pairs(game.Players.LocalPlayer:GetDescendants()) do
            if v:IsA("BoolValue") and (v.Name:lower():find("pass") or v.Name:lower():find("own") or v.Name:lower():find("treadmill")) then
                v.Value = true
            end
        end
    end)
    task.wait(1)
    GamepassBypassBtn.Text = "Methode 1 Aktiv!"
end)

-- METHODE 2: ABSPERRUNGEN EINFACH PHYSISCH AUS DER MAP LÖSCHEN
DeleteBarriersBtn.MouseButton1Click:Connect(function()
    DeleteBarriersBtn.Text = "Suche & Lösche Wände..."
    local counter = 0
    pcall(function()
        for _, object in pairs(workspace:GetDescendants()) do
            if object:IsA("BasePart") or object:IsA("Model") then
                local objName = object.Name:lower()
                -- Filtert nach typischen Namen für Kauf-Schranken und Laufbänder
                if objName:find("gate") or objName:find("barrier") or objName:find("door") or objName:find("lock") or objName:find("treadmill") or objName:find("vip") then
                    -- Wenn es eine Schranke vor dem Laufband ist, löschen wir sie komplett
                    if object:IsA("BasePart") and (object.Transparency > 0 or not object.CanCollide) then
                        object:Destroy()
                        counter = counter + 1
                    elseif object:findFirstChildOfClass("TouchTransmitter") then
                        -- Löscht Kicks/Teleporte, die auf der Schranke liegen
                        object:Destroy()
                        counter = counter + 1
                    end
                end
            end
        end
    end)
    task.wait(1)
    DeleteBarriersBtn.Text = counter .. " Barrieren gelöscht!"
    task.wait(1.5)
    DeleteBarriersBtn.Text = "METHODE 2: Barrieren komplett löschen"
end)

-- OPTISCHES AFK-RENNEN
local antiAfkActive = false
local animTrack = nil
ToggleAntiAfkBtn.MouseButton1Click:Connect(function()
    antiAfkActive = not antiAfkActive
    local char = game.Players.LocalPlayer.Character
    local hum = char and char:FindFirstChildOfClass("Humanoid")
    local animate = char and char:FindFirstChild("Animate")
    if antiAfkActive and hum and animate then
        ToggleAntiAfkBtn.Text = "Anim-AFK: AKTIV 🏃"
        ToggleAntiAfkBtn.BackgroundColor3 = Color3.fromRGB(34, 197, 94)
        pcall(function()
            local runAnim = animate.run.RunAnim
            animTrack = hum:LoadAnimation(runAnim)
            animTrack.Priority = Enum.AnimationPriority.Movement
            animTrack.Looped = true
            animTrack:Play()
        end)
        pcall(function()
            game.Players.LocalPlayer.Idled:Connect(function()
                game:GetService("VirtualUser"):CaptureController()
                game:GetService("VirtualUser"):ClickButton2(Vector2.new(50, 50))
            end)
        end)
    else
        ToggleAntiAfkBtn.Text = "PRO Anim-AFK (Dauer-Rennen): AUS"
        ToggleAntiAfkBtn.BackgroundColor3 = Color3.fromRGB(225, 29, 72)
        if animTrack then animTrack:Stop() animTrack:Destroy() end
    end
end)
