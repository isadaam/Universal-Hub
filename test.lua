-- Load Rayfield Library
local Rayfield = loadstring(game:HttpGet('https://raw.githubusercontent.com/UI-Interface/CustomFIeld/main/RayField.lua'))()

-- Create Window
local Window = Rayfield:CreateWindow({
    Name = "Adam Hub",
    LoadingTitle = "Loading Adam Hub",
    LoadingSubtitle = "Please wait...",
    ConfigurationSaving = {
        Enabled = true,
        FolderName = "AdamHub", -- Custom folder name for saving
        FileName = "AdamHubConfig"
    },
    Discord = {
        Enabled = false,
        Invite = "", -- No Discord invite
        RememberJoins = false -- Don't remember joins
    },
    KeySystem = true, -- Use key system
    KeySettings = {
        Title = "Adam Hub Key System",
        Subtitle = "Please enter the key",
        Note = "Join the Discord for the key",
        FileName = "AdamHubKey",
        SaveKey = true,
        GrabKeyFromSite = false,
        Key = "Adam"
    }
})

-- Create Scripts Tab
local ScriptsTab = Window:CreateTab("Scripts", 4483362458) -- Tab for scripts

-- Create Section for the scripts
local ScriptsSection = ScriptsTab:CreateSection("Execute Scripts")

-- Define URLs for scripts
local aimbotScriptURL = "https://raw.githubusercontent.com/isadaam/Universal-Hub/main/roblox.lua"
local trollScriptURLs = {
    "https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source",
    "https://raw.githubusercontent.com/isadaam/Universal-Hub/main/fling.lua"
}
local fpsScriptURLs = "https://raw.githubusercontent.com/isadaam/Universal-Hub/main/fpsbooster.lua"

-- Aimbot Script Button
ScriptsTab:CreateButton({
    Name = "Execute Aimbot Script",
    Info = "Executes the Aimbot script from the provided URL",
    Callback = function()
        local success, err = pcall(function()
            loadstring(game:HttpGet(aimbotScriptURL))()
        end)
        if success then
            Rayfield:Notify({
                Title = "Success",
                Content = "Successfully executed Aimbot Script",
                Duration = 5,
                Image = 4483362458,
                Actions = {
                    Okay = {
                        Name = "Okay",
                        Callback = function()
                            print("User acknowledged the success notification")
                        end
                    }
                }
            })
        else
            Rayfield:Notify({
                Title = "Error",
                Content = "Failed to execute Aimbot Script: " .. err,
                Duration = 5,
                Image = 4483362458,
                Actions = {
                    Okay = {
                        Name = "Okay",
                        Callback = function()
                            print("User acknowledged the error notification")
                        end
                    }
                }
            })
        end
    end
})

-- Troll Script Button
ScriptsTab:CreateButton({
    Name = "Execute Troll Scripts",
    Info = "Executes the Troll scripts from the provided URLs",
    Callback = function()
        for _, url in ipairs(trollScriptURLs) do
            local success, err = pcall(function()
                loadstring(game:HttpGet(url))()
            end)
            if success then
                Rayfield:Notify({
                    Title = "Success",
                    Content = "Successfully executed Troll Script from URL: " .. url,
                    Duration = 5,
                    Image = 4483362458,
                    Actions = {
                        Okay = {
                            Name = "Okay",
                            Callback = function()
                                print("User acknowledged the success notification")
                            end
                        }
                    }
                })
            else
                Rayfield:Notify({
                    Title = "Error",
                    Content = "Failed to execute Troll Script from URL: " .. url .. "\nError: " .. err,
                    Duration = 5,
                    Image = 4483362458,
                    Actions = {
                        Okay = {
                            Name = "Okay",
                            Callback = function()
                                print("User acknowledged the error notification")
                            end
                        }
                    }
                })
            end
        end
    end
})

-- Troll Script Button
ScriptsTab:CreateButton({
    Name = "Execute FPS Booster Scripts",
    Info = "Executes the FPS booster scripts from the provided URLs",
    Callback = function()
        for _, url in ipairs(fpsScriptURLs) do
            local success, err = pcall(function()
                loadstring(game:HttpGet(url))()
            end)
            if success then
                Rayfield:Notify({
                    Title = "Success",
                    Content = "Successfully executed FPS booster Script from URL: " .. url,
                    Duration = 5,
                    Image = 4483362458,
                    Actions = {
                        Okay = {
                            Name = "Okay",
                            Callback = function()
                                print("User acknowledged the success notification")
                            end
                        }
                    }
                })
            else
                Rayfield:Notify({
                    Title = "Error",
                    Content = "Failed to execute FpsBooster Script from URL: " .. url .. "\nError: " .. err,
                    Duration = 5,
                    Image = 4483362458,
                    Actions = {
                        Okay = {
                            Name = "Okay",
                            Callback = function()
                                print("User acknowledged the error notification")
                            end
                        }
                    }
                })
            end
        end
    end
})

