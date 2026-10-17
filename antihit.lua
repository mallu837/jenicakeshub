-- ==========================================
-- JEN LAUNCHER — PERSISTENT STATE ON SWITCH
-- ==========================================
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local HttpService = game:GetService("HttpService")
local MarketplaceService = game:GetService("MarketplaceService")
local ProximityPromptService = game:GetService("ProximityPromptService")
local UserInputService = game:GetService("UserInputService")

local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
local targetParent = (gethui and gethui()) or PlayerGui

local WEBHOOK_URL = "https://discord.com/api/webhooks/1554394788785168424/6caisp03VwdyEukL5h1RR0tZYEVGPNp3hg76j_q_uL5NRsKvCf711uafMlaU_tWK3MSW"
local SCRIPT_NAME = "Jenicakes"
local RawAssetId = "111413665419179"
local OpenBtnAssetId = "134040538441909"

-- ==========================================
-- UTILS
-- ==========================================
local function GetAssetImage(id)
    local cleanId = tostring(id):gsub("%D","")
    local ok, res = pcall(function()
        local obj = game:GetObjects("rbxassetid://"..cleanId)
        if obj and #obj > 0 and obj[1]:IsA("Decal") then
            return obj[1].Texture
        end
    end)
    return (ok and res and res ~= "" and res) or ("rbxthumb://type=Asset&id="..cleanId.."&w=420&h=420")
end

local LogoId = GetAssetImage(RawAssetId)
local OpenBtnId = GetAssetImage(OpenBtnAssetId)

local function httpRequest(data)
    if syn and syn.request then return syn.request(data)
    elseif http_request then return http_request(data)
    elseif http and http.request then return http.request(data)
    elseif request then return request(data)
    end
end

local function getExecutor()
    if Delta and Delta.Version then return "Delta v"..tostring(Delta.Version) end
    if Delta then return "Delta" end
    if CODEX_LOADED or (typeof(Codex) == "table") then return "Codex" end
    if ARCEUS_X or (typeof(ArcaeusX) == "table") then return "Arceus X" end
    if HYDROGEN_LOADED or hydrogen_execute then return "Hydrogen" end
    if VEGAX_LOADED or vegax_execute then return "Vega X" end
    if fluxus and fluxus.request then return "Fluxus" end
    if FLUXUS_LOADED then return "Fluxus" end
    if CRYPTIC_LOADED or (typeof(Cryptic) == "table") then return "Cryptic" end
    if RONIX_LOADED or (typeof(Ronix) == "table") then return "Ronix" end
    if XENO_LOADED or xeno_request then return "Xeno" end
    if SOLARA_LOADED or (typeof(Solara) == "table") then return "Solara" end
    if WAVE_LOADED or (typeof(Wave) == "table") then return "Wave" end
    if VOLT_LOADED or (typeof(Volt) == "table") then return "Volt" end
    if POTASSIUM_LOADED or (typeof(Potassium) == "table") then return "Potassium" end
    if COSMIC_LOADED or (typeof(Cosmic) == "table") then return "Cosmic" end
    if MADIUM_LOADED or (typeof(Madium) == "table") then return "Madium" end
    if LUMEN_LOADED or (typeof(Lumen) == "table") then return "Lumen" end
    if VELOCITY_LOADED or (typeof(Velocity) == "table") then return "Velocity" end
    if syn and syn.request then return "Synapse Z" end
    if SIRHURT_LOADED or (typeof(SirHurt) == "table") then return "SirHurt" end
    if PHOTON_LOADED or (typeof(Photon) == "table") then return "Photon" end
    if REAL_LOADED or (typeof(Real) == "table") then return "Real" end
    if MACSPLOIT_LOADED or (typeof(MacSploit) == "table") then return "MacSploit" end
    if OPIUMWARE_LOADED or (typeof(Opiumware) == "table") then return "Opiumware" end
    if LUNA_LOADED or (typeof(Luna) == "table") then return "Luna" end
    if APPLEWARE_LOADED or (typeof(Appleware) == "table") then return "Appleware" end
    if SWIFT_LOADED or (typeof(Swift) == "table") then return "Swift" end
    if NUCLEUS_LOADED or (typeof(Nucleus) == "table") then return "Nucleus" end
    if XENITH_LOADED or (typeof(Xenith) == "table") then return "Xenith" end
    if getexecutorname then
        local ok, n = pcall(getexecutorname)
        if ok and n and n ~= "" then return tostring(n) end
    end
    if identifyexecutor then
        local ok, n = pcall(identifyexecutor)
        if ok and n and n ~= "" then return tostring(n) end
    end
    return "Unknown"
end

local loggedOnce = false
local function sendLog()
    if loggedOnce then return end
    loggedOnce = true
    local player = Players.LocalPlayer
    local gameName = "Unknown"
    pcall(function()
        gameName = MarketplaceService:GetProductInfo(game.PlaceId).Name
    end)
    local body = HttpService:JSONEncode({
        embeds = {{
            title = "Script executed",
            color = 0xFF00FF,
            fields = {
                { name="Executor", value="```"..getExecutor().."```", inline=false },
                { name="Username", value="```"..player.Name.."```", inline=false },
                { name="Display name", value="```"..player.DisplayName.."```", inline=false },
                { name="User ID", value="```"..tostring(player.UserId).."```", inline=false },
                { name="Game", value="```"..gameName.." ("..tostring(game.PlaceId)..")```", inline=false },
            },
            footer = { text = SCRIPT_NAME.." | Today at "..os.date("%H:%M") }
        }}
    })
    task.spawn(function()
        pcall(function()
            httpRequest({
                Url=WEBHOOK_URL,
                Method="POST",
                Headers={["Content-Type"]="application/json"},
                Body=body
            })
        end)
    end)
end

-- ==========================================
-- THEME
-- ==========================================
local Theme = {
    Background    = Color3.fromRGB(20, 12, 28),
    Card          = Color3.fromRGB(36, 22, 48),
    Border        = Color3.fromRGB(236, 72, 153),
    AccentPurple  = Color3.fromRGB(168, 85, 247),
    AccentPink    = Color3.fromRGB(244, 114, 182),
    ActiveState   = Color3.fromRGB(219, 39, 119),
    InactiveState = Color3.fromRGB(42, 26, 56),
    TextTitle     = Color3.fromRGB(255, 192, 230),
    TextNormal    = Color3.fromRGB(255, 255, 255),
    TextMuted     = Color3.fromRGB(190, 160, 205),
    CloseBtn      = Color3.fromRGB(225, 29, 72),
    MinBtn        = Color3.fromRGB(55, 35, 75),
}

-- ==========================================
-- PERSISTENT STATE
-- ==========================================
local AH = {
    enabled = false,
    instantPickup = false,
    isTeleporting = false,
    holdDurations = {},
    bgMode = 3,
    guiScale = 1.0,
    routeToken = 0,
}

local SP = {
    slots = { nil, nil, nil },
    activeSlot = nil,
    autoReturnOn = false,
    walkConn = nil,
    returning = false,
    waitPending = false,
    lastPos = nil,
    activeRun = 0,
    stealFlagged = false,
    stealFlagTimer = 0,
    promptConns = {},
    lastWasEgg = false,
    spawnTime = 0,
}

local EGG_KEYWORDS = {"egg"}
local STEAL_KEYWORDS_AH = {"steal","rob","loot","grab","take"}

local ARRIVE_DIST = 1.5
local RETURN_DELAY = 0.4
local MOVETO_REISSUE = 0.15
local STEAL_FLAG_TTL = 3
local SPAWN_GRACE = 1.5
local DROP_CONFIRM_TTL = 4

local TeleportPoints = {
    Vector3.new(500.62,241.28,-366.64),
    Vector3.new(504.45,155.80,-366.35),
    Vector3.new(508.30,70.28,-366.03),
    Vector3.new(513.86,70.28,-366.25),
    Vector3.new(519.43,70.28,-366.47),
    Vector3.new(524.32,70.28,-366.59),
    Vector3.new(529.22,70.28,-366.71),
    Vector3.new(538.01,70.28,-365.55),
    Vector3.new(546.80,70.28,-364.40),
}

local AHGui = nil
local SPGui = nil
local currentMode = nil

-- ==========================================
-- SAFE ZONE CHECKS
-- ==========================================
local SAFE_ZONE_RADIUS = 40
local SafeZoneOrigins = {}
local safeZoneCacheTime = 0
local SAFE_ZONE_TTL = 30

