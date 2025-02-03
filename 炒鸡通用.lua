local bai = {
    axedupe = false,
    soltnumber = "1",
    waterwalk = false,
    awaysday = false,
    awaysdnight = false,
    nofog = false,
    axeflying = false,
    playernamedied = "",
    tptree = "",
    moneyaoumt = 1,
    moneytoplayername = "",
    donationRecipient = tostring(game.Players.LocalPlayer),
    autodropae = false,
    farAxeEquip = nil,
    cuttreeselect = "Generic",
    autofarm = false,
    PlankToBlueprint = nil,
    plankModel = nil,
    blueprintModel = nil,
    saymege = "",
    autosay = false,
    saymount = 1,
    sayfast = false,
    autofarm1 = false,
    bringamount = 1,
    bringtree = false,
    dxmz = "",
    color = 0,
    0,
    0,
    zlwjia = "",
    mtwjia = nil,
    zix = 1,
    zlz = 3,
    axeFling = nil,
    itemtoopen = "",
    openItem = nil,
    car = nil,
    load = false,
    autobuyamount = 1,
    autopick = false,
    loaddupeaxewaittime = 3.1,
    walkspeed = 16,
    JumpPower = 50,
    pickupaxeamount = 1,
    whthmose = false,
    itemset = nil,
    LoneCaveAxeDetection = nil,
    cuttree = false,
    LoneCaveCharacterAddedDetection = nil,
    LoneCaveDeathDetection = nil,
    lovecavecutcframe = nil,
    lovecavepast = nil,
    zlmt = nil,
    shuzhe = false,
    modwood = false,
    tchonmt = nil,
    cskais = false,
    dledetree = false,
    delereeset = nil,
    treecutset = nil,
    autobuyset = nil,
    wood = 7,
    cswjia = nil,
    boxOpenConnection = nil,
    autobuystop = flase,
    dropdown = {},
    autocsdx = nil,
    kuangxiu = nil,
    xzemuban = false,
    daiwp = false,
    stopcar = false
}
--Setting
local LS = {
    playernamedied = "",
    dropdown = {},
    LoopTeleport = false,
    message = "",
    sayCount = 1,
    sayFast = false,
    autoSay = false,
}
--Main Setting
local Main = {
    tpwalkslow = 0,
    tpwalkmobile = 0,
    tpwalkquick = 0,
    tpwalkslowenable = false,
    tpwalkmobileenable = false,
    tpwalkquickenable = false,
    spinspeed = 0,
    HitboxStatue = false,
    HitboxSize = 0,
    HitboxTransparency = 1,
    HitboxBrickColor = "Really red"
}
--Aimbot Setting
local Aimbot = {
    fovsize = 20,
    AimbotEnable = false,
    fovcolor = Color3.fromRGB(255, 255, 255),
    fovthickness = 2,
    Visible = false,
    distance = 40,
    ViewportSize = 2,
    Transparency = 1,
    Position = "Head",
    smoothing = 2,
    smoothingEnabled = false,
    teamCheck = false,
    wallCheck = false,
    aliveCheck = false,
    prejudgingselfsighting = false,
    prejudgingselfsightingdistance = 0
}
--ESP Setting
local ESPSetting = {
    color = Color3.fromRGB(255, 0, 0),
}
local espBoxes = {}
local espNames = {}
local espHealths = {}
local espHighlights = {}
local espDistances = {}
local espTracers = {}
--Getting Services
local TextService = game:GetService("TextService")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local CoreGui = game:GetService("StarterGui")
local Workspace = game:GetService("Workspace")
local ReplicatedStorage  = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")
local ProximityPromptService = game:GetService("ProximityPromptService");
local VirtualUser = game:GetService("VirtualUser");
local Lighting = game:GetService("Lighting")
local LocalPlayer = Players.LocalPlayer
local HttpService = game:GetService("HttpService")
local MarketplaceService = game:GetService("MarketplaceService")
local LocalizationService = game:GetService("LocalizationService")
local RbxAnalyticsService = game:GetService("RbxAnalyticsService")
local GroupService = game:GetService("GroupService")
local BadgeService = game:GetService("BadgeService")
local UserInputService = game:GetService("UserInputService")
local Stats = game:GetService("Stats")
local Mouse = LocalPlayer:GetMouse()
--Json
local JSON_URL = "https://github.com/AURORA666Script/ui/raw/main/version.json"
local function fetchJSON(url)--json
    local success, result = pcall(function()
        return game:HttpGet(url)
    end)
    if not success or result == "" then
        print("无法获取JSON数据")
        return {}
    end
    return result
end
local function parseJSON(jsonString)
    local success, result = pcall(function()
        return game:GetService("HttpService"):JSONDecode(jsonString)
    end)
    if not success then
        print("解析JSON数据失败")
        return {}
    end
    return result
end
local jsonString = fetchJSON(JSON_URL)
local data = parseJSON(jsonString)
for i, v in ipairs(data) do
    print("Data " .. i .. ": " .. tostring(v))
end
if data[1] and data[1].version then
    print("Version: " .. data[1].version)
end
--Fly Setting
local speeds = 5
local nowe = false
local tpwalking = false
local heartbeat = RunService.Heartbeat
local function updatespeed(char, hum)
	if nowe == true then
		tpwalking = false
		heartbeat:Wait()
		task.wait(.1)
		heartbeat:Wait()

		for i = 1, speeds do
			spawn(function()
				tpwalking = true

				while tpwalking and heartbeat:Wait() and char and hum and hum.Parent do
					if hum.MoveDirection.Magnitude > 0 then
						char:TranslateBy(hum.MoveDirection)
					end
				end
			end)
		end
	end
end

LocalPlayer.CharacterAdded:Connect(function(char)
	local char = LocalPlayer.Character
	if char then
		task.wait(0.7)
		char.Humanoid.PlatformStand = false
		char.Animate.Disabled = false
	end
end)
--Create Aimbot
local FOVring

local function createFOV(fov, color, thickness, transparency)
    local RunService = game:GetService("RunService")
    local UserInputService = game:GetService("UserInputService")
    local Players = game:GetService("Players")
    local Cam = workspace.CurrentCamera
    if FOVring then
        FOVring:Remove()
    end
    FOVring = Drawing.new("Circle")
    FOVring.Visible = true
    FOVring.Thickness = thickness
    FOVring.Color = color
    FOVring.Filled = false
    FOVring.Radius = fov
    FOVring.Position = Cam.ViewportSize / 2
    FOVring.Transparency = transparency

    local function updateDrawings()
        local camViewportSize = Cam.ViewportSize
        FOVring.Position = camViewportSize / 2
    end

    RunService.RenderStepped:Connect(updateDrawings)
end

local function destroyFOV()
    if FOVring then
        RunService:UnbindFromRenderStep("FOVUpdate")
        FOVring:Remove()
        FOVring = nil
    end
end

local function updateFOV()
    if FOVring then
        FOVring.Thickness = Aimbot.fovthickness
        FOVring.Radius = Aimbot.fovsize
        FOVring.Color = Aimbot.fovcolor
        FOVring.Transparency = Aimbot.Transparency / 10
    end
end

local function lookAt(target)
    local lookVector = (target - Cam.CFrame.Position).unit
    if Aimbot.smoothingEnabled then
        local smoothFactor = Aimbot.smoothing / 5
        Cam.CFrame = CFrame.new(Cam.CFrame.Position, Cam.CFrame.Position + (lookVector * smoothFactor))
    else
        Cam.CFrame = CFrame.new(Cam.CFrame.Position, Cam.CFrame.Position + lookVector)
    end
end

local function isPlayerAlive(player)
    return player.Character and player.Character:FindFirstChild("Humanoid") and player.Character.Humanoid.Health > 0
end

local function isPlayerVisibleThroughWalls(player, position)
    if not Aimbot.wallCheck then
        return true
    end
    local localPlayerCharacter = Players.LocalPlayer.Character
    if not localPlayerCharacter then
        return false
    end
    local part = player.Character and player.Character:FindFirstChild(position)
    if not part then
        return false
    end
    local ray = Ray.new(Cam.CFrame.Position, part.Position - Cam.CFrame.Position)
    local hit, _ = workspace:FindPartOnRayWithIgnoreList(ray, {localPlayerCharacter})
    if hit and hit:IsDescendantOf(player.Character) then
        return true
    end
    local direction = (part.Position - Cam.CFrame.Position).unit
    local maxDistance = Aimbot.distance
    local nearRay = Ray.new(Cam.CFrame.Position + direction * 2, direction * maxDistance)
    local nearHit, _ = workspace:FindPartOnRayWithIgnoreList(nearRay, {localPlayerCharacter})
    return nearHit and nearHit:IsDescendantOf(player.Character)
end

local function getClosestPlayerInFOV(position)
    local nearest = nil
    local last = math.huge
    local playerMousePos = Cam.ViewportSize / 2
    local maxDistance = Aimbot.distance
    for _, player in ipairs(Players:GetPlayers()) do
        if (not Aimbot.aliveCheck or isPlayerAlive(player)) and player ~= Players.LocalPlayer then
            local part = player.Character and player.Character:FindFirstChild(Aimbot.Position)
            if part then
                local ePos, isVisible = Cam:WorldToViewportPoint(part.Position)
                if ePos and isVisible then
                    local distance = (Vector2.new(ePos.x, ePos.y) - playerMousePos).Magnitude
                    if distance < last and distance <= Aimbot.fovsize and distance <= maxDistance then
                        if not Aimbot.teamCheck or player.Team ~= Players.LocalPlayer.Team then
                            if not Aimbot.wallCheck or isPlayerVisibleThroughWalls(player, Aimbot.Position) then
                                last = distance
                                nearest = player
                            end
                        end
                    end
                end
            end
        end
    end
    return nearest
end

RunService.RenderStepped:Connect(function()
    if Aimbot.AimbotEnable then
        local closest = getClosestPlayerInFOV(Aimbot.Position)
        if closest and closest.Character:FindFirstChild(Aimbot.Position) then
            local targetPosition = closest.Character[Aimbot.Position].Position
            if Aimbot.teamCheck and closest.Team ~= Players.LocalPlayer.Team then
                if Aimbot.wallCheck and isPlayerVisibleThroughWalls(closest, Aimbot.Position) then
                    lookAt(targetPosition)
                end
            end
        end
    end
end)
--Create ESP
local function createESPBox(player)
    local espBox = Drawing.new("Square")
    espBox.Visible = false
    espBox.Color = ESPSetting.color
    espBox.Thickness = 1
    espBox.Filled = false
    espBoxes[player] = espBox
end

local function createESPName(player)
    local espName = Drawing.new("Text")
    espName.Visible = false
    espName.Color = ESPSetting.color
    espName.Size = 15
    espName.Center = true
    espName.Outline = true
    espName.Font = "Monospace"
    espNames[player] = espName
end

local function createESPHealth(player)
    local espHealth = Drawing.new("Square")
    espHealth.Visible = false
    espHealth.Color = ESPSetting.color
    espHealth.Thickness = 1
    espHealth.Filled = true
    espHealths[player] = espHealth
end

local function createESPHighlight(player)
    local espHighlight = Instance.new("Highlight")
    espHighlight.FillColor = ESPSetting.color
    espHighlight.OutlineColor = ESPSetting.color
    espHighlight.Parent = player.Character
    espHighlights[player] = espHighlight
