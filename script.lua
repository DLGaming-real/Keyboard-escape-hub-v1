-- Keyboard escape hub v1 (CLEAN DELTA NO-CRASH EDITION)
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
MainFrame.Position = UDim2.new(0.3, 0, 0.1, 0)
MainFrame.Size = UDim2.new(0, 320, 0, 430)
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

-- Schließen (X)
CloseBtn.Parent = MainFrame
CloseBtn.Size = UDim2.new(0, 35, 0, 35)
CloseBtn.Position = UDim2.new(0.85, 0, 0.02, 0)
CloseBtn.BackgroundColor3 = Color3.fromRGB(239, 68, 68)
CloseBtn.Text = "X"
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseBtn.Font = Enum.Font.SourceSansBold
CloseBtn.TextSize = 16
CloseBtn.ZIndex = 5

-- Minimieren (_)
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
local ToggleNoClipBtn = Instance.new("TextButton")
local ToggleClickTpBtn = Instance.new("TextButton")
local ToggleInvisibleBtn = Instance.new("TextButton")
local ToggleAntiAfkBtn = Instance.new("TextButton")

local function styleElement(el, yPos, color)
    el.Parent = MainFrame
    el.Position = UDim2.new(0.1, 0, 0, yPos)
    el.Size = UDim2.new(0.8, 0, 0, 35)
    el.BackgroundColor3 = color
    el.TextColor3 = Color3.fromRGB(255, 255, 255)
    el.Font = Enum.Font.SourceSansBold
    el.TextSize = 14
end

-- 1. TEMPO
styleElement(SpeedInput, 80, Color3.fromRGB(51, 65, 85))
SpeedInput.Text = "16"

SpeedLabel.Parent = MainFrame
SpeedLabel.Size = UDim2.new(0.8, 0, 0, 20)
SpeedLabel.Position = UDim2.new(0.1, 0, 0, 58)
SpeedLabel.Text = "Tempo tippen (ändert sich sofort):"
SpeedLabel.TextColor3 = Color3.fromRGB(148, 163, 184)
SpeedLabel.BackgroundTransparency = 1
SpeedLabel.Font = Enum.Font.SourceSansBold
SpeedLabel.TextSize = 12
SpeedLabel.TextXAlignment = Enum.TextXAlignment.Left



-- NEU: Auto-Rebirth Button
ToggleRebirthBtn.Parent = MainFrame
ToggleRebirthBtn.Position = UDim2.new(0.1, 0, 0.58, 0)
ToggleRebirthBtn.Size = UDim2.new(0.8, 0, 0, 40)
FlySpeedInput.Parent = ToggleFlyBtn
FlySpeedInput.Size = UDim2.new(0.3, 0, 1, 0)
FlySpeedInput.Position = UDim2.new(-0.35, 0, 0, 0)
FlySpeedInput.BackgroundColor3 = Color3.fromRGB(51, 65, 85)
FlySpeedInput.TextColor3 = Color3.fromRGB(255, 255, 255)
FlySpeedInput.Text = "70"
FlySpeedInput.Font = Enum.Font.SourceSans
FlySpeedInput.TextSize = 14

-- 3. NO CLIP
styleElement(ToggleNoClipBtn, 190, Color3.fromRGB(219, 39, 119))
ToggleNoClipBtn.Text = "No Clip (Durch Wände): AUS"

-- 4. CLICK TELEPORT
styleElement(ToggleClickTpBtn, 240, Color3.fromRGB(168, 85, 247))
ToggleClickTpBtn.Text = "Click Teleport: AUS"

-- 5. UNSICHTBAR
styleElement(ToggleInvisibleBtn, 290, Color3.fromRGB(234, 179, 8))
ToggleInvisibleBtn.Text = "Unsichtbar machen"

-- 6. ANTI-AFK LAUFBAND
styleElement(ToggleAntiAfkBtn, 340, Color3.fromRGB(22, 163, 74))
ToggleAntiAfkBtn.Text = "Anti-AFK (Laufband): AUS"

local player = game.Players.LocalPlayer
local mouse = player:GetMouse()
local runService = game:GetService("RunService")

-- GUI Logik
CloseBtn.MouseButton1Click:Connect(function() ScreenGui:Destroy() end)
MinimizeBtn.MouseButton1Click:Connect(function() MainFrame.Visible = false OpenBtn.Visible = true end)
OpenBtn.MouseButton1Click:Connect(function() MainFrame.Visible = true OpenBtn.Visible = false end)