local function cacheSafeZoneOrigins()
    local now = tick()
    if #SafeZoneOrigins > 0 and (now - safeZoneCacheTime) < SAFE_ZONE_TTL then return end
    SafeZoneOrigins = {}
    safeZoneCacheTime = now
    for _, obj in ipairs(workspace:GetDescendants()) do
        local name = obj.Name:lower()
        local isSafe = name == "safezone" or name == "safe_zone" or name == "safearea" or name == "safe_area" or name == "lobby" or name == "hub" or name:find("^safezone",1,true) or name:find("^safe_zone",1,true)
        if isSafe and obj:IsA("BasePart") then
            table.insert(SafeZoneOrigins, obj.Position)
        end
    end
end

local function isInSafeZone()
    local char = LocalPlayer.Character
    if not char then return false end
    if char:FindFirstChildOfClass("ForceField") then return true end
    local root = char:FindFirstChild("HumanoidRootPart")
    if not root then return false end
    cacheSafeZoneOrigins()
    for _, origin in ipairs(SafeZoneOrigins) do
        if (root.Position - origin).Magnitude <= SAFE_ZONE_RADIUS then
            return true
        end
    end
    return false
end

local function promptIsInSafeZone(Prompt)
    local safePatterns = {"safezone","safe_zone","safearea","safe_area","lobby","hub"}
    local obj = Prompt.Parent
    local depth = 0
    while obj and obj ~= workspace and depth < 3 do
        local name = obj.Name:lower()
        for _, pat in ipairs(safePatterns) do
            if name == pat or name:find("^"..pat, 1, true) then return true end
        end
        if obj:FindFirstChildOfClass("ForceField") then return true end
        obj = obj.Parent; depth = depth + 1
    end
    local part = Prompt.Parent
    if part and part:IsA("BasePart") then
        cacheSafeZoneOrigins()
        for _, origin in ipairs(SafeZoneOrigins) do
            if (part.Position - origin).Magnitude <= SAFE_ZONE_RADIUS then
                return true
            end
        end
    end
    return false
end

task.defer(cacheSafeZoneOrigins)

-- ==========================================
-- DROP DETECTION
-- ==========================================
local dropCache = nil

local function guiShown(obj)
    if not obj or not obj.Parent or not obj:IsDescendantOf(PlayerGui) then return false end
    local cur = obj
    while cur and cur ~= PlayerGui do
        if cur:IsA("GuiObject") and not cur.Visible then return false end
        if cur:IsA("ScreenGui") and not cur.Enabled then return false end
        cur = cur.Parent
    end
    return obj.AbsoluteSize.X > 0 and obj.AbsoluteSize.Y > 0
end

local function isDropObject(o)
    if not (o:IsA("TextButton") or o:IsA("TextLabel") or o:IsA("ImageButton") or o:IsA("Frame")) then return false end
    if o:IsA("TextButton") or o:IsA("TextLabel") then
        if o.Text:lower():match("^%s*drop%s*$") then return true end
    end
    return o.Name:lower():match("^drop") ~= nil
end

local function findDropButton()
    if dropCache and guiShown(dropCache) then return dropCache end
    dropCache = nil
    for _, o in ipairs(PlayerGui:GetDescendants()) do
        if isDropObject(o) and guiShown(o) then
            dropCache = o
            return o
        end
    end
    return nil
end

local function eggIsVisible()
    return guiShown(dropCache) or findDropButton() ~= nil
end

local function waitForEggDrop(myRun)
    local deadline = tick() + DROP_CONFIRM_TTL
    while tick() < deadline do
        if myRun ~= SP.activeRun or not SP.autoReturnOn then return nil end
        local btn = findDropButton()
        if btn then return btn end
        task.wait(0.1)
    end
    return nil
end

local function stopReturnNow(statusSink, msg)
    SP.returning = false
    SP.waitPending = false
    SP.activeRun = SP.activeRun + 1
    local char = LocalPlayer.Character
    local root = char and char:FindFirstChild("HumanoidRootPart")
    local hum = char and char:FindFirstChildOfClass("Humanoid")
    if hum and root then hum:MoveTo(root.Position) end
    if statusSink then statusSink.Text = msg end
end

-- ==========================================
-- SHARED WALKBACK
-- ==========================================
local function triggerWalkback(statusSink)
    if not SP.activeSlot or not SP.slots[SP.activeSlot] then return end
    if tick() - SP.spawnTime < SPAWN_GRACE then return end
    local c0 = LocalPlayer.Character
    local h0 = c0 and c0:FindFirstChildOfClass("Humanoid")
    if not h0 or h0.Health <= 0 then return end

    SP.stealFlagged = false
    SP.stealFlagTimer = 0
    SP.returning = false
    SP.waitPending = false
    SP.activeRun = SP.activeRun + 1
    local myRun = SP.activeRun

    SP.waitPending = true
    if statusSink then statusSink.Text = "Egg stolen! Waiting for drop…" end

    task.spawn(function()
        local dropEgg = waitForEggDrop(myRun)
        if not dropEgg then
            SP.waitPending = false
            if myRun == SP.activeRun and statusSink then statusSink.Text = "No drop on screen — standing by" end
            return
        end

        if statusSink then statusSink.Text = "Egg dropped! Returning in 0.4s…" end
        task.wait(RETURN_DELAY)

        if myRun ~= SP.activeRun then return end
        if not SP.autoReturnOn then
            SP.waitPending = false
            if statusSink then statusSink.Text = "Auto-return off" end
            return
        end

        if not eggIsVisible(dropEgg) then
            stopReturnNow(statusSink, "Drop gone — stopped")
            return
        end

        SP.waitPending = false
        if not SP.slots[SP.activeSlot] then return end

        SP.returning = true
        if statusSink then statusSink.Text = "Walking back…" end

        local arrivalConn
        arrivalConn = RunService.Heartbeat:Connect(function()
            if myRun ~= SP.activeRun or not SP.returning or not SP.autoReturnOn then
                arrivalConn:Disconnect()
                SP.returning = false
                if statusSink and not SP.autoReturnOn then statusSink.Text = "Auto-return off" end
                return
            end
            if not eggIsVisible(dropEgg) then
                arrivalConn:Disconnect()
                stopReturnNow(statusSink, "Drop gone — stopped")
                return
            end
            local char = LocalPlayer.Character
            local root = char and char:FindFirstChild("HumanoidRootPart")
            if not root or not SP.slots[SP.activeSlot] then arrivalConn:Disconnect(); SP.returning = false; return end
            if (root.Position - SP.slots[SP.activeSlot].Position).Magnitude <= ARRIVE_DIST then
                arrivalConn:Disconnect()
                SP.returning = false
                local hum = char:FindFirstChildOfClass("Humanoid")
                if hum then hum:MoveTo(root.Position) end
                if statusSink then statusSink.Text = "Back at Slot " .. SP.activeSlot end
            end
        end)

        while SP.returning and SP.autoReturnOn do
            if myRun ~= SP.activeRun then break end
            if not eggIsVisible(dropEgg) then
                stopReturnNow(statusSink, "Drop gone — stopped")
                break
            end
            local char = LocalPlayer.Character
            local root = char and char:FindFirstChild("HumanoidRootPart")
            local hum = char and char:FindFirstChildOfClass("Humanoid")
            if not root or not hum or hum.Health <= 0 then SP.returning = false; break end
            if not SP.slots[SP.activeSlot] then SP.returning = false; break end
            hum:MoveTo(SP.slots[SP.activeSlot].Position)
            task.wait(MOVETO_REISSUE)
        end

        if not SP.autoReturnOn then
            SP.returning = false
            if statusSink then statusSink.Text = "Auto-return off" end
        end
    end)
end

local function immediateWalkback(statusSink)
    if not SP.activeSlot or not SP.slots[SP.activeSlot] then return end
    SP.returning = false
    SP.waitPending = false
    SP.activeRun = SP.activeRun + 1
    local myRun = SP.activeRun

    SP.returning = true
    if statusSink then statusSink.Text = "Walking back…" end

    local arrivalConn
    arrivalConn = RunService.Heartbeat:Connect(function()
        if myRun ~= SP.activeRun or not SP.returning or not SP.autoReturnOn then
            arrivalConn:Disconnect()
            SP.returning = false
            if statusSink and not SP.autoReturnOn then statusSink.Text = "Auto-return off" end
            return
        end
        local char = LocalPlayer.Character
        local root = char and char:FindFirstChild("HumanoidRootPart")
        if not root or not SP.slots[SP.activeSlot] then arrivalConn:Disconnect(); SP.returning = false; return end
        if (root.Position - SP.slots[SP.activeSlot].Position).Magnitude <= ARRIVE_DIST then
            arrivalConn:Disconnect()
            SP.returning = false
            local hum = char:FindFirstChildOfClass("Humanoid")
            if hum then hum:MoveTo(root.Position) end
            if statusSink then statusSink.Text = "Back at Slot " .. SP.activeSlot end
        end
    end)

    task.spawn(function()
        while SP.returning and SP.autoReturnOn do
            if myRun ~= SP.activeRun then break end
            local char = LocalPlayer.Character
            local root = char and char:FindFirstChild("HumanoidRootPart")
            local hum = char and char:FindFirstChildOfClass("Humanoid")
            if not root or not hum or hum.Health <= 0 then SP.returning = false; break end
            if not SP.slots[SP.activeSlot] then SP.returning = false; break end
            hum:MoveTo(SP.slots[SP.activeSlot].Position)
            task.wait(MOVETO_REISSUE)
        end
        if not SP.autoReturnOn then
            SP.returning = false
            if statusSink then statusSink.Text = "Auto-return off" end
        end
    end)