end

local function createESPDistance(player)
    local espDistance = Drawing.new("Text")
    espDistance.Visible = false
    espDistance.Color = ESPSetting.color
    espDistance.Size = 15
    espDistance.Center = true
    espDistance.Outline = true
    espDistance.Font = "Monospace"
    espDistances[player] = espDistance
end

local function createESPTracer(player)
    local espTracer = Drawing.new("Line")
    espTracer.Visible = false
    espTracer.Color = ESPSetting.color
    espTracer.Thickness = 1
    espTracers[player] = espTracer
end

local function updateESP()
    local localPlayer = Players.LocalPlayer
    local localCharacter = localPlayer.Character
    if not localCharacter then return end
    local camera = workspace.CurrentCamera
    if not camera then return end

    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= localPlayer then
            local character = player.Character
            if character then
                local rootPart = character:FindFirstChild("HumanoidRootPart")
                if rootPart then
                    local screenPosition, onScreen = camera:WorldToViewportPoint(rootPart.Position)
                    if onScreen then
                        if not espBoxes[player] then
                            createESPBox(player)
                        end
                        if not espNames[player] then
                            createESPName(player)
                        end
                        if not espHealths[player] then
                            createESPHealth(player)
                        end
                        if not espHighlights[player] then
                            createESPHighlight(player)
                        end
                        if not espDistances[player] then
                            createESPDistance(player)
                        end
                        if not espTracers[player] then
                            createESPTracer(player)
                        end

                        local espBox = espBoxes[player]
                        local espName = espNames[player]
                        local espHealth = espHealths[player]
                        local espHighlight = espHighlights[player]
                        local espDistance = espDistances[player]
                        local espTracer = espTracers[player]

                        local size = character:GetExtentsSize() * 1.1
                        espBox.Position = Vector2.new(screenPosition.X - size.X / 2, screenPosition.Y - size.Y / 2)
                        espBox.Size = Vector2.new(size.X, size.Y)
                        espBox.Visible = true

                        espName.Text = player.Name
                        espName.Position = Vector2.new(screenPosition.X, screenPosition.Y - size.Y / 2 - 10)
                        espName.Visible = true

                        local health = character:FindFirstChild("Humanoid").Health
                        local maxHealth = character:FindFirstChild("Humanoid").MaxHealth
                        local healthRatio = health / maxHealth
                        espHealth.Size = Vector2.new(size.X * healthRatio, 5)
                        espHealth.Position = Vector2.new(screenPosition.X - size.X / 2, screenPosition.Y - size.Y / 2 - 5)
                        espHealth.Visible = true

                        espHighlight.Adornee = character

                        local distance = (localCharacter:FindFirstChild("HumanoidRootPart").Position - rootPart.Position).Magnitude
                        espDistance.Text = string.format("%.1f", distance)
                        espDistance.Position = Vector2.new(screenPosition.X, screenPosition.Y + size.Y / 2 + 10)
                        espDistance.Visible = true

                        espTracer.From = Vector2.new(camera.ViewportSize.X / 2, camera.ViewportSize.Y)
                        espTracer.To = Vector2.new(screenPosition.X, screenPosition.Y)
                        espTracer.Visible = true
                    else
                        espBoxes[player].Visible = false
                        espNames[player].Visible = false
                        espHealths[player].Visible = false
                        espHighlights[player].Adornee = nil
                        espDistances[player].Visible = false
                        espTracers[player].Visible = false
                    end
                end
            end
        end
    end
end

local function destroyESP()
    for player, espBox in pairs(espBoxes) do
        if espBox then
            espBox:Remove()
        end
    end
    espBoxes = {}

    for player, espName in pairs(espNames) do
        if espName then
            espName:Remove()
        end
    end
    espNames = {}

    for player, espHealth in pairs(espHealths) do
        if espHealth then
            espHealth:Remove()
        end
    end
    espHealths = {}

    for player, espHighlight in pairs(espHighlights) do
        if espHighlight then
            espHighlight:Destroy()
        end
    end
    espHighlights = {}

    for player, espDistance in pairs(espDistances) do
        if espDistance then
            espDistance:Remove()
        end
    end
    espDistances = {}

    for player, espTracer in pairs(espTracers) do
        if espTracer then
            espTracer:Remove()
        end
    end
    espTracers = {}
end
function shuaxinlb(zji)
    LS.dropdown = {}
    if zji == true then
        for _, player in pairs(game.Players:GetPlayers()) do
            table.insert(LS.dropdown, player.Name)
        end
    else
        local lp = game.Players.LocalPlayer
        for _, player in pairs(game.Players:GetPlayers()) do
            if player ~= lp then
                table.insert(LS.dropdown, player.Name)
            end
        end
    end
end
shuaxinlb(true)

local success, library = pcall(function(err)
    return loadstring(game:HttpGet("https://raw.githubusercontent.com/LENG8123/UI/refs/heads/main/ohio%20library.txt"))()
end)
if not success then
    writefile("错误", "Error : ".. err)
    return
end

local window = library:new("追梦nb"..identifyexecutor())
--
local Page2 = window:Tab("玩家数据",'16060333448')
local LocalPlayer = Page2:section("本地玩家",true)
local tpwalk = Page2:section("TPWalk",true)
local Camera = Page2:section("相机",true)
--
local Page3 = window:Tab("旋转-范围-飞行-头部大小",'16060333448')
local Spin = Page3:section("旋转",true)
local Hitbox = Page3:section("范围",true)
local Fly = Page3:section("飞行",true)
local Head = Page3:section("头部大小",true)
--
local Page4 = window:Tab("自瞄",'16060333448')
local Aimbot = Page4:section("Circle Aimbot",true)
--
local Page5 = window:Tab("ESP",'16060333448')
local ESP = Page5:section("Extra Sensory Perception",true)
--
local Page6 = window:Tab("选择玩家",'16060333448')
local Select = Page6:section("Dropdown",true)
--
local Page7 = window:Tab("通用功能",'16060333448')
local Universal = Page7:section("通用1",true)

local Page8 = window:Tab("工具",'16060333448')
local Webhook = Page8:section("Webhook",true)
local Tool = Page8:section("Tool",true)
local http = Page8:section("http Spy",true)
local hook = Page8:section("hook",true)
--
local Page8 = window:Tab("工具",'16060333448')
local Webhook = Page8:section("Webhook",true)
--
local Page9 = window:Tab("讲话",'16060333448')
local creditsE = Page9:section("略略略",true)
--
LocalPlayer:Slider("修改FPS", "Slider", 300, 300, 10000, false, function(Value)
    setfpscap(Value)
end)

LocalPlayer:Slider("速度", "Slider", 16, 16, 10000, false, function(Value)
    game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = Value
end)

LocalPlayer:Slider("跳跃", "Slider", 50, 50, 10000, false, function(Value)
    game.Players.LocalPlayer.Character.Humanoid.JumpPower = Value
end)

LocalPlayer:Slider("重力", "Slider", 198, 198, 10000, false, function(Value)
    game.Workspace.Gravity = Value
end)

LocalPlayer:Slider("高度", "Slider", 2, 2, 9999,false, function(Value)
    game.Players.LocalPlayer.Character.Humanoid.HipHeight = Value
end)

LocalPlayer:Slider("相机焦距上限", "Slider",  128, 128, 10000, false, function(Value)
    game:GetService("Players").LocalPlayer.CameraMaxZoomDistance = Value
end)

LocalPlayer:Slider("相机焦距", "Slider", 70, 70, 10000, false, function(v)
    game.Workspace.CurrentCamera.FieldOfView = v
end)

LocalPlayer:Slider("健康值上限", "Slider",  100, 100, 10000, false, function(Value)
    game.Players.LocalPlayer.Character.Humanoid.MaxHealth = Value
end)

LocalPlayer:Slider("玩家健康值", "Slider",  100, 100, 10000, false, function(Value)
    game.Players.LocalPlayer.Character.Humanoid.Health = Value
end)

tpwalk:Label("输入的数字越大效果越明显")

tpwalk:Textbox("丝滑加速(慢速)", "TPSpeed", "输入", function(value)
    Main.tpwalkslow = tonumber(value) or 0
end)

tpwalk:Toggle("开/关/关闭丝滑加速(慢速)", "Toggle", false, function(state)
    Main.tpwalkslowenable = state
    if Main.tpwalkslowenable then
        local tspeed = LS.tpwalkspeed
        local player = game:GetService("Players")
        local lplr = player.LocalPlayer
        local chr = lplr.Character
        local hum = chr and chr:FindFirstChildWhichIsA("Humanoid")
        if hum then
            local connection = hum.Running:Connect(function()
                if not LS.tpwalk then
                    connection:Disconnect()
                end
            end)
            while task.wait() and LS.tpwalk and chr and hum and hum.Parent do
                if hum.MoveDirection.Magnitude > 0 then
                    local moveDirection = hum.MoveDirection.Unit * tspeed
                    chr:TranslateBy(moveDirection)
                end
            end
            connection:Disconnect()
        end
    end
end)

tpwalk:Textbox("丝滑速度(中速)", "TPSpeed", "输入", function(value)
    Main.tpwalkmobile = tonumber(value) or 0
end)

tpwalk:Toggle("开/关丝滑加速(中速)", "TPWalk", false, function(state)
    Main.tpwalkmobileenable = state
    local hb = game:GetService("RunService").Heartbeat
    local player = game:GetService("Players")
    local lplr = player.LocalPlayer
    local chr = lplr.Character
    local hum = chr and chr:FindFirstChildWhichIsA("Humanoid")
    while Main.tpwalkmobileenable and hb:Wait() and chr and hum and hum.Parent do
      if hum.MoveDirection.Magnitude > 0 then
        if Main.tpwalkmobile and isNumber(Main.tpwalkmobile) then
          chr:TranslateBy(hum.MoveDirection * tonumber(Main.tpwalkmobile))
        else
          chr:TranslateBy(hum.MoveDirection)
        end
      end
    end
end)

tpwalk:Textbox("漂移加速", "TPSpeed", "输入数字", function(Value)
    if tonumber(Value) then
        speed = tonumber(Value)
        tpwalkingspeed = true
        local player = game:GetService("Players").LocalPlayer
        local character = player.Character or player.CharacterAdded:Wait()
        local humanoid = character and character:FindFirstChildWhichIsA("Humanoid")
        
        if humanoid then
            RunService:UnbindFromRenderStep("TPWalk")

            RunService:BindToRenderStep("TPWalk", Enum.RenderPriority.Character.Value, function(delta)
                if tpwalkingspeed and character and humanoid and humanoid.Parent then
                    if humanoid.MoveDirection.Magnitude > 0 then
                        character:TranslateBy(humanoid.MoveDirection * speed * delta * 10)
                    end
                end
            end)
        end
    else
        print("输入无效。请输入数字")
    end
end)

tpwalk:Button("点击即可漂移加速关闭",function()
    tpwalkingspeed = false
    RunService:UnbindFromRenderStep("TPWalk")
end)