-- 🔥 DELTA-SICHERER LAUFBAND FREISCHALTER (Kein hookmetamethod!)
task.spawn(function()
    while task.wait(1) do
        -- 1. Schaltet die Barrieren im Spiel physikalisch aus
        for _, obj in pairs(workspace:GetDescendants()) do
            if obj:IsA("BasePart") and (obj.Name:find("Gate") or obj.Name:find("VIP") or obj.Name:find("Border") or obj.Name:find("Barrier") or obj.Name:find("Treadmill")) then
                obj.CanCollide = false
                obj.Transparency = 0.7
            end
        end
        
        -- 2. Injeziert die "Gekauft"-Werte direkt in deine lokalen Spieler-Einstellungen
        local pData = player:FindFirstChild("leaderstats") or player:FindFirstChild("PlayerGui")
        if pData then
            -- Sucht nach typischen Freischalt-Werten im Spielordner
            for _, v in pairs(pData:GetDescendants()) do
                if v:IsA("BoolValue") and (v.Name:find("VIP") or v.Name:find("Pass") or v.Name:find("Premium") or v.Name:find("Admin") or v.Name:find("Candy") or v.Name:find("Diamond") or v.Name:find("Gold")) then
                    v.Value = true
                end
            end
        end
    end
end)

-- VERBESSERTES TEMPO SYSTEM
runService.RenderStepped:Connect(function()
    local val = tonumber(SpeedInput.Text)
    if val and player.Character then
        local hum = player.Character:FindFirstChildOfClass("Humanoid")
        if hum and hum.WalkSpeed ~= val then 
            hum.WalkSpeed = val 
        end
    end
end)

player.CharacterAdded:Connect(function(char)
    local hum = char:WaitForChild("Humanoid", 5)
    local val = tonumber(SpeedInput.Text)
    if hum and val then hum.WalkSpeed = val end
end)

-- NO CLIP SYSTEM
local noclip = false
ToggleNoClipBtn.MouseButton1Click:Connect(function()
    noclip = not noclip
    ToggleNoClipBtn.Text = noclip and "No Clip (Durch Wände): AN" or "No Clip (Durch Wände): AUS"
end)

runService.Stepped:Connect(function()
    if noclip and player.Character then
        for _, part in pairs(player.Character:GetDescendants()) do
            if part:IsA("BasePart") then part.CanCollide = false end
        end
    end
end)

-- FLY SYSTEM
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

-- CLICK TELEPORT SYSTEM
local clickTpEnabled = false
ToggleClickTpBtn.MouseButton1Click:Connect(function()
    clickTpEnabled = not clickTpEnabled
    ToggleClickTpBtn.Text = clickTpEnabled and "Click Teleport: AN" or "Click Teleport: AUS"
end)

mouse.Button1Down:Connect(function()
    if clickTpEnabled and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        player.Character.HumanoidRootPart.CFrame = CFrame.new(mouse.Hit.p + Vector3.new(0, 3, 0))
    end
end)

-- UNSICHTBAR SYSTEM
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

-- ANTI AFK SYSTEM
local antiAfk = false
local currentTrack
ToggleAntiAfkBtn.MouseButton1Click:Connect(function()
    antiAfk = not antiAfk
    ToggleAntiAfkBtn.Text = antiAfk and "Anti-AFK (Laufband): AN" or "Anti-AFK (Laufband): AUS"
    
    local char = player.Character
    local hum = char and char:FindFirstChildOfClass("Humanoid")
    
    if antiAfk and hum and hum:FindFirstChildOfClass("Animator") then
        local anims = char:FindFirstChild("Animate")
        local runAnim = anims and (anims:FindFirstChild("run") or anims:FindFirstChild("walk"))
        local id = runAnim and runAnim:FindFirstChildOfClass("Animation")
        if id then
            currentTrack = hum:FindFirstChildOfClass("Animator"):LoadAnimation(id)
            currentTrack.Looped = true
            currentTrack:Play()
            currentTrack:AdjustSpeed(4)
        end
    else
        if currentTrack then currentTrack:Stop() currentTrack:Destroy() end
    end
end)

-- Anti Kick Schutz
player.Idled:Connect(function()
    local vu = game:GetService("VirtualUser")
    vu:CaptureController()
    vu:ClickButton2(Vector2.new(0,0))
end)
