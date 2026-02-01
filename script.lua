--[[ 
    PREMIUM WIDE & SHORT UI (DASHBOARD STYLE)
    Features: Mobile Joystick, Two-Column Layout, Accent Buttons
    Author: VNDXS
]]

local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Lighting = game:GetService("Lighting")
local Workspace = game:GetService("Workspace")
local LocalPlayer = Players.LocalPlayer
local Camera = Workspace.CurrentCamera

-- Mobile Controls
local PlayerScripts = LocalPlayer:WaitForChild("PlayerScripts")
local PlayerModule = require(PlayerScripts:WaitForChild("PlayerModule"))
local Controls = PlayerModule:GetControls()

-- // UI CONFIGURATION (WIDE & SHORT) \\ --
local CFG = {
    MainColor = Color3.fromRGB(15, 15, 15),
    SecondaryColor = Color3.fromRGB(25, 25, 25),
    TextColor = Color3.fromRGB(255, 255, 255),
    SizeFull = UDim2.new(0, 480, 0, 260),  -- WIDE AND SHORT
    SizeBar = UDim2.new(0, 480, 0, 45),
    SizeDisc = UDim2.new(0, 75, 0, 75),
    CornerRadius = UDim.new(0, 12),
    CamBaseSpeed = 2
}

-- // GUI CREATION \\ --
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "MonoDashboard"
ScreenGui.ResetOnSpawn = false
ScreenGui.DisplayOrder = 100
if game:GetService("CoreGui"):FindFirstChild("MonoDashboard") then
    game:GetService("CoreGui").MonoDashboard:Destroy()
end
ScreenGui.Parent = game:GetService("CoreGui")

local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = CFG.SizeFull
MainFrame.Position = UDim2.new(0.5, -240, 0.4, -130) -- Centered
MainFrame.BackgroundColor3 = CFG.MainColor
MainFrame.BorderSizePixel = 0
MainFrame.ClipsDescendants = true
MainFrame.Parent = ScreenGui

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = CFG.CornerRadius
MainCorner.Parent = MainFrame

-- // TOP BAR \\ --
local TopBar = Instance.new("Frame")
TopBar.Size = UDim2.new(1, 0, 0, 45)
TopBar.BackgroundTransparency = 1
TopBar.Parent = MainFrame

local Title = Instance.new("TextLabel")
Title.Text = "WORLD CONTROL"
Title.Font = Enum.Font.GothamBold
Title.TextSize = 14
Title.TextColor3 = CFG.TextColor
Title.Size = UDim2.new(1, -100, 1, 0)
Title.Position = UDim2.new(0, 20, 0, 0)
Title.BackgroundTransparency = 1
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = TopBar

-- Window Controls
local ButtonContainer = Instance.new("Frame")
ButtonContainer.Size = UDim2.new(0, 90, 1, 0)
ButtonContainer.Position = UDim2.new(1, -95, 0, 0)
ButtonContainer.BackgroundTransparency = 1
ButtonContainer.Parent = TopBar

local function createWinBtn(symbol, name, xPos)
    local btn = Instance.new("TextButton")
    btn.Name = name
    btn.Text = symbol
    btn.Font = Enum.Font.GothamMedium
    btn.TextSize = 14
    btn.TextColor3 = CFG.TextColor
    btn.BackgroundColor3 = CFG.SecondaryColor
    btn.Size = UDim2.new(0, 28, 0, 28)
    btn.AnchorPoint = Vector2.new(0, 0.5)
    btn.Position = UDim2.new(0, xPos, 0.5, 0)
    btn.AutoButtonColor = false
    local c = Instance.new("UICorner") c.CornerRadius = UDim.new(0, 6) c.Parent = btn
    btn.Parent = ButtonContainer
    return btn
end

local BtnDisc = createWinBtn("O", "Disc", 0)
local BtnMini = createWinBtn("-", "Mini", 32)
local BtnClose = createWinBtn("X", "Close", 64)

-- // CONTENT AREA (SPLIT LAYOUT) \\ --
local Content = Instance.new("Frame")
Content.Size = UDim2.new(1, -30, 1, -55)
Content.Position = UDim2.new(0, 15, 0, 50)
Content.BackgroundTransparency = 1
Content.Parent = MainFrame

-- LEFT PANEL (CAMERA)
local LeftPanel = Instance.new("Frame")
LeftPanel.Size = UDim2.new(0.48, 0, 1, 0)
LeftPanel.Position = UDim2.new(0, 0, 0, 0)
LeftPanel.BackgroundTransparency = 1
LeftPanel.Parent = Content