Camera:Dropdown("选择相机方式", "CameraType", {"自定义 ", "附加 ","固定", "跟随", "动态观察", "可脚本化", "跟踪", "观看"}, function(Value)
    if Value == "自定义" then
    game.Workspace.CurrentCamera.CameraType = "Custom"
    elseif Value == "附加" then
    game.Workspace.CurrentCamera.CameraType = "Attach"
    elseif Value == "固定" then
    game.Workspace.CurrentCamera.CameraType = "Fixed"
    elseif Value == "跟随" then
    game.Workspace.CurrentCamera.CameraType = "Follow"
    elseif Value == "动态观察" then
    game.Workspace.CurrentCamera.CameraType = "Orbital"
    elseif Value == "可脚本化" then
    game.Workspace.CurrentCamera.CameraType = "Scriptable"
    elseif Value == "跟踪" then
    game.Workspace.CurrentCamera.CameraType = "Track"
    elseif Value == "观看" then
    game.Workspace.CurrentCamera.CameraType = "Watch"
    end
end)

Camera:Toggle("切板摄像机的遮挡模式", "DevCameraOcclusionMode", false, function(State)
    if state then
        game:GetService("Players").LocalPlayer.DevCameraOcclusionMode = "Invisicam"
    else
        game:GetService("Players").LocalPlayer.DevCameraOcclusionMode = "Zoom"
    end
end)

Camera:Dropdown("相机", "Camera", {"经典", "第一人称"}, function(Value)
    if Value == "经典" then
    LocalPlayer.CameraMode = "Classic"
    elseif Value == "第一人称" then
    LocalPlayer.CameraMode = "LockFirstPerson"
    end
end)

Spin:Textbox("旋转速度", "SpinSpeed", "输入", function(Value)
    Main.spinspeed = tonumber(Value) or 100
end)

Spin:Toggle("启用/禁用旋转", "Spinbot", false, function(state)
    repeat task.wait() until LocalPlayer.Character
    local humRoot = LocalPlayer.Character:WaitForChild("HumanoidRootPart")
    LocalPlayer.Character:WaitForChild("Humanoid").AutoRotate = false
    if state then
        local velocity = Instance.new("AngularVelocity")
        velocity.Attachment0 = humRoot:WaitForChild("RootAttachment")
        velocity.MaxTorque = math.huge
        velocity.AngularVelocity = Vector3.new(0, Main.spinspeed, 0)
        velocity.Parent = humRoot
        velocity.Name = "Spinbot"
    else
        local spinbot = humRoot:FindFirstChild("Spinbot")
        if spinbot then
            spinbot:Destroy()
        end
    end
end)

Hitbox:Textbox("范围设置", "HitBox", "输入", function(Value)
    Main.HitboxSize = Value
end)

Hitbox:Textbox("透明度设置", "Hitbox", "输入", function(Value)
    Main.HitboxTransparency = Value
end)

Hitbox:Dropdown("选择颜色", "Hitbox", {"Really blue","Really black","Really red","Really pink","Really brown","Really yellow","Really green","Really orange","Really purple","Really light gray"}, function(Value)
    Main.HitboxBrickColor = Value
end)

Hitbox:Toggle("队伍检测", "Hitbox", false, function()
    Main.HitboxTeamCheck = Value
end)

Hitbox:Toggle("开/关范围", "Hitbox", false, function(state)
    Main.HitboxStatue = state
    local function updateHitbox(player)
        if player.Name ~= game:GetService('Players').LocalPlayer.Name then
            pcall(function()
                player.Character.HumanoidRootPart.Size = Vector3.new(Main.HitboxSize, Main.HitboxSize, Main.HitboxSize)
                player.Character.HumanoidRootPart.Transparency = Main.HitboxTransparency
                player.Character.HumanoidRootPart.BrickColor = BrickColor.new(Main.HitboxBrickColor)
                player.Character.HumanoidRootPart.Material = "Neon"
                player.Character.HumanoidRootPart.CanCollide = false
            end)
        end
    end
    game:GetService('RunService').RenderStepped:Connect(function()
        if Main.HitboxStatue then
            for i, v in next, game:GetService('Players'):GetPlayers() do
                if Main.HitboxTeamCheck and v.Team == game:GetService('Players').LocalPlayer.Team then
                    continue
                end
                updateHitbox(v)
            end
        end
    end)
end)


Fly:Toggle("飞行", "Fly", false, function(Value)
	local char = LocalPlayer.Character
	if not char or not char.Humanoid then
		return
	end

	local hum = char.Humanoid
	if nowe == true then
		nowe = false

		hum:SetStateEnabled(Enum.HumanoidStateType.Climbing,true)
		hum:SetStateEnabled(Enum.HumanoidStateType.FallingDown,true)
		hum:SetStateEnabled(Enum.HumanoidStateType.Flying,true)
		hum:SetStateEnabled(Enum.HumanoidStateType.Freefall,true)
		hum:SetStateEnabled(Enum.HumanoidStateType.GettingUp,true)
		hum:SetStateEnabled(Enum.HumanoidStateType.Jumping,true)
		hum:SetStateEnabled(Enum.HumanoidStateType.Landed,true)
		hum:SetStateEnabled(Enum.HumanoidStateType.Physics,true)
		hum:SetStateEnabled(Enum.HumanoidStateType.PlatformStanding,true)
		hum:SetStateEnabled(Enum.HumanoidStateType.Ragdoll,true)
		hum:SetStateEnabled(Enum.HumanoidStateType.Running,true)
		hum:SetStateEnabled(Enum.HumanoidStateType.RunningNoPhysics,true)
		hum:SetStateEnabled(Enum.HumanoidStateType.Seated,true)
		hum:SetStateEnabled(Enum.HumanoidStateType.StrafingNoPhysics,true)
		hum:SetStateEnabled(Enum.HumanoidStateType.Swimming,true)
		hum:ChangeState(Enum.HumanoidStateType.RunningNoPhysics)	
	else
		nowe = true
		updatespeed(char, hum)

		char.Animate.Disabled = true
		for i,v in next, hum:GetPlayingAnimationTracks() do
			v:AdjustSpeed(0)
		end

		hum:SetStateEnabled(Enum.HumanoidStateType.Climbing,false)
		hum:SetStateEnabled(Enum.HumanoidStateType.FallingDown,false)
		hum:SetStateEnabled(Enum.HumanoidStateType.Flying,false)
		hum:SetStateEnabled(Enum.HumanoidStateType.Freefall,false)
		hum:SetStateEnabled(Enum.HumanoidStateType.GettingUp,false)
		hum:SetStateEnabled(Enum.HumanoidStateType.Jumping,false)
		hum:SetStateEnabled(Enum.HumanoidStateType.Landed,false)
		hum:SetStateEnabled(Enum.HumanoidStateType.Physics,false)
		hum:SetStateEnabled(Enum.HumanoidStateType.PlatformStanding,false)
		hum:SetStateEnabled(Enum.HumanoidStateType.Ragdoll,false)
		hum:SetStateEnabled(Enum.HumanoidStateType.Running,false)
		hum:SetStateEnabled(Enum.HumanoidStateType.RunningNoPhysics,false)
		hum:SetStateEnabled(Enum.HumanoidStateType.Seated,false)
		hum:SetStateEnabled(Enum.HumanoidStateType.StrafingNoPhysics,false)
		hum:SetStateEnabled(Enum.HumanoidStateType.Swimming,false)
		hum:ChangeState(Enum.HumanoidStateType.Swimming)
	end
    
    local function CheckRig()
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Torso") then
                return LocalPlayer.Character.Torso
        elseif LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("LowerTorso") then
                return LocalPlayer.Character.LowerTorso
        end
    end


	local UpperTorso = CheckRig()
	local flying = true
	local deb = true
	local ctrl = {f = 0, b = 0, l = 0, r = 0}
	local lastctrl = {f = 0, b = 0, l = 0, r = 0}
	local maxspeed = 50
	local speed = 0

	local bg = Instance.new("BodyGyro", UpperTorso)
	bg.P = 9e4
	bg.maxTorque = Vector3.new(9e9, 9e9, 9e9)
	bg.cframe = UpperTorso.CFrame

	local bv = Instance.new("BodyVelocity", UpperTorso)
	bv.velocity = Vector3.new(0,0.1,0)
	bv.maxForce = Vector3.new(9e9, 9e9, 9e9)

	if nowe == true then
		hum.PlatformStand = true
	end

	while nowe == true or hum.Health == 0 do
		task.wait()

		if ctrl.l + ctrl.r ~= 0 or ctrl.f + ctrl.b ~= 0 then
			speed = speed+.5+(speed/maxspeed)
			if speed > maxspeed then
				speed = maxspeed
			end
		elseif not (ctrl.l + ctrl.r ~= 0 or ctrl.f + ctrl.b ~= 0) and speed ~= 0 then
			speed = speed-1
			if speed < 0 then
				speed = 0
			end
		end
		if (ctrl.l + ctrl.r) ~= 0 or (ctrl.f + ctrl.b) ~= 0 then
			bv.velocity = ((game.Workspace.CurrentCamera.CoordinateFrame.lookVector * (ctrl.f+ctrl.b)) + ((game.Workspace.CurrentCamera.CoordinateFrame * CFrame.new(ctrl.l+ctrl.r,(ctrl.f+ctrl.b)*.2,0).p) - game.Workspace.CurrentCamera.CoordinateFrame.p))*speed
			lastctrl = {f = ctrl.f, b = ctrl.b, l = ctrl.l, r = ctrl.r}
		elseif (ctrl.l + ctrl.r) == 0 and (ctrl.f + ctrl.b) == 0 and speed ~= 0 then
			bv.velocity = ((game.Workspace.CurrentCamera.CoordinateFrame.lookVector * (lastctrl.f+lastctrl.b)) + ((game.Workspace.CurrentCamera.CoordinateFrame * CFrame.new(lastctrl.l+lastctrl.r,(lastctrl.f+lastctrl.b)*.2,0).p) - game.Workspace.CurrentCamera.CoordinateFrame.p))*speed
		else
			bv.velocity = Vector3.new(0,0,0)
		end

		bg.cframe = game.Workspace.CurrentCamera.CoordinateFrame * CFrame.Angles(-math.rad((ctrl.f+ctrl.b)*50*speed/maxspeed),0,0)
	end

	ctrl = {f = 0, b = 0, l = 0, r = 0}
	lastctrl = {f = 0, b = 0, l = 0, r = 0}
	speed = 0
	bg:Destroy()
	bv:Destroy()

	hum.PlatformStand = false
	char.Animate.Disabled = false
	tpwalking = false
end, false)

Fly:Button("速度 + 1", function()
	local char = LocalPlayer.Character
	if char and char.Humanoid then
		local hum = char.Humanoid
		speeds = speeds + 1
		updatespeed(char, hum)
		end
end)

Fly:Button("速度 - 1", function()
	local char = LocalPlayer.Character
	if char and char.Humanoid then
		local hum = char.Humanoid
		if speeds > 1 then
			speeds = speeds - 1
			updatespeed(char, hum)
		end
    end
end)

Fly:Button("上升", function(up)
    if up then
        if game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart") then 
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0,1,0)
        end
    end
end)

Fly:Button("下降", function(down)
    if down then
        if game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart") then 
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0,-1,0)
        end
    end
end)

