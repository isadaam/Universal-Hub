-- Configuration
local aim_config = _G.JALON_AIMCONFIG or {
    Enabled = true,
    KeyActivation = Enum.KeyCode.LeftShift,

    FOV = 200,
    TeamCheck = true,
    DistanceCheck = true,
    VisibleCheck = true,

    Smoothness = 0.975,
}
_G.JALON_AIMCONFIG = _G.JALON_AIMCONFIG or aim_config

-- Services
local input_service = game:GetService("UserInputService")
local players = game:GetService("Players")
local run_service = game:GetService("RunService")

-- Objects
local camera = workspace.CurrentCamera
local player = players.LocalPlayer
local fovCircle, targetBox = Drawing.new("Circle"), Drawing.new("Square")

-- Variables
local current_nearest_plr
local esp_enabled = true
local name_esp_enabled = true
local health_esp_enabled = true

-- Functions
local function is_player_valid(plrArg)
    local plrChar = plrArg.Character
    local plrHumanoid, target_part = (plrChar and plrChar:FindFirstChildWhichIsA("Humanoid")), (plrChar and plrChar:FindFirstChild("HumanoidRootPart"))
    return plrArg ~= player and (plrChar and (plrHumanoid and plrHumanoid.Health ~= 0)) and not plrArg.Character:FindFirstChildWhichIsA("ForceField") and (aim_config.TeamCheck and (plrArg.Neutral or plrArg.TeamColor ~= player.TeamColor) or not aim_config.TeamCheck), target_part
end

local function get_rootpart(plr)
    return plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") or nil
end

local function in_line_of_sight(origin_pos, ...)
    return #camera:GetPartsObscuringTarget({origin_pos}, {camera, player.Character, ...}) == 0
end

-- Gets nearest player relative to cursor
local function get_nearest_player()
    local nearest_plr_data = {aimPart = nil, cursor_dist = math.huge, char_dist = math.huge}

    for _, plr in pairs(players:GetPlayers()) do
        local passed, target_part = is_player_valid(plr)
        if not (passed and target_part) then continue end
        local headPart = target_part.Parent:FindFirstChild("Head")
        if not headPart then continue end -- Skip if the player doesn't have a head

        local screen_pos, on_screen = camera:WorldToViewportPoint(headPart.Position)
        local fov_dist = (input_service:GetMouseLocation() - Vector2.new(screen_pos.X, screen_pos.Y)).Magnitude
        local char_dist = (get_rootpart(player).Position - headPart.Position).Magnitude

        if (not aim_config.VisibleCheck or (on_screen and in_line_of_sight(camera.CFrame.Position, plr.Character))) then
            if ((fov_dist <= aim_config.FOV) and (fov_dist < nearest_plr_data.cursor_dist)) and (not aim_config.DistanceCheck or (char_dist < nearest_plr_data.char_dist)) then
                nearest_plr_data.aimPart = headPart
                nearest_plr_data.cursor_dist = fov_dist
                nearest_plr_data.char_dist = char_dist
            end
        end
    end
    return nearest_plr_data.aimPart and nearest_plr_data or nil
end