local LeftLayout = Instance.new("UIListLayout")
LeftLayout.Padding = UDim.new(0, 10)
LeftLayout.SortOrder = Enum.SortOrder.LayoutOrder
LeftLayout.Parent = LeftPanel

-- RIGHT PANEL (ENV)
local RightPanel = Instance.new("Frame")
RightPanel.Size = UDim2.new(0.48, 0, 1, 0)
RightPanel.Position = UDim2.new(0.52, 0, 0, 0)
RightPanel.BackgroundTransparency = 1
RightPanel.Parent = Content

local RightLayout = Instance.new("UIListLayout")
RightLayout.Padding = UDim.new(0, 10)
RightLayout.SortOrder = Enum.SortOrder.LayoutOrder
RightLayout.Parent = RightPanel

-- === LEFT: FREECAM CONTROLS ===
local H1 = Instance.new("TextLabel")
H1.Text = "CAMERA"
H1.Font = Enum.Font.GothamBold
H1.TextSize = 11
H1.TextColor3 = Color3.fromRGB(130, 130, 130)
H1.Size = UDim2.new(1, 0, 0, 20)
H1.BackgroundTransparency = 1
H1.TextXAlignment = Enum.TextXAlignment.Left
H1.LayoutOrder = 1
H1.Parent = LeftPanel

local ToggleBtn = Instance.new("TextButton")
ToggleBtn.Name = "ToggleFreecam"
ToggleBtn.Size = UDim2.new(1, 0, 0, 120) -- Big main button
ToggleBtn.BackgroundColor3 = CFG.SecondaryColor
ToggleBtn.Text = "ENABLE\nFREECAM"
ToggleBtn.Font = Enum.Font.GothamBold
ToggleBtn.TextSize = 16
ToggleBtn.TextColor3 = CFG.TextColor
ToggleBtn.LayoutOrder = 2
ToggleBtn.AutoButtonColor = false
ToggleBtn.Parent = LeftPanel
local TBCorner = Instance.new("UICorner") TBCorner.CornerRadius = UDim.new(0, 10) TBCorner.Parent = ToggleBtn

local SpeedBox = Instance.new("TextBox")
SpeedBox.Name = "SpeedInput"
SpeedBox.Size = UDim2.new(1, 0, 0, 40)
SpeedBox.BackgroundColor3 = CFG.SecondaryColor
SpeedBox.Text = "Speed: " .. CFG.CamBaseSpeed
SpeedBox.Font = Enum.Font.Gotham
SpeedBox.TextSize = 14
SpeedBox.TextColor3 = CFG.TextColor
SpeedBox.LayoutOrder = 3
SpeedBox.Parent = LeftPanel
local SBCorner = Instance.new("UICorner") SBCorner.CornerRadius = UDim.new(0, 10) SBCorner.Parent = SpeedBox

-- === RIGHT: ENV CONTROLS ===
local H2 = H1:Clone()
H2.Text = "ENVIRONMENT"
H2.Parent = RightPanel

local GridContainer = Instance.new("Frame")
GridContainer.Size = UDim2.new(1, 0, 0, 120)
GridContainer.BackgroundTransparency = 1
GridContainer.LayoutOrder = 2
GridContainer.Parent = RightPanel

local Grid = Instance.new("UIGridLayout")
Grid.CellSize = UDim2.new(0.48, 0, 0.46, 0)
Grid.CellPadding = UDim2.new(0.04, 0, 0.08, 0)
Grid.Parent = GridContainer

local function CreateBtn(name, color)
    local btn = Instance.new("TextButton")
    btn.Name = name
    btn.Text = ""
    btn.BackgroundColor3 = CFG.SecondaryColor
    btn.AutoButtonColor = false
    btn.Parent = GridContainer
    
    local c = Instance.new("UICorner") c.CornerRadius = UDim.new(0, 8) c.Parent = btn
    
    local line = Instance.new("Frame")
    line.Size = UDim2.new(0, 20, 0, 3)
    line.Position = UDim2.new(0.5, -10, 0, 6)
    line.BackgroundColor3 = color
    line.BorderSizePixel = 0
    line.Parent = btn
    local lc = Instance.new("UICorner") lc.CornerRadius = UDim.new(1,0) lc.Parent = line
    
    local lbl = Instance.new("TextLabel")
    lbl.Text = string.upper(name)
    lbl.Size = UDim2.new(1,0,1,0)
    lbl.BackgroundTransparency = 1
    lbl.TextColor3 = CFG.TextColor
    lbl.Font = Enum.Font.GothamBold
    lbl.TextSize = 10
    lbl.Parent = btn
    return btn