local Flyspeed = Fly:Label("当前速度:"..speeds)
spawn(function()
while wait() do
pcall(function()
Flyspeed.Text = "当前速度:"..speeds
end)
end
end)

Head:Textbox("头部大小(让他们成为大头儿子吧)", "Head", "输入", function(Value)
   local Settings = {Size = Value}
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
function Alive(player)
    if player then
        return player.Character and player.Character:FindFirstChild("Head") and player.Character:FindFirstChild("Humanoid") or false
    end
    return false
end
for i,v in pairs(Players:GetPlayers()) do
    if v ~= LocalPlayer and Alive(v) then
        v.Character.Head.Massless = true
        v.Character.Head.Size = Vector3.new(Settings.Size, Settings.Size, Settings.Size)
    end
    v.CharacterAdded:Connect(function()
        while not Alive(v) do wait() end
        v.Character.Head.Massless = true
        v.Character.Head.Size = Vector3.new(Settings.Size, Settings.Size, Settings.Size)
    end)
end
Players.PlayerAdded:Connect(function(player)
    player.CharacterAdded:Wait()
    if Alive(player) then
        player.Character.Head.Massless = true
        player.Character.Head.Size = Vector3.new(Settings.Size, Settings.Size, Settings.Size)
    end
    player.CharacterAdded:Connect(function()
        while not Alive(player) do wait() end
        player.Character.Head.Massless = true
        player.Character.Head.Size = Vector3.new(Settings.Size, Settings.Size, Settings.Size)
    end)
end)
end)

Aimbot:Toggle("显示FOV", "open/close", false, function(state)
    if state then
        createFOV(Aimbot.fovsize, Aimbot.fovcolor, Aimbot.fovthickness, Aimbot.Transparency)
    else
        destroyFOV()
    end
end)

Aimbot:Toggle("启动/禁用自瞄", "open/close", false, function(state)
    Aimbot.AimbotEnable = state
end)

Aimbot:Toggle("队伍检测", "", false, function(state)
    Aimbot.teamCheck = state
end)

Aimbot:Toggle("活体检测", "", false, function(state)
    Aimbot.aliveCheck = state
end)

Aimbot:Toggle("墙壁检测", "", false, function(state)
    Aimbot.wallCheck = state
end)

Aimbot:Toggle("开启平滑度", "", function(state)
    Aimbot.smoothingEnabled = state
end)

Aimbot:Slider("FOV厚度", "", 2, 0, 10, function(value)
    Aimbot.fovthickness = value
    updateFOV()
end)

Aimbot:Slider("FOV大小", "", 20, 0, 100, function(value)
    Aimbot.fovsize = value
    updateFOV()
end)

Aimbot:Slider("FOV透明度", "", 1, 0, 10, function(value)
    Aimbot.Transparency = value
    updateFOV()
end)

Aimbot:Slider("平滑度", "", 40, 10, 500, function(value)
    Aimbot.smoothing = value
end)

Aimbot:Toggle("开启预判自瞄", "", function(state)
    Aimbot.prejudgingselfsighting = state
end)

Aimbot:Slider("预判距离", "",40, 10, 500, function(value)
    Aimbot.prejudgingselfsightingdistance = value
end)

Aimbot:Dropdown('FOV颜色', 'Dropdown', {"红色", "蓝色", "黄色", "绿色", "青色", "橙色", "紫色", "白色", "黑色", "彩虹色"}, function(value)
    local TweenService = game:GetService("TweenService")
    local UIGradient = Instance.new("UIGradient")
    UIGradient.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 0, 0)),
        ColorSequenceKeypoint.new(0.10, Color3.fromRGB(255, 127, 0)),
        ColorSequenceKeypoint.new(0.20, Color3.fromRGB(255, 255, 0)),
        ColorSequenceKeypoint.new(0.30, Color3.fromRGB(0, 255, 0)),
        ColorSequenceKeypoint.new(0.40, Color3.fromRGB(0, 255, 255)),
        ColorSequenceKeypoint.new(0.50, Color3.fromRGB(0, 0, 255)),
        ColorSequenceKeypoint.new(0.60, Color3.fromRGB(139, 0, 255)),
        ColorSequenceKeypoint.new(0.70, Color3.fromRGB(255, 0, 0)),
        ColorSequenceKeypoint.new(0.80, Color3.fromRGB(255, 127, 0)),
        ColorSequenceKeypoint.new(0.90, Color3.fromRGB(255, 255, 0)),
        ColorSequenceKeypoint.new(1.00, Color3.fromRGB(0, 255, 0))
    }
    UIGradient.Rotation = 10
    if value == "红色" then
        Aimbot.fovcolor = Color3.fromRGB(255, 0, 0)
    elseif value == "蓝色" then
        Aimbot.fovcolor = Color3.fromRGB(0, 0, 255)
    elseif value == "黄色" then
        Aimbot.fovcolor = Color3.fromRGB(255, 255, 0)
    elseif value == "绿色" then
        Aimbot.fovcolor = Color3.fromRGB(0, 255, 0)
    elseif value == "青色" then
        Aimbot.fovcolor = Color3.fromRGB(0, 255, 255)
    elseif value == "橙色" then
        Aimbot.fovcolor = Color3.fromRGB(255, 165, 0)
    elseif value == "紫色" then
        Aimbot.fovcolor = Color3.fromRGB(128, 0, 128)
    elseif value == "白色" then
        Aimbot.fovcolor = Color3.fromRGB(255, 255, 255)
    elseif value == "黑色" then
        Aimbot.fovcolor = Color3.fromRGB(0, 0, 0)
    elseif value == "彩虹色" then
        UIGradient.Parent = FOVring
        
        local tweeninfo = TweenInfo.new(7, Enum.EasingStyle.Linear, Enum.EasingDirection.In, -1)
        local tween = TweenService:Create(UIGradient, tweeninfo, {Rotation = 360})
        tween:Play()
    end
end)

Aimbot:Dropdown('选择部位', 'Dropdown', {"头部 (Head)", "人形根部件 (HumanoidRootPart)", "躯干 (Torso)", "左臂 (Left Arm)", "右臂 (Right Arm)", "左腿 (Left Leg)", "右腿 (Right Leg)", "左手 (LeftHand)", "右手 (RightHand)", "左小臂 (LeftLowerArm)", "右小臂 (RightLowerArm)", "左大臂 (LeftUpperArm)", "右大臂 (RightUpperArm)", "左脚 (LeftFoot)", "左小腿 (LeftLowerLeg)", "上半身 (UpperTorso)", "左大腿 (LeftUpperLeg)", "右脚 (RightFoot)", "右小腿 (RightLowerLeg)", "下半身 (LowerTorso)", "右大腿 (RightUpperLeg)"}, function(Value)
    if Value == "头部 (Head)" then
        Aimbot.Position = "Head"
    elseif Value == "人形根部件 (HumanoidRootPart)" then
        Aimbot.Position = "HumanoidRootPart"
    elseif Value == "躯干 (Torso)" then
        Aimbot.Position = "Torso"
    elseif Value == "左臂 (Left Arm)" then
        Aimbot.Position = "Left Arm"
    elseif Value == "右臂 (Right Arm)" then
        Aimbot.Position = "Right Arm"
    elseif Value == "左腿 (Left Leg)" then
        Aimbot.Position = "Left Leg"
    elseif Value == "右腿 (Right Leg)" then
        Aimbot.Position = "Right Leg"
    elseif Value == "左手 (LeftHand)" then
        Aimbot.Position = "LeftHand"
    elseif Value == "右手 (RightHand)" then
        Aimbot.Position = "RightHand"
    elseif Value == "左小臂 (LeftLowerArm)" then
        Aimbot.Position = "LeftLowerArm"
    elseif Value == "右小臂 (RightLowerArm)" then
        Aimbot.Position = "RightLowerArm"
    elseif Value == "左大臂 (LeftUpperArm)" then
        Aimbot.Position = "LeftUpperArm"
    elseif Value == "右大臂 (RightUpperArm)" then
        Aimbot.Position = "RightUpperArm"
    elseif Value == "左脚 (LeftFoot)" then
        Aimbot.Position = "LeftFoot"
    elseif Value == "左小腿 (LeftLowerLeg)" then
        Aimbot.Position = "LeftLowerLeg"
    elseif Value == "上半身 (UpperTorso)" then
        Aimbot.Position = "UpperTorso"
    elseif Value == "左大腿 (LeftUpperLeg)" then
        Aimbot.Position = "LeftUpperLeg"
    elseif Value == "右脚 (RightFoot)" then
        Aimbot.Position = "RightFoot"
    elseif Value == "右小腿 (RightLowerLeg)" then
        Aimbot.Position = "RightLowerLeg"
    elseif Value == "下半身 (LowerTorso)" then
        Aimbot.Position = "LowerTorso"
    elseif Value == "右大腿 (RightUpperLeg)" then
        Aimbot.Position = "RightUpperLeg"
    end
    updateFOV()
end)

Aimbot:Toggle("预判自瞄","", false, function(state)
    Aimbot.prejudgingselfsighting = state
end)

Aimbot:Slider("预判距离","", 40, 10, 500, function(value)
    Aimbot.prejudgingselfsightingdistance = value
end)

ESP:Toggle("总开关", "ESP", false, function(state)
    if state then
        RunService:BindToRenderStep("ESPUpdate", Enum.RenderPriority.Camera.Value, updateESP)
    else
        RunService:UnbindFromRenderStep("ESPUpdate")
        destroyESP()
    end
end)

ESP:Toggle("名字显示", "ESP", false, function(state)
    if state then
        for _, player in ipairs(Players:GetPlayers()) do
            if player ~= Players.LocalPlayer then
                createESPName(player)
            end
        end
    else
        for _, espName in pairs(espNames) do
            espName:Remove()
        end
        espNames = {}
    end
end)

ESP:Toggle("健康显示", "ESP", false, function(state)
    if state then
        for _, player in ipairs(Players:GetPlayers()) do
            if player ~= Players.LocalPlayer then
                createESPHealth(player)
            end
        end
    else
        for _, espHealth in pairs(espHealths) do
            espHealth:Remove()
        end
        espHealths = {}
    end
end)

ESP:Toggle("高光显示", "ESP", false, function(state)
    if state then
        for _, player in ipairs(Players:GetPlayers()) do
            if player ~= Players.LocalPlayer then
                createESPHighlight(player)
            end
        end
    else
        for _, espHighlight in pairs(espHighlights) do
            espHighlight:Destroy()
        end
        espHighlights = {}
    end
end)

ESP:Toggle("距离显示", "ESP", false, function(state)
    if state then
        for _, player in ipairs(Players:GetPlayers()) do
            if player ~= Players.LocalPlayer then
                createESPDistance(player)
            end
        end
    else
        for _, espDistance in pairs(espDistances) do
            espDistance:Remove()
        end
        espDistances = {}
    end
end)

ESP:Toggle("示踪线显示", "ESP", false, function(state)
    if state then
        for _, player in ipairs(Players:GetPlayers()) do
            if player ~= Players.LocalPlayer then
                createESPTracer(player)
            end
        end
    else
        for _, espTracer in pairs(espTracers) do
            espTracer:Remove()
        end
        espTracers = {}
    end
end)