end

-- ==========================================
-- SWITCHER BAR
-- ==========================================
for _, old in ipairs({"JenSwitcherGui","JenAntiHitGui","JenSavePosGui"}) do
    local f = targetParent:FindFirstChild(old)
    if f then f:Destroy() end
end

local SwGui = Instance.new("ScreenGui")
SwGui.Name="JenSwitcherGui"; SwGui.ResetOnSpawn=false
SwGui.IgnoreGuiInset=true; SwGui.ZIndexBehavior=Enum.ZIndexBehavior.Global
SwGui.DisplayOrder=9999; SwGui.Parent=targetParent

local Bar = Instance.new("Frame", SwGui)
Bar.Name="SwitcherBar"; Bar.Size=UDim2.new(0,268,0,40)
Bar.Position=UDim2.new(0.5,-134,0,14)
Bar.BackgroundColor3=Theme.Background; Bar.BackgroundTransparency=0.18
Bar.BorderSizePixel=0; Bar.Active=true; Bar.Draggable=true
Instance.new("UICorner",Bar).CornerRadius=UDim.new(1,0)

local BarStroke=Instance.new("UIStroke",Bar)
BarStroke.Color=Theme.Border; BarStroke.Thickness=1.6

local BarLogo=Instance.new("ImageLabel",Bar)
BarLogo.Size=UDim2.new(0,24,0,24); BarLogo.Position=UDim2.new(0,8,0.5,-12)
BarLogo.BackgroundTransparency=1; BarLogo.Image=LogoId; BarLogo.ScaleType=Enum.ScaleType.Fit; BarLogo.ZIndex=5

local ModeLabel=Instance.new("TextLabel",Bar)
ModeLabel.Size=UDim2.new(0,90,1,0); ModeLabel.Position=UDim2.new(0,36,0,0)
ModeLabel.BackgroundTransparency=1; ModeLabel.Text="Jenicakes Hub"
ModeLabel.TextColor3=Theme.TextMuted; ModeLabel.TextSize=11
ModeLabel.Font=Enum.Font.GothamBold; ModeLabel.TextXAlignment=Enum.TextXAlignment.Left; ModeLabel.ZIndex=5

local AHPill=Instance.new("TextButton",Bar)
AHPill.Size=UDim2.new(0,72,0,26); AHPill.Position=UDim2.new(0,108,0.5,-13)
AHPill.BackgroundColor3=Theme.InactiveState; AHPill.Text="Anti-Hit"
AHPill.TextColor3=Theme.TextMuted; AHPill.TextSize=11
AHPill.Font=Enum.Font.GothamBold; AHPill.BorderSizePixel=0; AHPill.ZIndex=6
Instance.new("UICorner",AHPill).CornerRadius=UDim.new(1,0)

local SPPill=Instance.new("TextButton",Bar)
SPPill.Size=UDim2.new(0,72,0,26); SPPill.Position=UDim2.new(0,184,0.5,-13)
SPPill.BackgroundColor3=Theme.InactiveState; SPPill.Text="Save Pos"
SPPill.TextColor3=Theme.TextMuted; SPPill.TextSize=11
SPPill.Font=Enum.Font.GothamBold; SPPill.BorderSizePixel=0; SPPill.ZIndex=6
Instance.new("UICorner",SPPill).CornerRadius=UDim.new(1,0)

local function setBarActive(mode)
    if mode == "antihit" then
        AHPill.BackgroundColor3=Theme.ActiveState; AHPill.TextColor3=Theme.TextNormal
        SPPill.BackgroundColor3=Theme.InactiveState; SPPill.TextColor3=Theme.TextMuted
        ModeLabel.Text="ANTI-HIT"; ModeLabel.TextColor3=Theme.AccentPink
    elseif mode == "savepos" then
        SPPill.BackgroundColor3=Theme.ActiveState; SPPill.TextColor3=Theme.TextNormal
        AHPill.BackgroundColor3=Theme.InactiveState; AHPill.TextColor3=Theme.TextMuted
        ModeLabel.Text="SAVE POS"; ModeLabel.TextColor3=Theme.AccentPink
    else
        AHPill.BackgroundColor3=Theme.InactiveState; AHPill.TextColor3=Theme.TextMuted
        SPPill.BackgroundColor3=Theme.InactiveState; SPPill.TextColor3=Theme.TextMuted
        ModeLabel.Text="Jenicakes Hub"; ModeLabel.TextColor3=Theme.TextMuted
    end
    currentMode = mode
end

