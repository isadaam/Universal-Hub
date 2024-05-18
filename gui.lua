local Rayfield = game:HttpGet("https://raw.githubusercontent.com/carolesdaughter/Roblox-Rayfield-UI/main/Source.lua", true)

local Library = loadstring(Rayfield)()

local Window = Library:CreateWindow({
    Name = "Adam Hub",
    LoadingTitle = "Adam is an idiot",
    ConfigurationSaving = {
      Enabled = false,
      FolderName = nil,
      FileName = "Adam hub"
   },
   Discord = {
      Enabled = false,
      Invite = "", 
      RememberJoins = true
   },
   KeySystem = false
})

local Main = Window:CreateTab("Main")

local function executeScript(url)
    local success, result = pcall(function()
        loadstring(game:HttpGet(url))()
    end)
    if success then
        print("Script loaded successfully from URL:", url)
    else
        warn("Failed to load script from URL:", url)
    end
end

local AimbotButton = Main:CreateButton({
    Name = "Aimbot Script",
    Callback = function()
        executeScript("https://raw.githubusercontent.com/isadaam/Universal-Hub/main/roblox.lua")
    end
})

local TrollButton = Main:CreateButton({
    Name = "Troll Script",
    Callback = function()
        executeScript("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source")
        executeScript("https://raw.githubusercontent.com/isadaam/Universal-Hub/main/fling.lua")
    end
})