ESP:Toggle("名字显示", "ESP", false, function(state)
    if state then
        for _, player in ipairs(Players:GetPlayers()) do
            if player ~= Players.LocalPlayer then
                createESPBox(player)
            end
        end
    else
        for _, espBox in pairs(espBoxes) do
            espBox:Remove()
        end
        espBoxes = {}
    end
end)

ESP:Dropdown('颜色', 'Dropdown', {"红色", "蓝色", "黄色", "绿色", "青色", "橙色", "紫色", "白色", "黑色", "彩虹色"}, function(value)
    local TweenService = game:GetService("TweenService")
    local UIGradient = Instance.new("UIGradient")
    UIGradient.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 0, 0)),
        ColorSequenceKeypoint.new(0.10, Color3.fromRGB(255, 127, 0)),
        ColorSequenceKeypoint.new(0.20, Color3.fromRGB(255, 255, 0)),
        ColorSequenceKeypoint.new(0.30, Color3.fromRGB(0, 255, 0)),
        ColorSequenceKeypoint.new(0.40, Color3.fromRGB(0, 255, 255)),
        ColorSequenceKeypoint.new(0.50, Color3.fromRGB(0, 0, 255)),
        ColorSequenceKeypoint.new(0.60, Color3.fromRGB(139, 0, 255)),
        ColorSequenceKeypoint.new(0.70, Color3.fromRGB(255, 0, 0)),
        ColorSequenceKeypoint.new(0.80, Color3.fromRGB(255, 127, 0)),
        ColorSequenceKeypoint.new(0.90, Color3.fromRGB(255, 255, 0)),
        ColorSequenceKeypoint.new(1.00, Color3.fromRGB(0, 255, 0))
    }
    UIGradient.Rotation = 10
    if value == "红色" then
        ESPSetting.color = Color3.fromRGB(255, 0, 0)
    elseif value == "蓝色" then
        ESPSetting.color = Color3.fromRGB(0, 0, 255)
    elseif value == "黄色" then
        ESPSetting.color = Color3.fromRGB(255, 255, 0)
    elseif value == "绿色" then
        ESPSetting.color = Color3.fromRGB(0, 255, 0)
    elseif value == "青色" then
        ESPSetting.color = Color3.fromRGB(0, 255, 255)
    elseif value == "橙色" then
        ESPSetting.color = Color3.fromRGB(255, 165, 0)
    elseif value == "紫色" then
        ESPSetting.color = Color3.fromRGB(128, 0, 128)
    elseif value == "白色" then
        ESPSetting.color = Color3.fromRGB(255, 255, 255)
    elseif value == "黑色" then
        ESPSetting.color = Color3.fromRGB(0, 0, 0)
    elseif value == "彩虹色" then
        UIGradient.Parent = Text
        UIGradient.Parent = Highlight
        UIGradient.Parent = Square
        local tweeninfo = TweenInfo.new(7, Enum.EasingStyle.Linear, Enum.EasingDirection.In, -1)
        local tween = TweenService:Create(UIGradient, tweeninfo, {Rotation = 360})
        tween:Play()
    end
end)

local Players = Select:Dropdown("选择玩家名字已开始下面的功能", 'Dropdown', LS.dropdown, function(v)
    LS.playernamedied = v
end)

Select:Button("重置玩家名字", function()
    shuaxinlb(true)
    Players:SetOptions(LS.dropdown)
end)

Select:Button("传送到玩家旁边", function()
    local HumRoot = game.Players.LocalPlayer.Character.HumanoidRootPart
    local tp_player = game.Players:FindFirstChild(LS.playernamedied)
    if tp_player and tp_player.Character and tp_player.Character.HumanoidRootPart then
        HumRoot.CFrame = tp_player.Character.HumanoidRootPart.CFrame + Vector3.new(0, 3, 0)
        Notify("LSTM Archive", "已经传送到玩家身边", "rbxassetid://", 5)
    else
        Notify("LSTM Archive", "无法传送 玩家已消失", "rbxassetid://", 5)
    end
end)

Select:Toggle("锁定传送", "Loop", false, function(state)
    if state then
        LS.LoopTeleport = true
        Notify("LSTM Archive", "已开启循环传送", "rbxassetid://", 5)
        while LS.LoopTeleport do
            local HumRoot = game.Players.LocalPlayer.Character.HumanoidRootPart
            local tp_player = game.Players:FindFirstChild(LS.playernamedied)
            if tp_player and tp_player.Character and tp_player.Character.HumanoidRootPart then
                HumRoot.CFrame = tp_player.Character.HumanoidRootPart.CFrame + Vector3.new(0, 3, 0)
            end
            wait()
        end
    else
        LS.LoopTeleport = false
        Notify("LSTM Archive", "已停止循环传送", "rbxassetid://", 5)
    end
end)

Select:Button("把玩家传送过来", function()
    local HumRoot = game.Players.LocalPlayer.Character.HumanoidRootPart
    local tp_player = game.Players:FindFirstChild(LS.playernamedied)
    if tp_player and tp_player.Character and tp_player.Character.HumanoidRootPart then
        tp_player.Character.HumanoidRootPart.CFrame = HumRoot.CFrame + Vector3.new(0, 3, 0)
        Notify("LSTM Archive", "已传送过来", "rbxassetid://", 5)
    else
        Notify("LSTM Archive", "无法传送:玩家已消失", "rbxassetid://", 5)
    end
end)

Select:Toggle("循环传送玩家过来", "Loop", false, function(state)
    if state then
        LS.LoopTeleport = true
        Notify("LSTM Archive", "已开启循环传送玩家过来", "rbxassetid://", 5)
        while LS.LoopTeleport do
            local HumRoot = game.Players.LocalPlayer.Character.HumanoidRootPart
            local tp_player = game.Players:FindFirstChild(LS.playernamedied)
            if tp_player and tp_player.Character and tp_player.Character.HumanoidRootPart then
                tp_player.Character.HumanoidRootPart.CFrame = HumRoot.CFrame + Vector3.new(0, 3, 0)
            end
            wait()
        end
    else
        LS.LoopTeleport = false
        Notify("LSTM Archive", "已停止循环传送玩家过来", "rbxassetid://", 5)
    end
end)

Select:Toggle("吸全部玩家", "Get All", false, function(state)
    if state then
        while state do
            for i, v in next, game:GetService('Players'):GetPlayers() do
                if v.Name ~= game:GetService('Players').LocalPlayer.Name then 
                    local localPlayerPosition = game:GetService('Players').LocalPlayer.Character.HumanoidRootPart.Position
                    local direction = game:GetService('Players').LocalPlayer.Character.HumanoidRootPart.CFrame.lookVector
                    local newPosition = localPlayerPosition + direction * 3
                    v.Character.HumanoidRootPart.CFrame = CFrame.new(newPosition, localPlayerPosition + direction * 4)
                    wait()
                end
            end
        end
    end
end)

Select:Toggle("查看玩家", "look player", false, function(state)
    if state then
        game:GetService('Workspace').CurrentCamera.CameraSubject =
            game:GetService('Players'):FindFirstChild(LS.playernamedied).Character.Humanoid
        Notify("LSTM Archive", "已打开查看玩家", "rbxassetid://", 5)
    else
        local lp = game.Players.LocalPlayer
        game:GetService('Workspace').CurrentCamera.CameraSubject = lp.Character.Humanoid
        Notify("LSTM Archive", "已关闭查看玩家", "rbxassetid://", 5)
    end
end)