-- ESP Functions
local function DrawESP(plr)
    local team_color = plr.TeamColor.Color
    local Box = Drawing.new("Quad")
    Box.Visible = false
    Box.Color = team_color
    Box.Thickness = 3
    Box.Transparency = 1

    local NameTag = Drawing.new("Text")
    NameTag.Visible = false
    NameTag.Center = true
    NameTag.Outline = true
    NameTag.Font = 3
    NameTag.Size = 13
    NameTag.Color = team_color
    NameTag.Text = plr.Name

    local HealthBar = Drawing.new("Line")
    HealthBar.Visible = false
    HealthBar.Thickness = 3

    local function Update()
        local c
        c = run_service.RenderStepped:Connect(function()
            if plr.Character ~= nil and plr.Character:FindFirstChildOfClass("Humanoid") ~= nil and plr.Character.PrimaryPart ~= nil and plr.Character:FindFirstChildOfClass("Humanoid").Health > 0 then
                local pos, vis = camera:WorldToViewportPoint(plr.Character.PrimaryPart.Position)
                if vis then 
                    local points = {}
                    local c = 0
                    for _,v in pairs(plr.Character:GetChildren()) do
                        if v:IsA("BasePart") then
                            c = c + 1
                            local p, vis = camera:WorldToViewportPoint(v.Position)
                            if v == plr.Character.PrimaryPart then
                                p, vis = camera:WorldToViewportPoint((v.CFrame * CFrame.new(0, 0, -v.Size.Z)).p)
                            elseif v.Name == "Head" then
                                p, vis = camera:WorldToViewportPoint((v.CFrame * CFrame.new(0, v.Size.Y/2, v.Size.Z/1.25)).p)
                            elseif string.match(v.Name, "Left") then
                                p, vis = camera:WorldToViewportPoint((v.CFrame * CFrame.new(-v.Size.X/2, 0, 0)).p)
                            elseif string.match(v.Name, "Right") then
                                p, vis = camera:WorldToViewportPoint((v.CFrame * CFrame.new(v.Size.X/2, 0, 0)).p)
                            end
                            points[c] = {p, vis}
                        end
                    end

                    local TopY = math.huge
                    local DownY = -math.huge
                    local LeftX = math.huge
                    local RightX = -math.huge

                    local Left
                    local Right
                    local Top
                    local Bottom

                    for _,v in pairs(points) do
                        if v[2] == true then
                            local p = v[1]
                            if p.Y < TopY then
                                Top = p
                                TopY = p.Y
                            end
                            if p.Y > DownY then
                                Bottom = p
                                DownY = p.Y
                            end
                            if p.X > RightX then
                                Right = p
                                RightX = p.X
                            end
                            if p.X < LeftX then
                                Left = p
                                LeftX = p.X
                            end
                        end
                    end

                    if Left and Right and Top and Bottom then
                        Box.PointA = Vector2.new(Right.X, Top.Y)
                        Box.PointB = Vector2.new(Left.X, Top.Y)
                        Box.PointC = Vector2.new(Left.X, Bottom.Y)
                        Box.PointD = Vector2.new(Right.X, Bottom.Y)
                        Box.Visible = esp_enabled

                        NameTag.Position = Vector2.new(Right.X - ((Right.X - Left.X) / 2), Top.Y - 15)
                        NameTag.Visible = name_esp_enabled

                        local health = plr.Character:FindFirstChildOfClass("Humanoid").Health / plr.Character:FindFirstChildOfClass("Humanoid").MaxHealth
                        HealthBar.From = Vector2.new(Left.X - 5, Bottom.Y)
                        HealthBar.To = Vector2.new(Left.X - 5, Bottom.Y - ((Bottom.Y - Top.Y) * health))
                        HealthBar.Color = Color3.fromRGB(255 - (health * 255), health * 255, 0)
                        HealthBar.Visible = health_esp_enabled
                    else 
                        Box.Visible = false
                        NameTag.Visible = false
                        HealthBar.Visible = false
                    end
                else 
                    Box.Visible = false
                    NameTag.Visible = false
                    HealthBar.Visible = false
                end
            else
                Box.Visible = false
                NameTag.Visible = false
                HealthBar.Visible = false
                if players:FindFirstChild(plr.Name) == nil then
                    c:Disconnect()
                end
            end
        end)
    end
    coroutine.wrap(Update)()
end

for _,v in pairs(players:GetChildren()) do
    if v.Name ~= player.Name then 
        DrawESP(v)
    end
end

players.PlayerAdded:Connect(function(v)
    DrawESP(v)
end)


fovCircle.Color = Color3.fromRGB(255, 255, 255) -- Change to white
fovCircle.Thickness = 2
fovCircle.Transparency = .6
fovCircle.Visible = true

run_service.RenderStepped:Connect(function()
    current_nearest_plr = get_nearest_player()

    fovCircle.Radius = aim_config.FOV
    fovCircle.Position = input_service:GetMouseLocation()

    if current_nearest_plr then
        local screen_pos, on_screen = camera:WorldToViewportPoint(current_nearest_plr.aimPart.Position)

        targetBox.Visible = on_screen
        targetBox.Position = (Vector2.new(screen_pos.X, screen_pos.Y) - (targetBox.Size / 2))

        if input_service:IsKeyDown(aim_config.KeyActivation) then
            local target_position = current_nearest_plr.aimPart.Position
            local horizontal_look = CFrame.lookAt(camera.CFrame.Position, target_position)

            camera.CFrame = camera.CFrame:Lerp(horizontal_look, aim_config.Smoothness)
        end
    else
        targetBox.Visible = false
        targetBox.Position = Vector3.zero
    end
end)

input_service.InputBegan:Connect(function(input)
    if input.KeyCode == aim_config.KeyActivation then
        aim_config.Enabled = not aim_config.Enabled
    end
end)


