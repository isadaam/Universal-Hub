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
        Note = "Dm isadaam on discord for the key",
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
local fpsBoosterScriptURL = "https://raw.githubusercontent.com/isadaam/Universal-Hub/main/fpsbooster.lua"
local goodHubScriptURL = "https://shz.al/~mobile-hub"
local skyHubScriptURL = "https://raw.githubusercontent.com/yofriendfromschool1/Sky-Hub/main/SkyHub.txt"

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

-- FPS Booster Script Button
ScriptsTab:CreateButton({
    Name = "Execute FPS Booster Script",
    Info = "Executes the FPS Booster script from the provided URL",
    Callback = function()
        local success, err = pcall(function()
            loadstring(game:HttpGet(fpsBoosterScriptURL))()
        end)
        if success then
            Rayfield:Notify({
                Title = "Success",
                Content = "Successfully executed FPS Booster Script",
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
                Content = "Failed to execute FPS Booster Script: " .. err,
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

-- Good Hub Script Button
ScriptsTab:CreateButton({
    Name = "Execute Good Hub Script",
    Info = "Executes the Good Hub script from the provided URL",
    Callback = function()
        local success, err = pcall(function()
            loadstring(game:HttpGet(goodHubScriptURL))()
        end)
        if success then
            Rayfield:Notify({
                Title = "Success",
                Content = "Successfully executed Good Hub Script",
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
                Content = "Failed to execute Good Hub Script: " .. err,
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

-- SkyHub Script Button
ScriptsTab:CreateButton({
    Name = "Execute SkyHub Script",
    Info = "Executes the SkyHub script from the provided URL",
    Callback = function()
        local success, err = pcall(function()
            loadstring(game:HttpGet(skyHubScriptURL))()
        end)
        if success then
            Rayfield:Notify({
                Title = "Success",
                Content = "Successfully executed SkyHub Script",
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
                Content = "Failed to execute SkyHub Script: " .. err,
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

-- Create Section for NoClip
local NoClipSection = UtilityTab:CreateSection("NoClip Settings")

-- NoClip Functionality
local noclip = false
local player = game.Players.LocalPlayer
local mouse = player:GetMouse()

local function startNoClip()
    noclip = true
    local character = player.Character or player.CharacterAdded:Wait()
    for _, v in pairs(character:GetDescendants()) do
        if v:IsA("BasePart") and v.CanCollide then
            v.CanCollide = false
        end
    end
    game:GetService("RunService").Stepped:Connect(function()
        if noclip then
            for _, v in pairs(character:GetDescendants()) do
                if v:IsA("BasePart") and v.CanCollide then
                    v.CanCollide = false
                end
            end
        end
    end)
end

local function stopNoClip()
    noclip = false
    local character = player.Character or player.CharacterAdded:Wait()
    for _, v in pairs(character:GetDescendants()) do
        if v:IsA("BasePart") and not v.CanCollide then
            v.CanCollide = true
        end
    end
end

-- NoClip Button
UtilityTab:CreateButton({
    Name = "Toggle NoClip",
    Info = "Enable or disable NoClip mode",
    Callback = function()
        if noclip then
            stopNoClip()
            Rayfield:Notify({
                Title = "NoClip Disabled",
                Content = "You have disabled NoClip mode",
                Duration = 5,
                Image = 4483362458,
                Actions = {
                    Okay = {
                        Name = "Okay",
                        Callback = function()
                            print("NoClip mode disabled")
                        end
                    }
                }
            })
        else
            startNoClip()
            Rayfield:Notify({
                Title = "NoClip Enabled",
                Content = "You have enabled NoClip mode",
                Duration = 5,
                Image = 4483362458,
                Actions = {
                    Okay = {
                        Name = "Okay",
                        Callback = function()
                            print("NoClip mode enabled")
                        end
                    }
                }
            })
        end
    end
})

-- NoClip Keybind
UtilityTab:CreateKeybind({
    Name = "Toggle NoClip (Keybind)",
    CurrentKeybind = "N",
    HoldToInteract = false,
    Flag = "NoClipKeybind",
    Callback = function()
        if noclip then
            stopNoClip()
            Rayfield:Notify({
                Title = "NoClip Disabled",
                Content = "You have disabled NoClip mode",
                Duration = 5,
                Image = 4483362458,
                Actions = {
                    Okay = {
                        Name = "Okay",
                        Callback = function()
                            print("NoClip mode disabled")
                        end
                    }
                }
            })
        else
            startNoClip()
            Rayfield:Notify({
                Title = "NoClip Enabled",
                Content = "You have enabled NoClip mode",
                Duration = 5,
                Image = 4483362458,
                Actions = {
                    Okay = {
                        Name = "Okay",
                        Callback = function()
                            print("NoClip mode enabled")
                        end
                    }
                }
            })
        end
    end
})

-- Create Section for Utility Features
local UtilityFeaturesSection = UtilityTab:CreateSection("Utility Features")

-- Rejoin Button
UtilityTab:CreateButton({
    Name = "Rejoin",
    Info = "Rejoin the current game",
    Callback = function()
        local ts = game:GetService("TeleportService")
        local p = game:GetService("Players").LocalPlayer
        ts:Teleport(game.PlaceId, p)
    end
})

-- Teleport to Player
UtilityTab:CreateInput({
    Name = "Teleport to Player",
    PlaceholderText = "Enter player name",
    Flag = "TeleportPlayerInput",
    Callback = function(playerName)
        local targetPlayer = game.Players:FindFirstChild(playerName)
        if targetPlayer and targetPlayer.Character and targetPlayer.Character:FindFirstChild("HumanoidRootPart") then
            player.Character:MoveTo(targetPlayer.Character.HumanoidRootPart.Position)
            Rayfield:Notify({
                Title = "Teleport Success",
                Content = "Teleported to " .. playerName,
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
                Title = "Teleport Failed",
                Content = "Player not found or not accessible",
                Duration = 5,
                Image = 4483362458,
                Actions = {
                    Okay = {
                        Name = "Okay",
                        Callback = function()
                            print("User acknowledged the failure notification")
                        end
                    }
                }
            })
        end
    end
})

-- Destroy GUI Button
UtilityTab:CreateButton({
    Name = "Destroy GUI",
    Info = "Destroy the entire GUI",
    Callback = function()
        Rayfield:Destroy()
    end
})

-- Load the configuration at the end
Rayfield:LoadConfiguration()
print("Make by Adam good luck to skidder!")