Select:Button("甩飞一次", function()
if LS.playernamedied == nil then 
elseif LS.playernamedied ~= nil then
local Targets = {LS.playernamedied}

local Players = game:GetService("Players")
local Player = Players.LocalPlayer

local AllBool = false

local GetPlayer = function(Name)
    Name = Name:lower()
    if Name == "all" or Name == "others" then
        AllBool = true
        return
    elseif Name == "random" then
        local GetPlayers = Players:GetPlayers()
        if table.find(GetPlayers,Player) then table.remove(GetPlayers,table.find(GetPlayers,Player)) end
        return GetPlayers[math.random(#GetPlayers)]
    elseif Name ~= "random" and Name ~= "all" and Name ~= "others" then
        for _,x in next, Players:GetPlayers() do
            if x ~= Player then
                if x.Name:lower():match("^"..Name) then
                    return x;
                elseif x.DisplayName:lower():match("^"..Name) then
                    return x;
                end
            end
        end
    else
        return
    end
end

local Message = function(_Title, _Text, Time)
    game:GetService("StarterGui"):SetCore("SendNotification", {Title = _Title, Text = _Text, Duration = Time})
end

local SkidFling = function(TargetPlayer)
    local Character = Player.Character
    local Humanoid = Character and Character:FindFirstChildOfClass("Humanoid")
    local RootPart = Humanoid and Humanoid.RootPart

    local TCharacter = TargetPlayer.Character
    local THumanoid
    local TRootPart
    local THead
    local Accessory
    local Handle

    if TCharacter:FindFirstChildOfClass("Humanoid") then
        THumanoid = TCharacter:FindFirstChildOfClass("Humanoid")
    end
    if THumanoid and THumanoid.RootPart then
        TRootPart = THumanoid.RootPart
    end
    if TCharacter:FindFirstChild("Head") then
        THead = TCharacter.Head
    end
    if TCharacter:FindFirstChildOfClass("Accessory") then
        Accessory = TCharacter:FindFirstChildOfClass("Accessory")
    end
    if Accessoy and Accessory:FindFirstChild("Handle") then
        Handle = Accessory.Handle
    end

    if Character and Humanoid and RootPart then
        if RootPart.Velocity.Magnitude < 50 then
            getgenv().OldPos = RootPart.CFrame
        end
        if THumanoid and THumanoid.Sit and not AllBool then
            return Message("玩家消失", "已停止", 5)
        end
        if THead then
            workspace.CurrentCamera.CameraSubject = THead
        elseif not THead and Handle then
            workspace.CurrentCamera.CameraSubject = Handle
        elseif THumanoid and TRootPart then
            workspace.CurrentCamera.CameraSubject = THumanoid
        end
        if not TCharacter:FindFirstChildWhichIsA("BasePart") then
            return
        end

        local FPos = function(BasePart, Pos, Ang)
            RootPart.CFrame = CFrame.new(BasePart.Position) * Pos * Ang
            Character:SetPrimaryPartCFrame(CFrame.new(BasePart.Position) * Pos * Ang)
            RootPart.Velocity = Vector3.new(9e7, 9e7 * 10, 9e7)
            RootPart.RotVelocity = Vector3.new(9e8, 9e8, 9e8)
        end

        local SFBasePart = function(BasePart)
            local TimeToWait = 2
            local Time = tick()
            local Angle = 0

            repeat
                if RootPart and THumanoid then
                    if BasePart.Velocity.Magnitude < 50 then
                        Angle = Angle + 100

                        FPos(BasePart, CFrame.new(0, 1.5, 0) + THumanoid.MoveDirection * BasePart.Velocity.Magnitude / 1.25, CFrame.Angles(math.rad(Angle),0 ,0))
                        task.wait()

                        FPos(BasePart, CFrame.new(0, -1.5, 0) + THumanoid.MoveDirection * BasePart.Velocity.Magnitude / 1.25, CFrame.Angles(math.rad(Angle), 0, 0))
                        task.wait()

                        FPos(BasePart, CFrame.new(2.25, 1.5, -2.25) + THumanoid.MoveDirection * BasePart.Velocity.Magnitude / 1.25, CFrame.Angles(math.rad(Angle), 0, 0))
                        task.wait()

                        FPos(BasePart, CFrame.new(-2.25, -1.5, 2.25) + THumanoid.MoveDirection * BasePart.Velocity.Magnitude / 1.25, CFrame.Angles(math.rad(Angle), 0, 0))
                        task.wait()

                        FPos(BasePart, CFrame.new(0, 1.5, 0) + THumanoid.MoveDirection,CFrame.Angles(math.rad(Angle), 0, 0))
                        task.wait()

                        FPos(BasePart, CFrame.new(0, -1.5, 0) + THumanoid.MoveDirection,CFrame.Angles(math.rad(Angle), 0, 0))
                        task.wait()
                    else
                        FPos(BasePart, CFrame.new(0, 1.5, THumanoid.WalkSpeed), CFrame.Angles(math.rad(90), 0, 0))
                        task.wait()

                        FPos(BasePart, CFrame.new(0, -1.5, -THumanoid.WalkSpeed), CFrame.Angles(0, 0, 0))
                        task.wait()

                        FPos(BasePart, CFrame.new(0, 1.5, THumanoid.WalkSpeed), CFrame.Angles(math.rad(90), 0, 0))
                        task.wait()

                        FPos(BasePart, CFrame.new(0, 1.5, TRootPart.Velocity.Magnitude / 1.25), CFrame.Angles(math.rad(90), 0, 0))
                        task.wait()

                        FPos(BasePart, CFrame.new(0, -1.5, -TRootPart.Velocity.Magnitude / 1.25), CFrame.Angles(0, 0, 0))
                        task.wait()

                        FPos(BasePart, CFrame.new(0, 1.5, TRootPart.Velocity.Magnitude / 1.25), CFrame.Angles(math.rad(90), 0, 0))
                        task.wait()

                        FPos(BasePart, CFrame.new(0, -1.5, 0), CFrame.Angles(math.rad(90), 0, 0))
                        task.wait()

                        FPos(BasePart, CFrame.new(0, -1.5, 0), CFrame.Angles(0, 0, 0))
                        task.wait()

                        FPos(BasePart, CFrame.new(0, -1.5 ,0), CFrame.Angles(math.rad(-90), 0, 0))
                        task.wait()

                        FPos(BasePart, CFrame.new(0, -1.5, 0), CFrame.Angles(0, 0, 0))
                        task.wait()
                    end
                else
                    break
                end
            until BasePart.Velocity.Magnitude > 500 or BasePart.Parent ~= TargetPlayer.Character or TargetPlayer.Parent ~= Players or not TargetPlayer.Character == TCharacter or THumanoid.Sit or Humanoid.Health <= 0 or tick() > Time + TimeToWait
        end

        workspace.FallenPartsDestroyHeight = 0/0

        local BV = Instance.new("BodyVelocity")
        BV.Name = "EpixVel"
        BV.Parent = RootPart
        BV.Velocity = Vector3.new(9e8, 9e8, 9e8)
        BV.MaxForce = Vector3.new(1/0, 1/0, 1/0)

        Humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated, false)

        if TRootPart and THead then
            if (TRootPart.CFrame.p - THead.CFrame.p).Magnitude > 5 then
                SFBasePart(THead)
            else
                SFBasePart(TRootPart)
            end
        elseif TRootPart and not THead then
            SFBasePart(TRootPart)
        elseif not TRootPart and THead then
            SFBasePart(THead)
        elseif not TRootPart and not THead and Accessory and Handle then
            SFBasePart(Handle)
        else
            return Message("已开启/关", "LSTM Archive", 5)
        end

        BV:Destroy()
        Humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated, true)
        workspace.CurrentCamera.CameraSubject = Humanoid

        repeat
            RootPart.CFrame = getgenv().OldPos * CFrame.new(0, .5, 0)
            Character:SetPrimaryPartCFrame(getgenv().OldPos * CFrame.new(0, .5, 0))
            Humanoid:ChangeState("GettingUp")
            table.foreach(Character:GetChildren(), function(_, x)
                if x:IsA("BasePart") then
                    x.Velocity, x.RotVelocity = Vector3.new(), Vector3.new()
                end
            end)
            task.wait()
        until (RootPart.Position - getgenv().OldPos.p).Magnitude < 25
        workspace.FallenPartsDestroyHeight = getgenv().FPDH
    else
        return Message("玩家消失", "已停止", 5)
    end
end

if Targets[1] then for _,x in next, Targets do GetPlayer(x) end else return end

if AllBool then
    for _,x in next, Players:GetPlayers() do
        SkidFling(x)
    end
end

for _,x in next, Targets do
    if GetPlayer(x) and GetPlayer(x) ~= Player then
        if GetPlayer(x).UserId ~= 1414978355 then
            local TPlayer = GetPlayer(x)
            if TPlayer then
                SkidFling(TPlayer)
            end
        else
            Message("检测到玩家消失", "己停止", 5)
        end
    elseif not GetPlayer(x) and not AllBool then
        Message("未获取到玩家或工具", "已停止", 5)
    end
end
end
end)

Select:Toggle("循环甩飞", "Auto Fling", false, function(t)
if LS.playernamedied == nil then
 elseif LS.playernamedied ~= nil then
getgenv().autofling = t
spawn(function()
while autofling do wait()
pcall(function()
local Targets = {LS.playernamedied}

local Players = game:GetService("Players")
local Player = Players.LocalPlayer

local AllBool = false

local GetPlayer = function(Name)
    Name = Name:lower()
    if Name == "all" or Name == "others" then
        AllBool = true
        return
    elseif Name == "random" then
        local GetPlayers = Players:GetPlayers()
        if table.find(GetPlayers,Player) then table.remove(GetPlayers,table.find(GetPlayers,Player)) end
        return GetPlayers[math.random(#GetPlayers)]
    elseif Name ~= "random" and Name ~= "all" and Name ~= "others" then
        for _,x in next, Players:GetPlayers() do
            if x ~= Player then
                if x.Name:lower():match("^"..Name) then
                    return x;
                elseif x.DisplayName:lower():match("^"..Name) then
                    return x;
                end
            end
        end
    else
        return
    end
end

local Message = function(_Title, _Text, Time)
    game:GetService("StarterGui"):SetCore("SendNotification", {Title = _Title, Text = _Text, Duration = Time})
end

local SkidFling = function(TargetPlayer)
    local Character = Player.Character
    local Humanoid = Character and Character:FindFirstChildOfClass("Humanoid")
    local RootPart = Humanoid and Humanoid.RootPart

    local TCharacter = TargetPlayer.Character
    local THumanoid
    local TRootPart
    local THead
    local Accessory
    local Handle

    if TCharacter:FindFirstChildOfClass("Humanoid") then
        THumanoid = TCharacter:FindFirstChildOfClass("Humanoid")
    end
    if THumanoid and THumanoid.RootPart then
        TRootPart = THumanoid.RootPart
    end
    if TCharacter:FindFirstChild("Head") then
        THead = TCharacter.Head
    end
    if TCharacter:FindFirstChildOfClass("Accessory") then
        Accessory = TCharacter:FindFirstChildOfClass("Accessory")
    end
    if Accessoy and Accessory:FindFirstChild("Handle") then
        Handle = Accessory.Handle
    end

    if Character and Humanoid and RootPart then
        if RootPart.Velocity.Magnitude < 50 then
            getgenv().OldPos = RootPart.CFrame
        end
        if THumanoid and THumanoid.Sit and not AllBool then
            return Message("Error❌", "LSTM Archive", 5)
        end
        if THead then
            workspace.CurrentCamera.CameraSubject = THead
        elseif not THead and Handle then
            workspace.CurrentCamera.CameraSubject = Handle
        elseif THumanoid and TRootPart then
            workspace.CurrentCamera.CameraSubject = THumanoid
        end
        if not TCharacter:FindFirstChildWhichIsA("BasePart") then
            return
        end

        local FPos = function(BasePart, Pos, Ang)
            RootPart.CFrame = CFrame.new(BasePart.Position) * Pos * Ang
            Character:SetPrimaryPartCFrame(CFrame.new(BasePart.Position) * Pos * Ang)
            RootPart.Velocity = Vector3.new(9e7, 9e7 * 10, 9e7)
            RootPart.RotVelocity = Vector3.new(9e8, 9e8, 9e8)
        end

        local SFBasePart = function(BasePart)
            local TimeToWait = 2
            local Time = tick()
            local Angle = 0

            repeat
                if RootPart and THumanoid then
                    if BasePart.Velocity.Magnitude < 50 then
                        Angle = Angle + 100

                        FPos(BasePart, CFrame.new(0, 1.5, 0) + THumanoid.MoveDirection * BasePart.Velocity.Magnitude / 1.25, CFrame.Angles(math.rad(Angle),0 ,0))
                        task.wait()

                        FPos(BasePart, CFrame.new(0, -1.5, 0) + THumanoid.MoveDirection * BasePart.Velocity.Magnitude / 1.25, CFrame.Angles(math.rad(Angle), 0, 0))
                        task.wait()

                        FPos(BasePart, CFrame.new(2.25, 1.5, -2.25) + THumanoid.MoveDirection * BasePart.Velocity.Magnitude / 1.25, CFrame.Angles(math.rad(Angle), 0, 0))
                        task.wait()

                        FPos(BasePart, CFrame.new(-2.25, -1.5, 2.25) + THumanoid.MoveDirection * BasePart.Velocity.Magnitude / 1.25, CFrame.Angles(math.rad(Angle), 0, 0))
                        task.wait()

                        FPos(BasePart, CFrame.new(0, 1.5, 0) + THumanoid.MoveDirection,CFrame.Angles(math.rad(Angle), 0, 0))
                        task.wait()

                        FPos(BasePart, CFrame.new(0, -1.5, 0) + THumanoid.MoveDirection,CFrame.Angles(math.rad(Angle), 0, 0))
                        task.wait()
                    else
                        FPos(BasePart, CFrame.new(0, 1.5, THumanoid.WalkSpeed), CFrame.Angles(math.rad(90), 0, 0))
                        task.wait()

                        FPos(BasePart, CFrame.new(0, -1.5, -THumanoid.WalkSpeed), CFrame.Angles(0, 0, 0))
                        task.wait()

                        FPos(BasePart, CFrame.new(0, 1.5, THumanoid.WalkSpeed), CFrame.Angles(math.rad(90), 0, 0))
                        task.wait()

                        FPos(BasePart, CFrame.new(0, 1.5, TRootPart.Velocity.Magnitude / 1.25), CFrame.Angles(math.rad(90), 0, 0))
                        task.wait()

                        FPos(BasePart, CFrame.new(0, -1.5, -TRootPart.Velocity.Magnitude / 1.25), CFrame.Angles(0, 0, 0))
                        task.wait()

                        FPos(BasePart, CFrame.new(0, 1.5, TRootPart.Velocity.Magnitude / 1.25), CFrame.Angles(math.rad(90), 0, 0))
                        task.wait()

                        FPos(BasePart, CFrame.new(0, -1.5, 0), CFrame.Angles(math.rad(90), 0, 0))
                        task.wait()

                        FPos(BasePart, CFrame.new(0, -1.5, 0), CFrame.Angles(0, 0, 0))
                        task.wait()

                        FPos(BasePart, CFrame.new(0, -1.5 ,0), CFrame.Angles(math.rad(-90), 0, 0))
                        task.wait()

                        FPos(BasePart, CFrame.new(0, -1.5, 0), CFrame.Angles(0, 0, 0))
                        task.wait()
                    end
                else
                    break
                end
            until BasePart.Velocity.Magnitude > 500 or BasePart.Parent ~= TargetPlayer.Character or TargetPlayer.Parent ~= Players or not TargetPlayer.Character == TCharacter or THumanoid.Sit or Humanoid.Health <= 0 or tick() > Time + TimeToWait
        end

        workspace.FallenPartsDestroyHeight = 0/0

        local BV = Instance.new("BodyVelocity")
        BV.Name = "EpixVel"
        BV.Parent = RootPart
        BV.Velocity = Vector3.new(9e8, 9e8, 9e8)
        BV.MaxForce = Vector3.new(1/0, 1/0, 1/0)

        Humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated, false)

        if TRootPart and THead then
            if (TRootPart.CFrame.p - THead.CFrame.p).Magnitude > 5 then
                SFBasePart(THead)
            else
                SFBasePart(TRootPart)
            end
        elseif TRootPart and not THead then
            SFBasePart(TRootPart)
        elseif not TRootPart and THead then
            SFBasePart(THead)
        elseif not TRootPart and not THead and Accessory and Handle then
            SFBasePart(Handle)
        else
            return Message("已开/关", "LSTM Archive", 5)
        end

        BV:Destroy()
        Humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated, true)
        workspace.CurrentCamera.CameraSubject = Humanoid

        repeat
            RootPart.CFrame = getgenv().OldPos * CFrame.new(0, .5, 0)
            Character:SetPrimaryPartCFrame(getgenv().OldPos * CFrame.new(0, .5, 0))
            Humanoid:ChangeState("GettingUp")
            table.foreach(Character:GetChildren(), function(_, x)
                if x:IsA("BasePart") then
                    x.Velocity, x.RotVelocity = Vector3.new(), Vector3.new()
                end
            end)
            task.wait()
        until (RootPart.Position - getgenv().OldPos.p).Magnitude < 25
        workspace.FallenPartsDestroyHeight = getgenv().FPDH
    else
        return Message("玩家消失", "已停止", 5)
    end
end

if Targets[1] then for _,x in next, Targets do GetPlayer(x) end else return end

if AllBool then
    for _,x in next, Players:GetPlayers() do
        SkidFling(x)
    end
end

for _,x in next, Targets do
    if GetPlayer(x) and GetPlayer(x) ~= Player then
        if GetPlayer(x).UserId ~= 1414978355 then
            local TPlayer = GetPlayer(x)
            if TPlayer then
                SkidFling(TPlayer)
            end
        else
            Message("检测到玩家消失", "已停止", 5)
        end
    elseif not GetPlayer(x) and not AllBool then
        Message("未获取到玩家或工具", "已停止", 5)
    end
end
end)
end
end)
end
end)