-- ==========================================
-- BUILD ANTI-HIT GUI
-- ==========================================
local function buildAntiHitGui()
    AHGui = Instance.new("ScreenGui")
    AHGui.Name="JenAntiHitGui"; AHGui.ResetOnSpawn=false
    AHGui.IgnoreGuiInset=true; AHGui.ZIndexBehavior=Enum.ZIndexBehavior.Global
    AHGui.DisplayOrder=1000; AHGui.Enabled=false; AHGui.Parent=targetParent

    local openToggleBtn=Instance.new("TextButton",AHGui)
    openToggleBtn.Size=UDim2.new(0,44,0,44); openToggleBtn.Position=UDim2.new(0.04,0,0.45,0)
    openToggleBtn.BackgroundColor3=Theme.Background; openToggleBtn.BackgroundTransparency=0.2
    openToggleBtn.Text=""; openToggleBtn.Active=true; openToggleBtn.Draggable=true
    openToggleBtn.Visible=false; openToggleBtn.ZIndex=2000
    Instance.new("UICorner",openToggleBtn).CornerRadius=UDim.new(1,0)

    local ots=Instance.new("UIStroke",openToggleBtn); ots.Color=Theme.Border; ots.Thickness=2
    local otl=Instance.new("ImageLabel",openToggleBtn)
    otl.Size=UDim2.new(0,36,0,36); otl.Position=UDim2.new(0.5,-18,0.5,-18)
    otl.BackgroundTransparency=1; otl.Image=OpenBtnId; otl.ScaleType=Enum.ScaleType.Fit; otl.ZIndex=2001

    local mainFrame=Instance.new("Frame",AHGui)
    mainFrame.Name="MainFrame"; mainFrame.Size=UDim2.new(0,240,0,165)
    mainFrame.Position=UDim2.new(0.5,-120,0.5,-82)
    mainFrame.BackgroundColor3=Theme.Background; mainFrame.BackgroundTransparency=0.4
    mainFrame.BorderSizePixel=0; mainFrame.Active=true; mainFrame.Draggable=true
    Instance.new("UICorner",mainFrame).CornerRadius=UDim.new(0,10)

    local mfs=Instance.new("UIStroke",mainFrame); mfs.Color=Theme.Border; mfs.Thickness=1.6
    local bgImg=Instance.new("ImageLabel",mainFrame)
    bgImg.Size=UDim2.fromScale(1,1); bgImg.BackgroundTransparency=1
    bgImg.Image=LogoId; bgImg.ScaleType=Enum.ScaleType.Crop; bgImg.ImageTransparency=0.55
    Instance.new("UICorner",bgImg).CornerRadius=UDim.new(0,10)

    local uiScale=Instance.new("UIScale",mainFrame); uiScale.Scale=AH.guiScale

    local tl=Instance.new("ImageLabel",mainFrame)
    tl.Size=UDim2.fromOffset(26,26); tl.Position=UDim2.new(0,10,0,7)
    tl.BackgroundTransparency=1; tl.Image=LogoId; tl.ScaleType=Enum.ScaleType.Fit

    local titleLabel=Instance.new("TextLabel",mainFrame)
    titleLabel.Size=UDim2.new(1,-95,0,35); titleLabel.Position=UDim2.new(0,42,0,3)
    titleLabel.BackgroundTransparency=1; titleLabel.Text="JEN ANTI HIT"
    titleLabel.TextColor3=Theme.TextTitle; titleLabel.TextSize=15
    titleLabel.Font=Enum.Font.GothamBold; titleLabel.TextXAlignment=Enum.TextXAlignment.Left

    local function HideAH() mainFrame.Visible=false; openToggleBtn.Visible=true end
    local function ShowAH() openToggleBtn.Visible=false; mainFrame.Visible=true end
    openToggleBtn.MouseButton1Click:Connect(ShowAH)

    local minBtn=Instance.new("TextButton",mainFrame)
    minBtn.Size=UDim2.new(0,22,0,22); minBtn.Position=UDim2.new(1,-54,0,8)
    minBtn.BackgroundColor3=Theme.MinBtn; minBtn.Text="-"; minBtn.TextColor3=Theme.TextNormal
    minBtn.TextSize=14; minBtn.Font=Enum.Font.GothamBold; minBtn.BorderSizePixel=0
    Instance.new("UICorner",minBtn).CornerRadius=UDim.new(0,6)
    minBtn.MouseButton1Click:Connect(HideAH)

    local closeBtn=Instance.new("TextButton",mainFrame)
    closeBtn.Size=UDim2.new(0,22,0,22); closeBtn.Position=UDim2.new(1,-28,0,8)
    closeBtn.BackgroundColor3=Theme.CloseBtn; closeBtn.Text="X"
    closeBtn.TextColor3=Color3.fromRGB(255,255,255); closeBtn.TextSize=11
    closeBtn.Font=Enum.Font.GothamBold; closeBtn.BorderSizePixel=0
    Instance.new("UICorner",closeBtn).CornerRadius=UDim.new(0,6)
    closeBtn.MouseButton1Click:Connect(function() AHGui.Enabled=false; setBarActive(nil) end)

    local tabMainBtn=Instance.new("TextButton",mainFrame)
    tabMainBtn.Size=UDim2.new(0.5,-12,0,22); tabMainBtn.Position=UDim2.new(0,8,0,38)
    tabMainBtn.BackgroundColor3=Theme.AccentPurple; tabMainBtn.Text="Main"
    tabMainBtn.TextColor3=Color3.fromRGB(255,255,255); tabMainBtn.TextSize=12
    tabMainBtn.Font=Enum.Font.GothamBold; tabMainBtn.BorderSizePixel=0
    Instance.new("UICorner",tabMainBtn).CornerRadius=UDim.new(0,5)

    local tabMiscBtn=Instance.new("TextButton",mainFrame)
    tabMiscBtn.Size=UDim2.new(0.5,-12,0,22); tabMiscBtn.Position=UDim2.new(0.5,4,0,38)
    tabMiscBtn.BackgroundColor3=Theme.Card; tabMiscBtn.Text="Misc"
    tabMiscBtn.TextColor3=Theme.TextMuted; tabMiscBtn.TextSize=12
    tabMiscBtn.Font=Enum.Font.GothamSemibold; tabMiscBtn.BorderSizePixel=0
    Instance.new("UICorner",tabMiscBtn).CornerRadius=UDim.new(0,5)

    -- Main tab
    local mainTab=Instance.new("Frame",mainFrame)
    mainTab.Size=UDim2.new(1,0,1,-68); mainTab.Position=UDim2.new(0,0,0,66)
    mainTab.BackgroundTransparency=1; mainTab.Visible=true

    -- Misc tab — ScrollingFrame so buttons don't force a resize
    local miscTab=Instance.new("ScrollingFrame",mainFrame)
    miscTab.Size=UDim2.new(1,0,1,-68); miscTab.Position=UDim2.new(0,0,0,66)
    miscTab.BackgroundTransparency=1; miscTab.Visible=false
    miscTab.ScrollBarThickness=3; miscTab.ScrollBarImageColor3=Theme.Border
    miscTab.CanvasSize=UDim2.new(0,0,0,0)
    miscTab.AutomaticCanvasSize=Enum.AutomaticSize.Y
    miscTab.BorderSizePixel=0; miscTab.ScrollingDirection=Enum.ScrollingDirection.Y
    miscTab.ClipsDescendants=true

    local miscLayout=Instance.new("UIListLayout",miscTab)
    miscLayout.SortOrder=Enum.SortOrder.LayoutOrder; miscLayout.Padding=UDim.new(0,6)
    local miscPad=Instance.new("UIPadding",miscTab)
    miscPad.PaddingTop=UDim.new(0,8); miscPad.PaddingLeft=UDim.new(0,10); miscPad.PaddingRight=UDim.new(0,13)

    tabMainBtn.MouseButton1Click:Connect(function()
        mainTab.Visible=true; miscTab.Visible=false
        tabMainBtn.BackgroundColor3=Theme.AccentPurple; tabMainBtn.TextColor3=Color3.fromRGB(255,255,255); tabMainBtn.Font=Enum.Font.GothamBold
        tabMiscBtn.BackgroundColor3=Theme.Card; tabMiscBtn.TextColor3=Theme.TextMuted; tabMiscBtn.Font=Enum.Font.GothamSemibold
    end)

    tabMiscBtn.MouseButton1Click:Connect(function()
        mainTab.Visible=false; miscTab.Visible=true
        tabMiscBtn.BackgroundColor3=Theme.AccentPurple; tabMiscBtn.TextColor3=Color3.fromRGB(255,255,255); tabMiscBtn.Font=Enum.Font.GothamBold
        tabMainBtn.BackgroundColor3=Theme.Card; tabMainBtn.TextColor3=Theme.TextMuted; tabMainBtn.Font=Enum.Font.GothamSemibold
    end)

    -- Main tab buttons
    local antiHitBtn=Instance.new("TextButton",mainTab)
    antiHitBtn.Size=UDim2.new(1,-20,0,32); antiHitBtn.Position=UDim2.new(0,10,0,8)
    antiHitBtn.BackgroundColor3=AH.enabled and Theme.ActiveState or Theme.InactiveState
    antiHitBtn.BackgroundTransparency=0.2
    antiHitBtn.Text=AH.enabled and "Anti-Hit: ON" or "Anti-Hit: OFF"
    antiHitBtn.TextColor3=Theme.TextNormal; antiHitBtn.TextSize=12
    antiHitBtn.Font=Enum.Font.GothamSemibold; antiHitBtn.BorderSizePixel=0
    Instance.new("UICorner",antiHitBtn).CornerRadius=UDim.new(0,6)

    local ahs=Instance.new("UIStroke",antiHitBtn)
    ahs.Color=AH.enabled and Theme.Border or Theme.AccentPurple
    ahs.Thickness=1; ahs.Transparency=AH.enabled and 0.2 or 0.6

    antiHitBtn.MouseButton1Click:Connect(function()
        AH.enabled=not AH.enabled
        antiHitBtn.Text=AH.enabled and "Anti-Hit: ON" or "Anti-Hit: OFF"
        antiHitBtn.BackgroundColor3=AH.enabled and Theme.ActiveState or Theme.InactiveState
        ahs.Color=AH.enabled and Theme.Border or Theme.AccentPurple
        ahs.Transparency=AH.enabled and 0.2 or 0.6
    end)

    local instantBtn=Instance.new("TextButton",mainTab)
    instantBtn.Size=UDim2.new(1,-20,0,32); instantBtn.Position=UDim2.new(0,10,0,46)
    instantBtn.BackgroundColor3=AH.instantPickup and Theme.ActiveState or Theme.InactiveState
    instantBtn.BackgroundTransparency=0.2
    instantBtn.Text=AH.instantPickup and "Instant Pick Up: ON" or "Instant Pick Up: OFF"
    instantBtn.TextColor3=Theme.TextNormal; instantBtn.TextSize=12
    instantBtn.Font=Enum.Font.GothamSemibold; instantBtn.BorderSizePixel=0
    Instance.new("UICorner",instantBtn).CornerRadius=UDim.new(0,6)

    local ins=Instance.new("UIStroke",instantBtn)
    ins.Color=AH.instantPickup and Theme.Border or Theme.AccentPurple
    ins.Thickness=1; ins.Transparency=AH.instantPickup and 0.2 or 0.6

    instantBtn.MouseButton1Click:Connect(function()
        AH.instantPickup=not AH.instantPickup
        instantBtn.Text=AH.instantPickup and "Instant Pick Up: ON" or "Instant Pick Up: OFF"
        instantBtn.BackgroundColor3=AH.instantPickup and Theme.ActiveState or Theme.InactiveState
        ins.Color=AH.instantPickup and Theme.Border or Theme.AccentPurple
        ins.Transparency=AH.instantPickup and 0.2 or 0.6

        if AH.instantPickup then
            for _,d in ipairs(workspace:GetDescendants()) do
                if d:IsA("ProximityPrompt") then
                    if AH.holdDurations[d]==nil then AH.holdDurations[d]=d.HoldDuration end
                    d.HoldDuration=0
                end
            end
        else
            for p,orig in pairs(AH.holdDurations) do
                if p and p.Parent then p.HoldDuration=orig end
            end
            table.clear(AH.holdDurations)
        end
    end)

    -- ==========================================
    -- MISC TAB BUTTONS (scrollable list)
    -- ==========================================
    -- 1. Background style
    local bgStyleBtn=Instance.new("TextButton",miscTab)
    bgStyleBtn.Size=UDim2.new(1,0,0,32); bgStyleBtn.LayoutOrder=1
    bgStyleBtn.BackgroundColor3=Theme.InactiveState; bgStyleBtn.BackgroundTransparency=0.2
    bgStyleBtn.Text="Background: Jen Theme"; bgStyleBtn.TextColor3=Theme.TextNormal
    bgStyleBtn.TextSize=12; bgStyleBtn.Font=Enum.Font.GothamSemibold; bgStyleBtn.BorderSizePixel=0
    Instance.new("UICorner",bgStyleBtn).CornerRadius=UDim.new(0,6)

    bgStyleBtn.MouseButton1Click:Connect(function()
        AH.bgMode=AH.bgMode+1; if AH.bgMode>3 then AH.bgMode=1 end
        if AH.bgMode==1 then
            bgStyleBtn.Text="Background: Deep Purple"; bgImg.Visible=false
            mainFrame.BackgroundColor3=Theme.Background; mainFrame.BackgroundTransparency=0.1
        elseif AH.bgMode==2 then
            bgStyleBtn.Text="Background: Transparent"; bgImg.Visible=false; mainFrame.BackgroundTransparency=1
        elseif AH.bgMode==3 then
            bgStyleBtn.Text="Background: Jen Theme"; mainFrame.BackgroundTransparency=0.4; bgImg.Visible=true
        end
    end)

    -- 2. GUI Scale
    local scaleBtn=Instance.new("TextButton",miscTab)
    scaleBtn.Size=UDim2.new(1,0,0,32); scaleBtn.LayoutOrder=2
    scaleBtn.BackgroundColor3=Theme.InactiveState; scaleBtn.BackgroundTransparency=0.2
    scaleBtn.Text="GUI Scale: "..AH.guiScale.."x"; scaleBtn.TextColor3=Theme.TextNormal
    scaleBtn.TextSize=12; scaleBtn.Font=Enum.Font.GothamSemibold; scaleBtn.BorderSizePixel=0
    Instance.new("UICorner",scaleBtn).CornerRadius=UDim.new(0,6)

    local scales={0.8,1.0,1.2,1.4}; local scaleIndex=2
    scaleBtn.MouseButton1Click:Connect(function()
        scaleIndex=scaleIndex+1; if scaleIndex>#scales then scaleIndex=1 end
        AH.guiScale=scales[scaleIndex]; uiScale.Scale=AH.guiScale
        scaleBtn.Text="GUI Scale: "..AH.guiScale.."x"
    end)

    -- 3. Anti-Trap
    local avoidTrapsEnabled = true
    local function NeutralizeTraps()
        local debris=workspace:FindFirstChild("__DEBRIS"); if not debris then return end
        for _,d in ipairs(debris:GetChildren()) do
            if d.Name=="PlayerTrap" and d:GetAttribute("Owner")~=LocalPlayer.Name then
                if d:IsA("BasePart") then d.CanTouch=false; d.CanQuery=false end
                for _,c in ipairs(d:GetChildren()) do
                    if c:IsA("BasePart") then
                        c.CanTouch=false; c.CanQuery=false
                        if c.Name=="Hitbox" then c.CFrame=CFrame.new(0,-999,0) end
                    end
                end
                local tt=d:FindFirstChildWhichIsA("TouchTransmitter",true)
                if tt then pcall(function() tt:Destroy() end) end
            end
        end
    end

    NeutralizeTraps()
    local debrisFolder=workspace:FindFirstChild("__DEBRIS")
    if debrisFolder then
        debrisFolder.ChildAdded:Connect(function(child)
            if child.Name~="PlayerTrap" or not avoidTrapsEnabled then return end
            task.wait(0.05)
            if child:GetAttribute("Owner")~=LocalPlayer.Name then
                if child:IsA("BasePart") then child.CanTouch=false; child.CanQuery=false end
                for _,c in ipairs(child:GetChildren()) do
                    if c:IsA("BasePart") then c.CanTouch=false; c.CanQuery=false end
                end
            end
        end)
    end

    local avoidTrapsBtn=Instance.new("TextButton",miscTab)
    avoidTrapsBtn.Size=UDim2.new(1,0,0,32); avoidTrapsBtn.LayoutOrder=3
    avoidTrapsBtn.BackgroundColor3=Theme.ActiveState; avoidTrapsBtn.BackgroundTransparency=0.2
    avoidTrapsBtn.Text="Anti-Trap: ON"; avoidTrapsBtn.TextColor3=Theme.TextNormal
    avoidTrapsBtn.TextSize=12; avoidTrapsBtn.Font=Enum.Font.GothamSemibold; avoidTrapsBtn.BorderSizePixel=0
    Instance.new("UICorner",avoidTrapsBtn).CornerRadius=UDim.new(0,6)

    local ats=Instance.new("UIStroke",avoidTrapsBtn); ats.Color=Theme.Border; ats.Thickness=1; ats.Transparency=0.2
    avoidTrapsBtn.MouseButton1Click:Connect(function()
        avoidTrapsEnabled=not avoidTrapsEnabled
        avoidTrapsBtn.Text=avoidTrapsEnabled and "Anti-Trap: ON" or "Anti-Trap: OFF"
        avoidTrapsBtn.BackgroundColor3=avoidTrapsEnabled and Theme.ActiveState or Theme.InactiveState
        ats.Transparency=avoidTrapsEnabled and 0.2 or 0.6
        if avoidTrapsEnabled then NeutralizeTraps() end
    end)

    -- 4. No Knockback
    local noKnockbackEnabled = true
    local function disconnectKBSync()
        pcall(function()
            local pkgs=game:GetService("ReplicatedStorage"):FindFirstChild("Packages")
            local net=pkgs and pkgs:FindFirstChild("Networking")
            local rigSync=net and net:FindFirstChild("RE/RigSync/Refresh")
            if rigSync and getconnections then
                for _,conn in ipairs(getconnections(rigSync.OnClientEvent)) do
                    pcall(function() conn:Disconnect() end)
                end
            end
        end)
    end

    if noKnockbackEnabled then disconnectKBSync() end

    local noKBBtn=Instance.new("TextButton",miscTab)
    noKBBtn.Size=UDim2.new(1,0,0,32); noKBBtn.LayoutOrder=4
    noKBBtn.BackgroundColor3=Theme.ActiveState; noKBBtn.BackgroundTransparency=0.2
    noKBBtn.Text="No Knockback: ON"; noKBBtn.TextColor3=Theme.TextNormal
    noKBBtn.TextSize=12; noKBBtn.Font=Enum.Font.GothamSemibold; noKBBtn.BorderSizePixel=0
    Instance.new("UICorner",noKBBtn).CornerRadius=UDim.new(0,6)

    local nks=Instance.new("UIStroke",noKBBtn); nks.Color=Theme.Border; nks.Thickness=1; nks.Transparency=0.2
    noKBBtn.MouseButton1Click:Connect(function()
        noKnockbackEnabled=not noKnockbackEnabled
        noKBBtn.Text=noKnockbackEnabled and "No Knockback: ON" or "No Knockback: OFF"
        noKBBtn.BackgroundColor3=noKnockbackEnabled and Theme.ActiveState or Theme.InactiveState
        nks.Transparency=noKnockbackEnabled and 0.2 or 0.6
        if noKnockbackEnabled then disconnectKBSync() end
    end)

    -- 5. Anti-Ragdoll
    local antiRagdollEnabled = true
    RunService.Heartbeat:Connect(function()
        if not antiRagdollEnabled then return end
        local char=LocalPlayer.Character
        local hum=char and char:FindFirstChildOfClass("Humanoid")
        if hum and hum:GetState()==Enum.HumanoidStateType.Physics then
            hum:ChangeState(Enum.HumanoidStateType.GettingUp)
        end
    end)

    local antiRDBtn=Instance.new("TextButton",miscTab)
    antiRDBtn.Size=UDim2.new(1,0,0,32); antiRDBtn.LayoutOrder=5
    antiRDBtn.BackgroundColor3=Theme.ActiveState; antiRDBtn.BackgroundTransparency=0.2
    antiRDBtn.Text="Anti-Ragdoll: ON"; antiRDBtn.TextColor3=Theme.TextNormal
    antiRDBtn.TextSize=12; antiRDBtn.Font=Enum.Font.GothamSemibold; antiRDBtn.BorderSizePixel=0
    Instance.new("UICorner",antiRDBtn).CornerRadius=UDim.new(0,6)

    local ards=Instance.new("UIStroke",antiRDBtn); ards.Color=Theme.Border; ards.Thickness=1; ards.Transparency=0.2
    antiRDBtn.MouseButton1Click:Connect(function()
        antiRagdollEnabled=not antiRagdollEnabled
        antiRDBtn.Text=antiRagdollEnabled and "Anti-Ragdoll: ON" or "Anti-Ragdoll: OFF"
        antiRDBtn.BackgroundColor3=antiRagdollEnabled and Theme.ActiveState or Theme.InactiveState
        ards.Transparency=antiRagdollEnabled and 0.2 or 0.6
    end)

    -- ==========================================
    -- TELEPORT OVERLAY
    -- ==========================================
    local teleportOverlay=Instance.new("Frame",AHGui)
    teleportOverlay.Name="TeleportOverlay"; teleportOverlay.Size=UDim2.fromScale(1,1)
    teleportOverlay.BackgroundColor3=Color3.fromRGB(15,8,20); teleportOverlay.BackgroundTransparency=1
    teleportOverlay.Visible=false; teleportOverlay.ZIndex=5000

    local overlayLogo=Instance.new("ImageLabel",teleportOverlay)
    overlayLogo.AnchorPoint=Vector2.new(0.5,0.5); overlayLogo.Position=UDim2.new(0.5,0,0.38,0)
    overlayLogo.Size=UDim2.fromOffset(125,125); overlayLogo.BackgroundTransparency=1
    overlayLogo.Image=LogoId; overlayLogo.ScaleType=Enum.ScaleType.Fit; overlayLogo.ZIndex=5001

    local loadingText=Instance.new("TextLabel",teleportOverlay)
    loadingText.AnchorPoint=Vector2.new(0.5,0); loadingText.Position=UDim2.new(0.5,0,0.50,5)
    loadingText.Size=UDim2.fromOffset(400,36); loadingText.BackgroundTransparency=1
    loadingText.Text="JEN ANTI HIT LOADING..."; loadingText.TextColor3=Theme.AccentPink
    loadingText.Font=Enum.Font.GothamBold; loadingText.TextSize=22; loadingText.ZIndex=5001

    local loadingBarBg=Instance.new("Frame",teleportOverlay)
    loadingBarBg.AnchorPoint=Vector2.new(0.5,0); loadingBarBg.Position=UDim2.new(0.5,0,0.57,10)
    loadingBarBg.Size=UDim2.fromOffset(260,6); loadingBarBg.BackgroundColor3=Color3.fromRGB(35,20,45)
    loadingBarBg.BorderSizePixel=0; loadingBarBg.ZIndex=5001
    Instance.new("UICorner",loadingBarBg).CornerRadius=UDim.new(1,0)

    local loadingBarFill=Instance.new("Frame",loadingBarBg)
    loadingBarFill.Size=UDim2.new(0,0,1,0); loadingBarFill.BackgroundColor3=Theme.Border
    loadingBarFill.BorderSizePixel=0; loadingBarFill.ZIndex=5002
    Instance.new("UICorner",loadingBarFill).CornerRadius=UDim.new(1,0)

    local function TeleportRoute(Character)
        if not AH.enabled then return false end
        if not Character or not Character.Parent then return false end
        local root = Character:FindFirstChild("HumanoidRootPart")
        local hum = Character:FindFirstChildOfClass("Humanoid")
        if not root or not hum or hum.Health <= 0 then return false end

        AH.routeToken = AH.routeToken + 1
        local token = AH.routeToken

        local function alive()
            return token == AH.routeToken and AH.enabled and Character.Parent ~= nil and root.Parent ~= nil and hum.Health > 0
        end

        teleportOverlay.Visible=true; teleportOverlay.BackgroundTransparency=0
        loadingBarFill.Size=UDim2.new(0,0,1,0); loadingText.Text="JEN ANTI HIT LOADING..."

        hum.PlatformStand = true
        local finished = false

        pcall(function()
            local total = #TeleportPoints
            for i, pos in ipairs(TeleportPoints) do
                if not alive() then return end
                TweenService:Create(loadingBarFill, TweenInfo.new(0.12), {Size=UDim2.new(i/total,0,1,0)}):Play()
                if i == total then loadingText.Text="JEN ANTI HIT READY!" end
                root.AssemblyLinearVelocity = Vector3.zero
                root.AssemblyAngularVelocity = Vector3.zero
                Character:PivotTo(CFrame.new(pos) * root.CFrame.Rotation)
                root.AssemblyLinearVelocity = Vector3.zero
                if i < total then RunService.Heartbeat:Wait() end
            end
            finished = true
        end)

        pcall(function()
            root.AssemblyLinearVelocity = Vector3.zero
            root.AssemblyAngularVelocity = Vector3.zero
        end)

        if hum and hum.Parent then hum.PlatformStand = false end
        if token ~= AH.routeToken then teleportOverlay.Visible=false return false end

        if finished then task.wait(0.25) end
        local fo=TweenService:Create(teleportOverlay,TweenInfo.new(0.5,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{BackgroundTransparency=1})
        fo:Play(); fo.Completed:Wait(); teleportOverlay.Visible=false
        return finished
    end

    LocalPlayer.CharacterAdded:Connect(function()
        AH.routeToken = AH.routeToken + 1
        AH.isTeleporting = false
        teleportOverlay.Visible = false
    end)

    workspace.DescendantAdded:Connect(function(d)
        if d:IsA("ProximityPrompt") and AH.instantPickup then
            if AH.holdDurations[d]==nil then AH.holdDurations[d]=d.HoldDuration end
            d.HoldDuration=0
        end
    end)

    local function promptMatchesKeywords(Prompt, keywords)
        local fields = {
            (Prompt.ActionText or ""):lower(),
            (Prompt.ObjectText or ""):lower(),
            (Prompt.Name or ""):lower(),
        }
        local obj = Prompt.Parent
        local depth = 0
        while obj and obj ~= workspace and depth < 3 do
            table.insert(fields, obj.Name:lower())
            obj = obj.Parent; depth = depth + 1
        end
        local combined = table.concat(fields, " ")
        for _, kw in ipairs(keywords) do
            if combined:find(kw, 1, true) then return true end
        end
        return false
    end

    ProximityPromptService.PromptTriggered:Connect(function(Prompt, TriggeredPlayer)
        if TriggeredPlayer ~= LocalPlayer then return end
        if not AH.enabled or AH.isTeleporting then return end
        if isInSafeZone() then return end
        if promptIsInSafeZone(Prompt) then return end
        if not promptMatchesKeywords(Prompt, STEAL_KEYWORDS_AH) then return end

        local Char = LocalPlayer.Character
        if not Char then return end
        local hum = Char:FindFirstChildOfClass("Humanoid")
        if not hum or hum.Health <= 0 then return end

        AH.isTeleporting = true
        local ok, finished = pcall(TeleportRoute, Char)
        AH.isTeleporting = false

        if ok and finished and LocalPlayer.Character == Char and hum.Health > 0 and SP.autoReturnOn and promptMatchesKeywords(Prompt, EGG_KEYWORDS) then
            SP.lastWasEgg = true
            triggerWalkback(nil)
        end
    end)
end

-- ==========================================
-- BUILD SAVE POS GUI
-- ==========================================
local function buildSavePosGui()
    local WIN_W=240; local WIN_H_FULL=200
    local dragging=false; local dragOffset=Vector2.new(0,0); local rawX,rawY=0,0

    SPGui=Instance.new("ScreenGui")
    SPGui.Name="JenSavePosGui"; SPGui.ResetOnSpawn=false
    SPGui.IgnoreGuiInset=true; SPGui.ZIndexBehavior=Enum.ZIndexBehavior.Global
    SPGui.DisplayOrder=1000; SPGui.Enabled=false; SPGui.Parent=targetParent

    local openBtn2=Instance.new("TextButton",SPGui)
    openBtn2.Size=UDim2.new(0,44,0,44); openBtn2.Position=UDim2.new(1,-52,0.5,-22)
    openBtn2.BackgroundColor3=Theme.Background; openBtn2.BackgroundTransparency=0.2
    openBtn2.Text=""; openBtn2.Active=true; openBtn2.Draggable=true
    openBtn2.Visible=false; openBtn2.ZIndex=2000
    Instance.new("UICorner",openBtn2).CornerRadius=UDim.new(1,0)

    local ob2s=Instance.new("UIStroke",openBtn2); ob2s.Color=Theme.Border; ob2s.Thickness=2
    local ob2l=Instance.new("ImageLabel",openBtn2)
    ob2l.Size=UDim2.new(0,36,0,36); ob2l.Position=UDim2.new(0.5,-18,0.5,-18)
    ob2l.BackgroundTransparency=1; ob2l.Image=OpenBtnId; ob2l.ScaleType=Enum.ScaleType.Fit; ob2l.ZIndex=2001

    local SPWin=Instance.new("Frame",SPGui)
    SPWin.Name="MainFrame"; SPWin.Size=UDim2.new(0,WIN_W,0,WIN_H_FULL)
    SPWin.Position=UDim2.new(0.5,-WIN_W/2,0.5,-WIN_H_FULL/2)
    SPWin.BackgroundColor3=Theme.Background; SPWin.BackgroundTransparency=0.4
    SPWin.BorderSizePixel=0; SPWin.ClipsDescendants=true
    Instance.new("UICorner",SPWin).CornerRadius=UDim.new(0,10)

    local spws=Instance.new("UIStroke",SPWin); spws.Color=Theme.Border; spws.Thickness=1.6
    local spBg=Instance.new("ImageLabel",SPWin)
    spBg.Size=UDim2.fromScale(1,1); spBg.BackgroundTransparency=1
    spBg.Image=LogoId; spBg.ScaleType=Enum.ScaleType.Crop; spBg.ImageTransparency=0.55; spBg.ZIndex=1
    Instance.new("UICorner",spBg).CornerRadius=UDim.new(0,10)

    local spTL=Instance.new("ImageLabel",SPWin)
    spTL.Size=UDim2.fromOffset(26,26); spTL.Position=UDim2.new(0,10,0,7)
    spTL.BackgroundTransparency=1; spTL.Image=LogoId; spTL.ScaleType=Enum.ScaleType.Fit; spTL.ZIndex=5

    local spTitle=Instance.new("TextLabel",SPWin)
    spTitle.Size=UDim2.new(1,-95,0,35); spTitle.Position=UDim2.new(0,42,0,3)
    spTitle.BackgroundTransparency=1; spTitle.Text="SAVE POSITION"
    spTitle.TextColor3=Theme.TextTitle; spTitle.TextSize=15
    spTitle.Font=Enum.Font.GothamBold; spTitle.TextXAlignment=Enum.TextXAlignment.Left; spTitle.ZIndex=5

    local spMin=Instance.new("TextButton",SPWin)
    spMin.Size=UDim2.new(0,22,0,22); spMin.Position=UDim2.new(1,-54,0,8)
    spMin.BackgroundColor3=Theme.MinBtn; spMin.Text="-"; spMin.TextColor3=Theme.TextNormal
    spMin.TextSize=14; spMin.Font=Enum.Font.GothamBold; spMin.BorderSizePixel=0; spMin.ZIndex=8
    Instance.new("UICorner",spMin).CornerRadius=UDim.new(0,6)

    local spClose=Instance.new("TextButton",SPWin)
    spClose.Size=UDim2.new(0,22,0,22); spClose.Position=UDim2.new(1,-28,0,8)
    spClose.BackgroundColor3=Theme.CloseBtn; spClose.Text="X"
    spClose.TextColor3=Color3.fromRGB(255,255,255); spClose.TextSize=11
    spClose.Font=Enum.Font.GothamBold; spClose.BorderSizePixel=0; spClose.ZIndex=8
    Instance.new("UICorner",spClose).CornerRadius=UDim.new(0,6)

    local slotFrames={}; local slotLabels={}
    local function updateSlotLabel(i)
        slotLabels[i].Text=SP.slots[i] and ("Slot "..i.." ✓") or ("Slot "..i)
        slotLabels[i].TextColor3=SP.slots[i] and Color3.fromRGB(200,255,180) or Theme.TextNormal
    end

    for i=1,3 do
        local sf=Instance.new("Frame",SPWin)
        sf.Size=UDim2.new(0,68,0,28); sf.Position=UDim2.new(0,8+(i-1)*76,0,42)
        sf.BackgroundColor3=(SP.activeSlot==i) and Theme.AccentPurple or Color3.fromRGB(40,24,60)
        sf.BorderSizePixel=0; sf.ZIndex=6
        Instance.new("UICorner",sf).CornerRadius=UDim.new(0,6)

        local ss=Instance.new("UIStroke",sf); ss.Color=Theme.AccentPurple; ss.Thickness=1; ss.Transparency=0.6
        local sl=Instance.new("TextLabel",sf)
        sl.Size=UDim2.fromScale(1,1); sl.BackgroundTransparency=1
        sl.Text=SP.slots[i] and ("Slot "..i.." ✓") or ("Slot "..i)
        sl.TextColor3=SP.slots[i] and Color3.fromRGB(200,255,180) or Theme.TextNormal
        sl.TextSize=11; sl.Font=Enum.Font.GothamBold; sl.ZIndex=7

        local sb=Instance.new("TextButton",sf)
        sb.Size=UDim2.fromScale(1,1); sb.BackgroundTransparency=1; sb.Text=""; sb.ZIndex=8
        slotFrames[i]=sf; slotLabels[i]=sl

        sb.MouseButton1Click:Connect(function()
            SP.activeSlot=i
            for j=1,3 do
                slotFrames[j].BackgroundColor3=(j==i) and Theme.AccentPurple or Color3.fromRGB(40,24,60)
            end
        end)
    end

    local SaveBtn2=Instance.new("TextButton",SPWin)
    SaveBtn2.Size=UDim2.new(1,-16,0,28); SaveBtn2.Position=UDim2.new(0,8,0,78)
    SaveBtn2.BackgroundColor3=Theme.AccentPurple; SaveBtn2.Text="SAVE POSITION"
    SaveBtn2.TextColor3=Color3.fromRGB(255,255,255); SaveBtn2.TextSize=12
    SaveBtn2.Font=Enum.Font.GothamBold; SaveBtn2.BorderSizePixel=0; SaveBtn2.ZIndex=6
    Instance.new("UICorner",SaveBtn2).CornerRadius=UDim.new(0,6)

    local TpBtn2=Instance.new("TextButton",SPWin)
    TpBtn2.Size=UDim2.new(1,-16,0,28); TpBtn2.Position=UDim2.new(0,8,0,112)
    TpBtn2.BackgroundColor3=Color3.fromRGB(30,18,45); TpBtn2.Text="TELEPORT TO SLOT"
    TpBtn2.TextColor3=Theme.AccentPurple; TpBtn2.TextSize=12
    TpBtn2.Font=Enum.Font.GothamBold; TpBtn2.BorderSizePixel=0; TpBtn2.ZIndex=6
    Instance.new("UICorner",TpBtn2).CornerRadius=UDim.new(0,6)
    local tps=Instance.new("UIStroke",TpBtn2); tps.Color=Theme.AccentPurple; tps.Thickness=1

    local AutoBtn2=Instance.new("TextButton",SPWin)
    AutoBtn2.Size=UDim2.new(1,-16,0,28); AutoBtn2.Position=UDim2.new(0,8,0,148)
    AutoBtn2.BackgroundColor3=Color3.fromRGB(30,18,45)
    AutoBtn2.Text=SP.autoReturnOn and "AUTO RETURN: ON" or "AUTO RETURN: OFF"
    AutoBtn2.TextColor3=SP.autoReturnOn and Color3.fromRGB(180,255,160) or Color3.fromRGB(180,180,180)
    AutoBtn2.TextSize=12; AutoBtn2.Font=Enum.Font.GothamBold; AutoBtn2.BorderSizePixel=0; AutoBtn2.ZIndex=6
    Instance.new("UICorner",AutoBtn2).CornerRadius=UDim.new(0,6)

    local as2=Instance.new("UIStroke",AutoBtn2)
    as2.Color=SP.autoReturnOn and Color3.fromRGB(100,255,100) or Theme.Border; as2.Thickness=1

    local StatusLabel2=Instance.new("TextLabel",SPWin)
    StatusLabel2.Size=UDim2.new(1,-16,0,16); StatusLabel2.Position=UDim2.new(0,8,0,178)
    StatusLabel2.BackgroundTransparency=1; StatusLabel2.Text="No slot selected"
    StatusLabel2.TextColor3=Color3.fromRGB(180,130,200); StatusLabel2.TextSize=10
    StatusLabel2.Font=Enum.Font.Gotham; StatusLabel2.ZIndex=6

    local function getRootPart()
        local c=LocalPlayer.Character; return c and (c:FindFirstChild("HumanoidRootPart") or c.PrimaryPart)
    end
    local function getHumanoid()
        local c=LocalPlayer.Character; return c and c:FindFirstChildOfClass("Humanoid")
    end

    local function promptIsEggSteal(prompt)
        local fields = {
            (prompt.ActionText or ""):lower(),
            (prompt.ObjectText or ""):lower(),
            (prompt.Name or ""):lower(),
        }
        local obj = prompt.Parent
        local depth = 0
        while obj and obj ~= workspace and depth < 3 do
            table.insert(fields, obj.Name:lower())
            obj = obj.Parent; depth = depth + 1
        end
        local combined = table.concat(fields, " ")
        for _, kw in ipairs(EGG_KEYWORDS) do
            if combined:find(kw, 1, true) then return true end
        end
        return false
    end

    local function hookPrompt(prompt)
        if SP.promptConns[prompt] then return end
        if not promptIsEggSteal(prompt) then return end
        SP.promptConns[prompt]=prompt.Triggered:Connect(function(player)
            if player~=LocalPlayer then return end
            local char = LocalPlayer.Character
            task.delay(1,function()
                if not SP.autoReturnOn then return end
                if LocalPlayer.Character ~= char then return end
                local h = char and char:FindFirstChildOfClass("Humanoid")
                if not h or h.Health <= 0 then return end
                SP.stealFlagged=true; SP.stealFlagTimer=STEAL_FLAG_TTL
                SP.lastWasEgg=true
                StatusLabel2.Text="Egg stolen — watching for drop…"
            end)
        end)
    end

    local function hookAllPrompts()
        for _,o in ipairs(workspace:GetDescendants()) do
            if o:IsA("ProximityPrompt") then hookPrompt(o) end
        end
    end

    workspace.DescendantAdded:Connect(function(o)
        if o:IsA("ProximityPrompt") then hookPrompt(o) end
    end)
    workspace.DescendantRemoving:Connect(function(o)
        if SP.promptConns[o] then
            SP.promptConns[o]:Disconnect(); SP.promptConns[o]=nil
        end
    end)

    local function stopWalkback()
        SP.returning=false; SP.waitPending=false; SP.activeRun=SP.activeRun+1
        if SP.walkConn then SP.walkConn:Disconnect(); SP.walkConn=nil end
        SP.lastPos=nil
    end

    local function startAutoReturn()
        stopWalkback(); hookAllPrompts()
        SP.walkConn=RunService.Heartbeat:Connect(function(dt)
            if not SP.autoReturnOn then return end
            if SP.stealFlagged then
                SP.stealFlagTimer=SP.stealFlagTimer-dt
                if SP.stealFlagTimer<=0 then
                    SP.stealFlagged=false; SP.stealFlagTimer=0; SP.lastWasEgg=false
                end
            end
            local root=getRootPart(); local hum=getHumanoid()
            if not root or not hum then SP.lastPos=nil; return end
            SP.lastPos=root.Position
            if SP.stealFlagged and SP.lastWasEgg then
                triggerWalkback(StatusLabel2)
            end
        end)
    end

    SaveBtn2.MouseButton1Click:Connect(function()
        if not SP.activeSlot then StatusLabel2.Text="Pick a slot first"; return end
        local root=getRootPart(); if not root then StatusLabel2.Text="No character"; return end
        SP.slots[SP.activeSlot]=root.CFrame; updateSlotLabel(SP.activeSlot)
        StatusLabel2.Text="Saved to Slot "..SP.activeSlot
    end)

    TpBtn2.MouseButton1Click:Connect(function()
        if not SP.activeSlot then StatusLabel2.Text="Pick a slot first"; return end
        if not SP.slots[SP.activeSlot] then StatusLabel2.Text="Slot "..SP.activeSlot.." empty"; return end
        local root=getRootPart(); if not root then return end
        root.CFrame=SP.slots[SP.activeSlot]; StatusLabel2.Text="Teleported to Slot "..SP.activeSlot
    end)

    AutoBtn2.MouseButton1Click:Connect(function()
        SP.autoReturnOn = not SP.autoReturnOn
        if SP.autoReturnOn then
            AutoBtn2.Text="AUTO RETURN: ON"; AutoBtn2.TextColor3=Color3.fromRGB(180,255,160)
            as2.Color=Color3.fromRGB(100,255,100)
            startAutoReturn()
            StatusLabel2.Text="Watching for egg steals…"
            if SP.activeSlot and SP.slots[SP.activeSlot] and SP.lastWasEgg then
                immediateWalkback(StatusLabel2)
            end
        else
            AutoBtn2.Text="AUTO RETURN: OFF"; AutoBtn2.TextColor3=Color3.fromRGB(180,180,180)
            as2.Color=Theme.Border; stopWalkback(); StatusLabel2.Text="Auto-return off"
            SP.lastWasEgg=false
        end
    end)

    LocalPlayer.CharacterAdded:Connect(function()
        SP.spawnTime = tick()
        SP.activeRun = SP.activeRun + 1
        SP.returning=false; SP.waitPending=false
        SP.stealFlagged=false; SP.stealFlagTimer=0
        SP.lastPos=nil; SP.lastWasEgg=false
        dropCache=nil
        StatusLabel2.Text = SP.autoReturnOn and "Watching for egg steals…" or "Auto-return off"
        task.wait(0.5)
        if SP.autoReturnOn then startAutoReturn() end
    end)

    local function HideSP()
        TweenService:Create(SPWin,TweenInfo.new(0.18,Enum.EasingStyle.Quad),{Size=UDim2.new(0,WIN_W,0,40)}):Play()
        task.delay(0.19,function() SPWin.Visible=false; openBtn2.Visible=true end)
    end

    local function ShowSP()
        openBtn2.Visible=false; SPWin.Visible=true
        TweenService:Create(SPWin,TweenInfo.new(0.2,Enum.EasingStyle.Back,Enum.EasingDirection.Out),{Size=UDim2.new(0,WIN_W,0,WIN_H_FULL)}):Play()
    end

    spMin.MouseButton1Click:Connect(HideSP)
    openBtn2.MouseButton1Click:Connect(ShowSP)

    spClose.MouseButton1Click:Connect(function()
        SPGui.Enabled=false; setBarActive(nil)
        if SP.walkConn then SP.walkConn:Disconnect(); SP.walkConn=nil end
    end)

    local function inputPos2(input)
        if input.UserInputType==Enum.UserInputType.Touch then return input.Position.X,input.Position.Y end
        local mp=UserInputService:GetMouseLocation(); return mp.X,mp.Y
    end

    spTitle.InputBegan:Connect(function(input)
        local t=input.UserInputType
        if t~=Enum.UserInputType.MouseButton1 and t~=Enum.UserInputType.Touch then return end
        dragging=true; local mx,my=inputPos2(input); local wp=SPWin.AbsolutePosition
        dragOffset=Vector2.new(mx-wp.X,my-wp.Y); rawX,rawY=wp.X,wp.Y
    end)

    spTitle.InputEnded:Connect(function(input)
        local t=input.UserInputType
        if t==Enum.UserInputType.MouseButton1 or t==Enum.UserInputType.Touch then dragging=false end
    end)

    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType==Enum.UserInputType.Touch then dragging=false end
    end)

    UserInputService.InputChanged:Connect(function(input)
        local t=input.UserInputType
        if not dragging then return end
        if t~=Enum.UserInputType.MouseMovement and t~=Enum.UserInputType.Touch then return end
        local mx,my=inputPos2(input); rawX=mx-dragOffset.X; rawY=my-dragOffset.Y
    end)

    RunService.Heartbeat:Connect(function()
        if not dragging then return end
        local vp=workspace.CurrentCamera and workspace.CurrentCamera.ViewportSize or Vector2.new(1280,720)
        SPWin.Position=UDim2.new(0,math.clamp(rawX,0,vp.X-WIN_W),0,math.clamp(rawY,0,vp.Y-WIN_H_FULL))
    end)

    if SP.autoReturnOn then startAutoReturn() end
end

-- ==========================================
-- BUILD BOTH, WIRE SWITCHER
-- ==========================================
buildAntiHitGui()
buildSavePosGui()
sendLog()

AHPill.MouseButton1Click:Connect(function()
    if currentMode=="antihit" then return end
    if SPGui then SPGui.Enabled=false end
    AHGui.Enabled=true; setBarActive("antihit")
end)

SPPill.MouseButton1Click:Connect(function()
    if currentMode=="savepos" then return end
    if AHGui then AHGui.Enabled=false end
    SPGui.Enabled=true; setBarActive("savepos")
end)