end

local BtnSum = CreateBtn("Summer", Color3.fromRGB(255, 200, 50))
local BtnAut = CreateBtn("Autumn", Color3.fromRGB(255, 100, 50))
local BtnWin = CreateBtn("Winter", Color3.fromRGB(100, 200, 255))
local BtnSpr = CreateBtn("Spring", Color3.fromRGB(100, 255, 100))

local TimeBtn = Instance.new("TextButton")
TimeBtn.Size = UDim2.new(1, 0, 0, 40)
TimeBtn.BackgroundColor3 = CFG.SecondaryColor
TimeBtn.Text = "CYCLE TIME"
TimeBtn.Font = Enum.Font.GothamBold
TimeBtn.TextSize = 12
TimeBtn.TextColor3 = CFG.TextColor
TimeBtn.LayoutOrder = 3
TimeBtn.AutoButtonColor = false
TimeBtn.Parent = RightPanel
local TC = Instance.new("UICorner") TC.CornerRadius = UDim.new(0, 10) TC.Parent = TimeBtn


-- // --- LOGIC --- \\ --
local FreecamEnabled = false
local CameraCFrame = CFrame.new()
local TouchSensitivity = 0.006
local Pitch, Yaw = 0, 0

local function UpdateFreecam()
    if not FreecamEnabled then return end
    local MoveVector = Controls:GetMoveVector()
    local RotationMatrix = CFrame.Angles(0, Yaw, 0) * CFrame.Angles(Pitch, 0, 0)
    
    if MoveVector.Magnitude > 0 then
        local camForward = RotationMatrix.LookVector
        local camRight = RotationMatrix.RightVector
        local newPos = (camForward * -MoveVector.Z) + (camRight * MoveVector.X)
        CameraCFrame = CameraCFrame + (newPos * CFG.CamBaseSpeed)
    end
    Camera.CFrame = CFrame.new(CameraCFrame.Position) * RotationMatrix
end

UserInputService.InputChanged:Connect(function(input)
    if not FreecamEnabled then return end
    if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseMovement then
        if input.UserInputState == Enum.UserInputState.Change then
            local delta = input.Delta
            Yaw = Yaw - delta.X * TouchSensitivity
            Pitch = Pitch - delta.Y * TouchSensitivity
            Pitch = math.clamp(Pitch, -math.rad(89), math.rad(89))
        end
    end
end)

local function ToggleFreecam()
    FreecamEnabled = not FreecamEnabled
    if FreecamEnabled then
        Camera.CameraType = Enum.CameraType.Scriptable
        CameraCFrame = Camera.CFrame
        local rx, ry, rz = Camera.CFrame:ToEulerAnglesYXZ()
        Pitch = rx; Yaw = ry
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
            LocalPlayer.Character.Humanoid.WalkSpeed = 0
            LocalPlayer.Character.Humanoid.JumpPower = 0
            LocalPlayer.Character.Humanoid.PlatformStand = true
        end
        RunService:BindToRenderStep("WideCam", Enum.RenderPriority.Camera.Value + 1, UpdateFreecam)
        ToggleBtn.BackgroundColor3 = CFG.TextColor; ToggleBtn.TextColor3 = CFG.MainColor; ToggleBtn.Text = "DISABLE\nFREECAM"
    else
        RunService:UnbindFromRenderStep("WideCam")
        Camera.CameraType = Enum.CameraType.Custom
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
            LocalPlayer.Character.Humanoid.WalkSpeed = 16
            LocalPlayer.Character.Humanoid.JumpPower = 50
            LocalPlayer.Character.Humanoid.PlatformStand = false
        end
        ToggleBtn.BackgroundColor3 = CFG.SecondaryColor; ToggleBtn.TextColor3 = CFG.TextColor; ToggleBtn.Text = "ENABLE\nFREECAM"
    end
end
ToggleBtn.MouseButton1Click:Connect(ToggleFreecam)

SpeedBox.FocusLost:Connect(function()
    local num = tonumber(string.match(SpeedBox.Text, "[%d%.]+"))
    if num then CFG.CamBaseSpeed = num; SpeedBox.Text = "Speed: " .. num else SpeedBox.Text = "Speed: " .. CFG.CamBaseSpeed end
end)

-- Env
local CC = Lighting:FindFirstChild("MonoCC") or Instance.new("ColorCorrectionEffect")
CC.Name = "MonoCC"; CC.Parent = Lighting
local function SetEnv(props, ccProps)
    local info = TweenInfo.new(1)
    for p,v in pairs(props) do TweenService:Create(Lighting, info, {[p]=v}):Play() end
    for p,v in pairs(ccProps) do TweenService:Create(CC, info, {[p]=v}):Play() end