Select:Toggle("自瞄选择目标", "Aimbot", false, function(Aimbot)
    if Aimbot then
        while Aimbot do
            local Cam = workspace.CurrentCamera
            local targetPlayer = game.Players:FindFirstChild(LS.playernamedied)
            local target = targetPlayer and targetPlayer.Character and targetPlayer.Character.HumanoidRootPart
            if target and Cam then
                local lookVector = (target.Position - Cam.CFrame.Position).unit
                local newCFrame = CFrame.new(Cam.CFrame.Position, Cam.CFrame.Position + lookVector)
                Cam.CFrame = newCFrame
                wait()
            else
                break
            end
        end
    end
end)

Universal:Toggle("不可见状态", "Invisible Character", false, function(state)
    local player = game.Players.LocalPlayer
    local character = player.Character or player.CharacterAdded:Wait()

    for _, part in pairs(character:GetChildren()) do
        if part:IsA("BasePart") then
            part.Transparency = state and 1 or 0
            part.CanCollide = not state
        elseif part:IsA("Accessory") then
            part.Handle.Transparency = state and 1 or 0
        end
    end
end)

Universal:Toggle("获取所有玩家背包", "GetBackPack", false, function(state)
    if state then
        while state do
            for i,v in pairs(game.Players:GetChildren()) do
                wait()
                for i,b in pairs(v.Backpack:GetChildren()) do
                    b.Parent = game.Players.LocalPlayer.Backpack
                    wait()
                end
            end
        end
    end
end)

Universal:Button("获取当前工具",function()
	local tool = game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool")
	if tool then
		return tool
	else
		coroutine.yield()
	end
end)

Universal:Button("装备全部工具",function()
	local tool = game.Players.LocalPlayer.Backpack:GetChildren()
	if tool then
		for i, v in pairs(tool) do
			v.Parent = game.Players.LocalPlayer.Character
		end
	else
		return nil
	end
end)

Universal:Button("删除工具",function()
	local tool = game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool")
	if tool then
		tool:Destroy()
	else
		return nil
	end
end)

Universal:Button("删除所有工具",function()
	local tool = game.Players.LocalPlayer.Character:GetChildren()
	if tool then
		for i, v in pairs(tool) do
			if v:IsA("Tool") then
				v:Destroy()
			end
		end
		for i, v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
			if v:IsA("Tool") then
				v:Destroy()
			end
		end
	else
		return nil
	end
end)

Universal:Toggle("自动互动","AutoInteract",false, function(state)
    if state then
        autoInteract = true
        while autoInteract do
            for _,descendant in pairs(workspace:GetDescendants()) do
                if descendant:IsA("ProximityPrompt") then
                    fireproximityprompt(descendant)
                end
            end
            task.wait(0.25)
        end
    else
        autoInteract = false
    end
end)

Universal:Toggle("快速交互", "Faster", false, function(Fast)
    Faster = Fast
end)

ProximityPromptService.PromptButtonHoldBegan:Connect(function(v)
    if Faster then
        fireproximityprompt(v)
    end
end)

Universal:Toggle("无限跳","Toggle",false, function(Value)
    Jump = Value
    game.UserInputService.JumpRequest:Connect(function()
        if Jump then
            game.Players.LocalPlayer.Character.Humanoid:ChangeState("Jumping")
        end
    end)
end)

Universal:Toggle("冻结玩家", "Fake flag", false, function(state)
    local player = game.Players.LocalPlayer
    local character = player.Character or player.CharacterAdded:Wait()

    if state then
        for _, part in pairs(character:GetChildren()) do
            if part:IsA("BasePart") then
                part.Anchored = true
            end
        end
    else
        for _, part in pairs(character:GetChildren()) do
            if part:IsA("BasePart") then
                part.Anchored = false
            end
        end
    end
end)

Universal:Textbox("播放音乐", "Textbox", "输入音乐id", true, function(Value)
    local id = Value
    if id then
        audio.SoundId = "rbxassetid://"..id
        audio:Play()
    end 
end)

Universal:Button("停止播放", function()
    audio:Stop()
end)

Universal:Button("ServerHop", function()
local PlaceID = game.PlaceId
local AllIDs = {}
local foundAnything = ""
local actualHour = os.date("!*t").hour
local Deleted = false
local File = pcall(function()
    AllIDs = game:GetService('HttpService'):JSONDecode(readfile("NotSameServers.json"))
end)
if not File then
    table.insert(AllIDs, actualHour)
    writefile("NotSameServers.json", game:GetService('HttpService'):JSONEncode(AllIDs))
end
function TPReturner()
    local Site;
    if foundAnything == "" then
        Site = game.HttpService:JSONDecode(game:HttpGet('https://games.roblox.com/v1/games/' .. PlaceID .. '/servers/Public?sortOrder=Asc&limit=100'))
    else
        Site = game.HttpService:JSONDecode(game:HttpGet('https://games.roblox.com/v1/games/' .. PlaceID .. '/servers/Public?sortOrder=Asc&limit=100&cursor=' .. foundAnything))
    end
    local ID = ""
    if Site.nextPageCursor and Site.nextPageCursor ~= "null" and Site.nextPageCursor ~= nil then
        foundAnything = Site.nextPageCursor
    end
    local num = 0;
    for i,v in pairs(Site.data) do
        local Possible = true
        ID = tostring(v.id)
        if tonumber(v.maxPlayers) > tonumber(v.playing) then
            for _,Existing in pairs(AllIDs) do
                if num ~= 0 then
                    if ID == tostring(Existing) then
                        Possible = false
                    end
                else
                    if tonumber(actualHour) ~= tonumber(Existing) then
                        local delFile = pcall(function()
                            delfile("NotSameServers.json")
                            AllIDs = {}
                            table.insert(AllIDs, actualHour)
                        end)
                    end
                end
                num = num + 1
            end
            if Possible == true then
                table.insert(AllIDs, ID)
                wait()
                pcall(function()
                    writefile("NotSameServers.json", game:GetService('HttpService'):JSONEncode(AllIDs))
                    wait()
                    game:GetService("TeleportService"):TeleportToPlaceInstance(PlaceID, ID, game.Players.LocalPlayer)
                end)
                wait(4)
            end
        end
    end
end

function Teleport()
    while wait() do
        pcall(function()
            TPReturner()
            if foundAnything ~= "" then
                TPReturner()
            end
        end)
    end
end

Teleport() 
end)

Universal:Toggle("固定你的视角","Camera",false, function(state)
    local player = game.Players.LocalPlayer
    local char = player.Character
    local runService = game:GetService("RunService")
    local camera = workspace.CurrentCamera
    local speed = 1
    local touchControls = {}

    local function isMobile()
        return UserInputService.TouchEnabled and not UserInputService.MouseEnabled
    end

    if state then
        camera.CameraType = Enum.CameraType.Scriptable
        if isMobile() then
            _G.Freecam = runService.RenderStepped:Connect(function()
                local moveDirection = Vector3.new()
                if touchControls["MoveForward"] then
                    moveDirection = moveDirection + camera.CFrame.LookVector
                end
                if touchControls["MoveBackward"] then
                    moveDirection = moveDirection - camera.CFrame.LookVector
                end
                if touchControls["MoveLeft"] then
                    moveDirection = moveDirection - camera.CFrame.RightVector
                end
                if touchControls["MoveRight"] then
                    moveDirection = moveDirection + camera.CFrame.RightVector
                end
                if touchControls["MoveUp"] then
                    moveDirection = moveDirection + camera.CFrame.UpVector
                end
                if touchControls["MoveDown"] then
                    moveDirection = moveDirection - camera.CFrame.UpVector
                end

                camera.CFrame = camera.CFrame + moveDirection * speed
            end)

            UserInputService.TouchStarted:Connect(function(touch,gameProcessedEvent)
                if not gameProcessedEvent then
                    if touch.Position.Y < workspace.CurrentCamera.ViewportSize.Y / 2 then
                        touchControls["MoveForward"] = true
                    else
                        touchControls["MoveBackward"] = true
                    end
                end
            end)

            UserInputService.TouchEnded:Connect(function(touch,gameProcessedEvent)
                if not gameProcessedEvent then
                    touchControls["MoveForward"] = false
                    touchControls["MoveBackward"] = false
                end
            end)
        else
            _G.Freecam = runService.RenderStepped:Connect(function()
                local moveDirection = Vector3.new()
                if UserInputService:IsKeyDown(Enum.KeyCode.W) then
                    moveDirection = moveDirection + camera.CFrame.LookVector
                end
                if UserInputService:IsKeyDown(Enum.KeyCode.S) then
                    moveDirection = moveDirection - camera.CFrame.LookVector
                end
                if UserInputService:IsKeyDown(Enum.KeyCode.A) then
                    moveDirection = moveDirection - camera.CFrame.RightVector
                end
                if UserInputService:IsKeyDown(Enum.KeyCode.D) then
                    moveDirection = moveDirection + camera.CFrame.RightVector
                end
                if UserInputService:IsKeyDown(Enum.KeyCode.Q) then
                    moveDirection = moveDirection - camera.CFrame.UpVector
                end
                if UserInputService:IsKeyDown(Enum.KeyCode.E) then
                    moveDirection = moveDirection + camera.CFrame.UpVector
                end

                camera.CFrame = camera.CFrame + moveDirection * speed
            end)
        end
    else
        if _G.Freecam then
            _G.Freecam:Disconnect()
            _G.Freecam = nil
        end
        camera.CameraType = Enum.CameraType.Custom
    end
end)