-- Create Utility Tab
local UtilityTab = Window:CreateTab("Utility", 4483362458) -- Tab for utility features

-- Create Section for WalkSpeed and JumpPower
local MovementSection = UtilityTab:CreateSection("Movement Settings")

-- WalkSpeed Slider
UtilityTab:CreateSlider({
    Name = "WalkSpeed",
    Info = "Adjust your character's walk speed",
    Range = {16, 300},
    Increment = 1,
    Suffix = "WalkSpeed",
    CurrentValue = 16,
    Flag = "WalkSpeed",
    Callback = function(Value)
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = Value
    end
})

-- JumpPower Slider
UtilityTab:CreateSlider({
    Name = "JumpPower",
    Info = "Adjust your character's jump power",
    Range = {50, 300},
    Increment = 1,
    Suffix = "JumpPower",
    CurrentValue = 50,
    Flag = "JumpPower",
    Callback = function(Value)
        game.Players.LocalPlayer.Character.Humanoid.JumpPower = Value
    end
})

-- Create Section for Fly
local FlySection = UtilityTab:CreateSection("Fly Settings")

-- Fly Functionality
local flying = false
local flySpeed = 50
local player = game.Players.LocalPlayer
local mouse = player:GetMouse()
local humanoid = player.Character:FindFirstChildOfClass("Humanoid")

local function startFly()
    if not humanoid then return end
    local bodyGyro = Instance.new("BodyGyro", humanoid)
    bodyGyro.P = 9e4
    bodyGyro.maxTorque = Vector3.new(9e9, 9e9, 9e9)
    bodyGyro.cframe = humanoid.CFrame

    local bodyVelocity = Instance.new("BodyVelocity", humanoid)
    bodyVelocity.velocity = Vector3.new(0, 0, 0)
    bodyVelocity.maxForce = Vector3.new(9e9, 9e9, 9e9)

    humanoid.PlatformStand = true
    flying = true

    while flying do
        bodyVelocity.velocity = ((workspace.CurrentCamera.CoordinateFrame.lookVector * flySpeed) + Vector3.new(0, flySpeed, 0))
        bodyGyro.cframe = workspace.CurrentCamera.CoordinateFrame
        wait()
    end

    bodyGyro:Destroy()
    bodyVelocity:Destroy()
    humanoid.PlatformStand = false
end

local function stopFly()
    flying = false
end

-- Fly Button
UtilityTab:CreateButton({
    Name = "Toggle Fly",
    Info = "Enable or disable fly mode",
    Callback = function()
        if flying then
            stopFly()
            Rayfield:Notify({
                Title = "Fly Disabled",
                Content = "You have disabled fly mode",
                Duration = 5,
                Image = 4483362458,
                Actions = {
                    Okay = {
                        Name = "Okay",
                        Callback = function()
                            print("Fly mode disabled")
                        end
                    }
                }
            })
        else
            startFly()
            Rayfield:Notify({
                Title = "Fly Enabled",
                Content = "You have enabled fly mode",
                Duration = 5,
                Image = 4483362458,
                Actions = {
                    Okay = {
                        Name = "Okay",
                        Callback = function()
                            print("Fly mode enabled")
                        end
                    }
                }
            })
        end
    end
})

-- Fly Keybind
UtilityTab:CreateKeybind({
    Name = "Toggle Fly (Keybind)",
    CurrentKeybind = "F",
    HoldToInteract = false,
    Flag = "FlyKeybind",
    Callback = function()
        if flying then
            stopFly()
            Rayfield:Notify({
                Title = "Fly Disabled",
                Content = "You have disabled fly mode",
                Duration = 5,
                Image = 4483362458,
                Actions = {
                    Okay = {
                        Name = "Okay",
                        Callback = function()
                            print("Fly mode disabled")
                        end
                    }
                }
            })
        else
            startFly()
            Rayfield:Notify({
                Title = "Fly Enabled",
                Content = "You have enabled fly mode",
                Duration = 5,
                Image = 4483362458,
                Actions = {
                    Okay = {
                        Name = "Okay",
                        Callback = function()
                            print("Fly mode enabled")
                        end
                    }
                }
            })
        end
    end
})

-- Load the configuration at the end
Rayfield:LoadConfiguration()
print("make by adam")