end
BtnSum.MouseButton1Click:Connect(function() SetEnv({ClockTime=14, FogColor=Color3.fromRGB(255,240,200)}, {TintColor=Color3.fromRGB(255,240,220)}) end)
BtnAut.MouseButton1Click:Connect(function() SetEnv({ClockTime=17.5, FogColor=Color3.fromRGB(255,150,100)}, {TintColor=Color3.fromRGB(255,200,150)}) end)
BtnWin.MouseButton1Click:Connect(function() SetEnv({ClockTime=10, FogColor=Color3.fromRGB(200,220,255)}, {TintColor=Color3.fromRGB(200,220,255)}) end)
BtnSpr.MouseButton1Click:Connect(function() SetEnv({ClockTime=9, FogColor=Color3.fromRGB(200,255,200)}, {TintColor=Color3.fromRGB(255,240,255)}) end)
TimeBtn.MouseButton1Click:Connect(function()
    local t = (Lighting.ClockTime > 6 and Lighting.ClockTime < 18) and 0 or 12
    local rc = Color3.fromHSV(math.random(),0.6,1)
    SetEnv({ClockTime=t, FogColor=rc, OutdoorAmbient=rc}, {TintColor=Color3.new(1,1,1)})
end)

-- Drag
local dragging, dragInput, dragStart, startPos
local function update(input)
    local delta = input.Position - dragStart
    local targetPos = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    TweenService:Create(MainFrame, TweenInfo.new(0.05), {Position = targetPos}):Play()
end
MainFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true; dragStart = input.Position; startPos = MainFrame.Position
        input.Changed:Connect(function() if input.UserInputState == Enum.UserInputState.End then dragging = false end end)
    end
end)
MainFrame.InputChanged:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then dragInput = input end end)
UserInputService.InputChanged:Connect(function(input) if input == dragInput and dragging then update(input) end end)

-- Mode
local CurrentMode = "Full"
local function GetAvatar(userId) return "rbxthumb://type=AvatarHeadShot&id=" .. userId .. "&w=150&h=150" end
local function SetMode(mode)
    local TI = TweenInfo.new(0.4, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
    CurrentMode = mode
    if mode == "Full" then
        TweenService:Create(MainFrame, TI, {Size = CFG.SizeFull, BackgroundTransparency = 0}):Play()
        Content.Visible = true; Title.Visible = true; ButtonContainer.Visible = true; BtnDisc.Text = "O"; BtnMini.Text = "-"
    elseif mode == "Bar" then
        TweenService:Create(MainFrame, TI, {Size = CFG.SizeBar, BackgroundTransparency = 0}):Play()
        Content.Visible = false; Title.Visible = true; ButtonContainer.Visible = true; BtnMini.Text = "+"
    elseif mode == "Disc" then
        TweenService:Create(MainFrame, TI, {Size = CFG.SizeDisc, BackgroundTransparency = 0}):Play()
        TweenService:Create(MainCorner, TI, {CornerRadius = UDim.new(1, 0)}):Play()
        Content.Visible = false; ButtonContainer.Visible = false; Title.Visible = false
    end
end
BtnMini.MouseButton1Click:Connect(function() if CurrentMode == "Bar" then SetMode("Full") else SetMode("Bar") end end)
BtnDisc.MouseButton1Click:Connect(function() SetMode("Disc") 
    local RestoreBtn = Instance.new("TextButton"); RestoreBtn.Size = UDim2.new(1,0,1,0); RestoreBtn.BackgroundTransparency = 1; RestoreBtn.Text = ""; RestoreBtn.Parent = MainFrame
    local DiscImg = Instance.new("ImageLabel"); DiscImg.Size = UDim2.new(1,-10,1,-10); DiscImg.Position = UDim2.new(0,5,0,5); DiscImg.Image = GetAvatar(LocalPlayer.UserId); DiscImg.BackgroundTransparency=1; DiscImg.Parent=MainFrame; Instance.new("UICorner", DiscImg).CornerRadius=UDim.new(1,0)
    RestoreBtn.MouseButton1Click:Connect(function() SetMode("Full"); RestoreBtn:Destroy(); DiscImg:Destroy(); TweenService:Create(MainCorner, TweenInfo.new(0.4), {CornerRadius = CFG.CornerRadius}):Play() end)
end)
BtnClose.MouseButton1Click:Connect(function() if FreecamEnabled then ToggleFreecam() end ScreenGui:Destroy() end)

print("VNDXS Looding")
