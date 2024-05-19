-- Enable Secure Mode
getgenv().SecureMode = true

-- Load Rayfield Library
local Rayfield = loadstring(game:HttpGet('https://raw.githubusercontent.com/UI-Interface/CustomFIeld/main/RayField.lua'))()

-- Set Theme
Rayfield:SetTheme({
    Background = Color3.fromRGB(24, 24, 24),
    Glow = Color3.fromRGB(0, 120, 215),
    Accent = Color3.fromRGB(40, 40, 40),
    LightContrast = Color3.fromRGB(60, 60, 60),
    DarkContrast = Color3.fromRGB(20, 20, 20),
    TextColor = Color3.fromRGB(255, 255, 255)
})

-- Create Window
local Window = Rayfield:CreateWindow({
    Name = "Adam Hub",
    LoadingTitle = "Loading Adam Hub...",
    LoadingSubtitle = "by Adam",
    ConfigurationSaving = {
        Enabled = true,
        FolderName = "AdamHub", -- Custom folder name
        FileName = "AdamHubConfig"
    },
    Discord = {
        Enabled = false,
        Invite = "", -- Discord invite code
        RememberJoins = true
    },
    KeySystem = true,
    KeySettings = {
        Title = "Adam Hub",
        Subtitle = "Key System",
        Note = "Enter the key to access Adam Hub",
        FileName = "AdamHubKey",
        SaveKey = true,
        GrabKeyFromSite = false,
        Key = "Adam"
    }
})

-- Create Tabs
local ScriptTab = Window:CreateTab("Scripts", 4483362458)
local UtilityTab = Window:CreateTab("Utilities", 4483362458)
local ThemeTab = Window:CreateTab("Theme", 4483362458)
local InfoTab = Window:CreateTab("Info", 4483362458)

-- Script URLs
local aimbotScriptURL = "https://raw.githubusercontent.com/isadaam/Universal-Hub/main/roblox.lua"
local trollScriptURLs = {
    "https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source",
    "https://raw.githubusercontent.com/isadaam/Universal-Hub/main/fling.lua"
}

-- Script Section
local ScriptSection = ScriptTab:CreateSection("Script Execution", false)

ScriptSection:CreateButton({
    Name = "Execute Aimbot Script",
    Info = "Execute the aimbot script from the provided URL",
    Callback = function()
        local success, result = pcall(function()
            return loadstring(game:HttpGet(aimbotScriptURL))()
        end)
        if success then
            Rayfield:Notify({
                Title = "Success",
                Content = "Successfully executed Aimbot script!",
                Duration = 5,
                Image = 4483362458,
                Actions = {
                    Okay = {
                        Name = "Okay!",
                        Callback = function()
                            print("Aimbot script executed.")
                        end
                    }
                }
            })
        else
            warn("Failed to execute Aimbot script:", result)
        end
    end
})

ScriptSection:CreateButton({
    Name = "Execute Troll Script",
    Info = "Execute the troll scripts from the provided URLs",
    Callback = function()
        for _, url in ipairs(trollScriptURLs) do
            local success, result = pcall(function()
                return loadstring(game:HttpGet(url))()
            end)
            if success then
                Rayfield:Notify({
                    Title = "Success",
                    Content = "Successfully executed Troll script from " .. url,
                    Duration = 5,
                    Image = 4483362458,
                    Actions = {
                        Okay = {
                            Name = "Okay!",
                            Callback = function()
                                print("Troll script executed from " .. url)
                            end
                        }
                    }
                })
            else
                warn("Failed to execute Troll script from " .. url, result)
            end
        end
    end
})

-- Utility Section
local UtilitySection = UtilityTab:CreateSection("Utilities", false)

UtilitySection:CreateButton({
    Name = "Reset Character",
    Info = "Reset your character in the game",
    Callback = function()
        game.Players.LocalPlayer.Character:BreakJoints()
    end
})

UtilitySection:CreateButton({
    Name = "Teleport to Spawn",
    Info = "Teleport your character to the spawn location",
    Callback = function()
        local player = game.Players.LocalPlayer
        if player.Character then
            player.Character:SetPrimaryPartCFrame(CFrame.new(workspace.SpawnLocation.Position))
        end
    end
})

UtilitySection:CreateSlider({
    Name = "Walk Speed",
    Info = "Adjust your character's walk speed",
    Range = {16, 100},
    Increment = 1,
    Suffix = "Walk Speed",
    CurrentValue = 16,
    Callback = function(value)
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = value
    end
})

UtilitySection:CreateSlider({
    Name = "Jump Power",
    Info = "Adjust your character's jump power",
    Range = {50, 200},
    Increment = 1,
    Suffix = "Jump Power",
    CurrentValue = 50,
    Callback = function(value)
        game.Players.LocalPlayer.Character.Humanoid.JumpPower = value
    end
})

-- Theme Section
local ThemeSection = ThemeTab:CreateSection("Customize Theme", false)

local themes = {
    Background = Color3.fromRGB(24, 24, 24),
    Glow = Color3.fromRGB(0, 120, 215),
    Accent = Color3.fromRGB(40, 40, 40),
    LightContrast = Color3.fromRGB(60, 60, 60),
    DarkContrast = Color3.fromRGB(20, 20, 20),
    TextColor = Color3.fromRGB(255, 255, 255)
}

for theme, color in pairs(themes) do
    ThemeSection:CreateColorPicker({
        Name = theme,
        Color = color,
        Callback = function(color3)
            Rayfield:SetTheme(theme, color3)
        end
    })
end

-- Info Section
local InfoSection = InfoTab:CreateSection("Information", false)

InfoSection:CreateLabel("Welcome to Adam Hub!")
InfoSection:CreateLabel("This GUI allows you to execute various scripts and customize settings.")
InfoSection:CreateParagraph({Title = "Instructions", Content = "Use the tabs to navigate between different sections and customize your experience."})
InfoSection:CreateButton({
    Name = "Join Discord",
    Info = "Join our community Discord server",
    Callback = function()
        setclipboard("https://discord.gg/sirius")
        Rayfield:Notify({
            Title = "Discord Invite",
            Content = "Discord invite link copied to clipboard!",
            Duration = 5,
            Image = 4483362458,
            Actions = {
                Okay = {
                    Name = "Okay!",
                    Callback = function()
                        print("Discord invite link copied.")
                    end
                }
            }
        })
    end
})

-- Load Configuration
Rayfield:LoadConfiguration()