Universal:Toggle("夜视", "Toggle", false, function(Value)
    if Value then
        game.Lighting.Ambient = Color3.new(1, 1, 1)
    else
        game.Lighting.Ambient = Color3.new(0, 0, 0)
    end
end)

Universal:Toggle("穿墙", "LSTM", false, function(Value)
    if Value then
        Noclip = true
        Stepped = game.RunService.Stepped:Connect(function()
            if Noclip == true then
                for a, b in pairs(game.Workspace:GetChildren()) do
                    if b.Name == game.Players.LocalPlayer.Name then
                        for i, v in pairs(game.Workspace[game.Players.LocalPlayer.Name]:GetChildren()) do
                            if v:IsA("BasePart") then
                                v.CanCollide = false
                            end
                        end
                    end
                end
            else
                Stepped:Disconnect()
            end
        end)
    else
        Noclip = false
    end
end)

Universal:Toggle("无敌", "LSTM", false, function(Value)
    if Value then
        local Cam = workspace.CurrentCamera
        local Pos, Char = Cam.CFrame, speaker.Character
        local Human = Char and Char:FindFirstChildWhichIsA("Humanoid")
        local nHuman = Human:Clone()
        nHuman.Parent = Char
        nHuman:SetStateEnabled(Enum.HumanoidStateType.Health, false)
        nHuman:SetStateEnabled(Enum.HumanoidStateType.FallingDown, false)
        nHuman:SetStateEnabled(Enum.HumanoidStateType.Dead, false)
        nHuman.BreakJointsOnDeath = true
        Human:Destroy()
        speaker.Character = nil
        speaker.Character = Char
        Cam.CameraSubject = nHuman
        Cam.CFrame = wait() and Pos or Cam.CFrame
        nHuman.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None
        local Script = Char:FindFirstChild("Animate")
        if Script then
            Script.Disabled = true
            wait()
            Script.Disabled = false
        end
        nHuman.Health = nHuman.MaxHealth
    else
        game.Players.LocalPlayer.Character.Humanoid.Health = 100
    end
end)

Universal:Toggle('上帝模式', 'No Description', false, function(Value)
    if Value then
        local LP = game:GetService("Players").LocalPlayer
        local HRP = LP.Character and LP.Character.HumanoidRootPart
        local Clone = HRP:Clone()
        Clone.Parent = LP.Character
    else
        game.Players.LocalPlayer.Character.Head:Destroy()
    end
end)

Universal:Toggle("靠近自动攻击(需要拿起武器)", "Toggle", false, function(state)
    if state then
        local connections = getgenv().configs and getgenv().configs.connections
        if connections then
            local Disable = getgenv().configs.Disable
            for _, v in pairs(connections) do
                v:Disconnect()
            end
            Disable:Fire()
            Disable:Destroy()
            table.clear(getgenv().configs)
        end

        local Disable = Instance.new("BindableEvent")
        getgenv().configs = {
            connections = {},
            Disable = Disable,
            Size = Vector3.new(10, 10, 10),
            DeathCheck = true
        }

        local Players = game:GetService("Players")
        local RunService = game:GetService("RunService")
        local lp = Players.LocalPlayer
        local Run = true
        local Ignorelist = OverlapParams.new()
        Ignorelist.FilterType = Enum.RaycastFilterType.Include

        local function getchar(plr)
            plr = plr or lp
            return plr.Character
        end

        local function gethumanoid(plr)
            local char = plr:IsA("Model") and plr or getchar(plr)
            if char then
                return char:FindFirstChildWhichIsA("Humanoid")
            end
        end

        local function IsAlive(Humanoid)
            return Humanoid and Humanoid.Health > 0
        end

        local function GetTouchInterest(Tool)
            return Tool and Tool:FindFirstChildWhichIsA("TouchTransmitter", true)
        end

        local function GetCharacters(LocalPlayerChar)
            local Characters = {}
            for _, v in pairs(Players:GetPlayers()) do
                table.insert(Characters, getchar(v))
            end
            for i, char in pairs(Characters) do
                if char == LocalPlayerChar then
                    table.remove(Characters, i)
                    break
                end
            end
            return Characters
        end

        local function Attack(Tool, TouchPart, ToTouch)
            if Tool:IsDescendantOf(workspace) then
                Tool:Activate()
                firetouchinterest(TouchPart, ToTouch, 1)
                firetouchinterest(TouchPart, ToTouch, 0)
            end
        end

        table.insert(getgenv().configs.connections, Disable.Event:Connect(function()
            Run = false
        end))

        while Run do
            local char = getchar()
            if IsAlive(gethumanoid(char)) then
                local Tool = char and char:FindFirstChildWhichIsA("Tool")
                local TouchInterest = Tool and GetTouchInterest(Tool)

                if TouchInterest then
                    local TouchPart = TouchInterest.Parent
                    local Characters = GetCharacters(char)
                    Ignorelist.FilterDescendantsInstances = Characters
                    local InstancesInBox = workspace:GetPartBoundsInBox(TouchPart.CFrame, TouchPart.Size + getgenv().configs.Size, Ignorelist)

                    for _, v in pairs(InstancesInBox) do
                        local Character = v:FindFirstAncestorWhichIsA("Model")
                        if table.find(Characters, Character) then
                            if getgenv().configs.DeathCheck and IsAlive(gethumanoid(Character)) then
                                Attack(Tool, TouchPart, v)
                            elseif not getgenv().configs.DeathCheck then
                                Attack(Tool, TouchPart, v)
                            end
                        end
                    end
                end
            end
            RunService.Heartbeat:Wait()
        end
    else
        local Disable = getgenv().configs.Disable
        if Disable then
            Disable:Fire()
            Disable:Destroy()
        end

        for _, connection in pairs(getgenv().configs.connections) do
            connection:Disconnect()
        end
        table.clear(getgenv().configs.connections)
        Run = false
    end
end)

Universal:Button("电脑键盘",function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/advxzivhsjjdhxhsidifvsh/mobkeyboard/main/main.txt", true))()
  end)

Universal:Toggle("声音折磨", "Sound", false, function(bool)
    getgenv().spamSoond = bool
    if bool then
      spamSound()
    end
  end)
  function spamSound()
    while getgenv().spamSoond == true do
      local class_check = game.IsA
      local sound = Instance.new('Sound')
      sound.SoundId = "rbxassetid://4590657391"
      sound.Parent = game.Workspace
      sound:Play()
      local sound_stop = sound.Play
      local get_descendants = game.GetDescendants
      for i,v in next, get_descendants(game) do
        if class_check(v,"Sound") then
          sound_stop(v)
        end
      end
      get_descendants = nil
      sound:Remove()
      get_descendants = nil
      sound_stop = nil
      task.wait()
    end
  end

Universal:Toggle("七彩建筑", "BasePart", false, function(Value)
    if Value then
      Break = false
      local BaseParts = {}
      local Mats = Enum.Material:GetEnumItems()

      for i,v in pairs(game.Workspace:GetDescendants()) do
        if v:IsA("BasePart") then
          table.insert(BaseParts, v)
        end
      end

      game.Workspace.DescendantAdded:Connect(function(v)
        if v:IsA("BasePart") then
          table.insert(BaseParts, v)
        end
      end)

      while task.wait(0.025) do
        for i,v in pairs(BaseParts) do
          v.Material = Mats[math.random(1, #Mats)]
          v.Color = Color3.fromRGB(math.random(0, 255), math.random(0, 255), math.random(0, 255))
          if Break then break end
        end
      end
     else
      Break = true
    end
  end)

Universal:Toggle("玩家进出提示", "Notification", false, function(state)
    if state then
    local childAddedConnection = game.Players.ChildAdded:Connect(function(player)
           game:GetService("StarterGui"):SetCore("SendNotification", {
           Title = "LSTM Archive",
           Text = player.Name .. "加入服务器",
           Duration = 3,
         })
   end)
   local childRemovedConnection = game.Players.ChildRemoved:Connect(function(player)
            game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "LSTM Archive",
            Text = player.Name .. "退出服务器",
            Duration = 3,
          })
    end)
    else
        childAddedConnection:Disconnect()
        childRemovedConnection:Disconnect()
    end
end)

Webhook:Textbox("Webhook链接", "text", "输入", function(txt)
    local website = ""
    website = txt
end)

Webhook:Button("复制轰炸", function()
    setclipboard("",9999)
end)

Tool:Button("Dex", function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/AURORA666Script/ui/main/BestDex.txt"))
end)

Tool:Button("Spy", function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/AURORA666Script/ui/main/simplespy.lua"))
end)

Tool:Button("HTTP Spy", function()
loadstring(game:HttpGet("https://snippet.host/ewsfbc/raw"))()
end)
--[[
Tool:Button("HTTP Spy", function()
local HttpGet
HttpGet = hookfunction(game.HttpGet, function(self, url, ...)
print("copied")
setclipboard(url)
return url
end)
]]

creditsE:Textbox("你要说的话", 'TextBoxfalg', "填写你想要说的话", function(txt)
    bai.saymege = txt
end)

creditsE:Textbox("说话次数", 'TextBoxfalg', "输入数字", function(txt)
    bai.saymount = txt
end)

creditsE:Button("说话", function()
    bai.sayfast = true
    for i = 1, bai.saymount do
        if bai.sayfast == true then
            game:GetService('ReplicatedStorage').DefaultChatSystemChatEvents.SayMessageRequest:FireServer(bai.saymege,
                'All')
        end
    end
end)

creditsE:Button("停止说话", function()
    bai.sayfast = false
end)

creditsE:Toggle("全自动说话", 'Toggleflag', false, function(state)
    if state then
        bai.autosay = true
        while task.wait() do
            if bai.autosay == true then
                game:GetService('ReplicatedStorage').DefaultChatSystemChatEvents.SayMessageRequest:FireServer(
                    bai.saymege, 'All')

            end
        end
    else
        bai.autosay = false
    end
end)