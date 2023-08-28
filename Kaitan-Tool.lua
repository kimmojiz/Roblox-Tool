repeat task.wait() until game:IsLoaded() and Nexus
repeat wait() until game.Players
repeat wait() until game.Players.LocalPlayer
repeat wait() until game.ReplicatedStorage
repeat wait() until game.ReplicatedStorage:FindFirstChild("Remotes");
repeat wait() until game.Players.LocalPlayer:FindFirstChild("PlayerGui");
repeat wait() until game.Players.LocalPlayer.PlayerGui:FindFirstChild("Main");

join = game.Players.localPlayer.Neutral == false
if _G.Team == nil then
    _G.Team = "Pirates"
end
_G.Team = "Pirates"
if (_G.Team == "Pirates" or _G.Team == "Marines") and not join then
    repeat wait()
        pcall(function()
            join = game.Players.localPlayer.Neutral == false
            if _G.Team == "Pirates" then
                for i,v in pairs({"MouseButton1Click", "MouseButton1Down", "Activated"}) do
                    for i,v in pairs(getconnections(game:GetService("Players").LocalPlayer.PlayerGui.Main.ChooseTeam.Container.Pirates.Frame.ViewportFrame.TextButton[v])) do
                        v.Function()
                    end
                end
            elseif _G.Team == "Marines" then
                for i,v in pairs({"MouseButton1Click", "MouseButton1Down", "Activated"}) do
                    for i,v in pairs(getconnections(game:GetService("Players").LocalPlayer.PlayerGui.Main.ChooseTeam.Container.Marines.Frame.ViewportFrame.TextButton[v])) do
                        v.Function()
                    end
                end
            else
                for i,v in pairs({"MouseButton1Click", "MouseButton1Down", "Activated"}) do
                    for i,v in pairs(getconnections(game:GetService("Players").LocalPlayer.PlayerGui.Main.ChooseTeam.Container.Marines.Frame.ViewportFrame.TextButton[v])) do
                        v.Function()
                    end
                end
            end
        end)
    until join == true
end

repeat task.wait() until Nexus.IsConnected and not game:GetService("Players").LocalPlayer.PlayerGui.Main:FindFirstChild("ChooseTeam")

local request = request or http_request or syn.request
local FileName = ("Green Tool/%s.json"):format(game.Players.LocalPlayer.Name)


function Notify(value)
    game.StarterGui:SetCore("SendNotification", {
        Title = "Green Tool", 
        Text = tostring(value),
        Icon = "http://www.roblox.com/asset/?id=9010576467",
        Duration = 10
    })
end

if not _G.WebServer then
    return Notify("Invalid WebServer.")
end

if not _G.WebServer["WebServerPort"] then
    return Notify("Invalid WebServerPort")
end

if not _G.WebServer["AutoDescription"] then
    _G.WebServer["AutoDescription"] = false
end

if not _G.WebServer["Delay"] or typeof(_G.WebServer["Delay"]) ~= "number" then
    _G.WebServer["Delay"] = 5
end

if not _G.WebServer["Description Content"] then
    _G.WebServer["Description Content"] = "{main}"
end

if not _G.WebServer["AutoAlias"] then
    _G.WebServer["AutoAlias"] = false
end

if not _G.WebServer["Alias Content"] then
    _G.WebServer["Alias Content"] = "Sheet: {has_sheet} | {level}"
end



function split (inputstr, sep)
    if sep == nil then
            sep = "%s"
    end
    local t={}
    for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
            table.insert(t, str)
    end
    return t
end

function World()
    if game.PlaceId == 2753915549 then
        return 1
    elseif game.PlaceId == 4442272183 then
        return 2
    elseif game.PlaceId == 7449423635 then
        return 3
    end
end

function FormatInt(number)
    local steps = {
        {1,""},
        {1e3,"K"},
        {1e6,"M"},
        {1e9,"G"},
        {1e12,"T"},
    }
    for _,b in ipairs(steps) do
        if b[1] <= number+1 then
            steps.use = _
        end
    end
    local result = string.format("%.1f", number / steps[steps.use][1])
    if tonumber(result) >= 1e3 and steps.use < #steps then
        steps.use = steps.use + 1
        result = string.format("%.1f", tonumber(result) / 1e3)
    end
    result = string.sub(result,0,string.sub(result,-1) == "0" and -3 or -1)
    return result .. steps[steps.use][2]
end

function FormatInt2(number)
    local i, j, minus, int, fraction = tostring(number):find('([-]?)(%d+)([.]?%d*)')
    int = int:reverse():gsub("(%d%d%d)", "%1,")
    return minus .. int:reverse():gsub("^,", "") .. fraction
end

function Money()
    return game:GetService("Players").LocalPlayer.Data.Beli.Value
end

function Fragment()
    return game:GetService("Players").LocalPlayer.Data.Fragments.Value
end

function Level()
    return game:GetService("Players").LocalPlayer.Data.Level.Value
end

function Race()
    local info = {
        Name = game:GetService("Players").LocalPlayer.Data.Race.Value,
        Tiers = game:GetService("Players").LocalPlayer.Data.Race.C.Value,
        Version = 0,
        Text = ""
    }

    local check1 = game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Alchemist","1")
    local check2 = game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Wenlocktoad","1")

    if check1 ~= -2 then
        info.Version = 1
    else
        info.Version = 2

        if check2 == -2 then
            info.Version = 3
                if game.Players.LocalPlayer.Character:FindFirstChild("RaceTransformed") then
                    info.Version = 4
                end
        end
    end

    if info.Version == 4 then
        info.Text = info.Name .. " ( V: ".. info.Version .. " | T: ".. info.Tiers .." )"
    else
        info.Text = info.Name .. " ( V: ".. info.Version .. ")"
    end

    return info
end

function CheckItem ()
    local Inventory = game:GetService("ReplicatedStorage").Remotes["CommF_"]:InvokeServer("getInventoryWeapons")
    local Inventory2 = game.Players.LocalPlayer.Character:GetChildren()
    local Inventory3 = game.Players.LocalPlayer.Backpack:GetChildren()

    local Item = {}

    if not _G.LogInventory or #_G.LogInventory == 0 then
        return "None"
    end

    for i,v in pairs(Inventory3) do
        if v:IsA("Tool") then
            if v.ToolTip == "Sword" then
                if  table.find(_G.LogInventory, v.Name) then
                    table.insert(Item, v.Name)
                end
            end
        end
    end

    for i,v in pairs(Inventory2) do
        if v:IsA("Tool") then
            if v.ToolTip == "Sword" then
                if  table.find(_G.LogInventory, v.Name) then
                    table.insert(Item, v.Name)
                end
            end
        end
    end
    
    for i,v in pairs(Inventory) do
        if table.find(_G.LogInventory, v.Name) then
            table.insert(Item, v.Name)
        end
    end
    
    if #Item == 0  then
        table.insert(Item, "None")
    end
    table.sort(Item)
    return Item
end

function CheckMelee()
    local melee = {}

    if game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuySuperhuman", true) == 1 then
        table.insert(melee, "Superhuman")
    end

    if game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyGodhuman", true) == 1 then
        table.insert(melee, "Godhuman")
    end

    if game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuySharkmanKarate", true) == 1 then
        table.insert(melee, "SharkMan")
    end

    if game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyDeathStep", true) == 1 then
        table.insert(melee, "DeathStep")
    end

    if game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyElectricClaw", true) == 1 then
        table.insert(melee, "ElectricV2")
    end

    if game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyDragonTalon", true) == 1 then
        table.insert(melee, "DragonV2")
    end

    if #melee == 0  then
        table.insert(melee, "None")
    end

    return melee
end

function getFruit()
    local Fruit = {
        ["Awake"] = {},
        ["Fruit"] = "None",
        ["Mastery"] = 0
    }
    local DevilFruit = game.Players.LocalPlayer.Data.DevilFruit.Value

    if #DevilFruit == 0 then
        return Fruit
    else
        Fruit["Fruit"] = (DevilFruit):match("%-(.+)")
    end

    if not game.Players.LocalPlayer.Character:FindFirstChild(DevilFruit) then
        Fruit["Mastery"] = game.Players.LocalPlayer.Backpack[DevilFruit].Level.Value
    else
        Fruit["Mastery"] = game.Players.LocalPlayer.Character[DevilFruit].Level.Value
    end
    
    local GetAwake = game:GetService("ReplicatedStorage").Remotes["CommF_"]:InvokeServer("getAwakenedAbilities")
    local IsAwake = game:GetService("ReplicatedStorage").Remotes["CommF_"]:InvokeServer("AwakeningChanger", "Check")

    if GetAwake and IsAwake then
        for i,v in pairs(GetAwake) do
            if v.Awakened then
                table.insert(Fruit["Awake"], i)
            end
        end
    end
    
    if #Fruit["Awake"] == 0 then
        Fruit["Awake"] = "None"
    end

    return Fruit
end

function RareFuit()
    local RareFruit = {}
    for i,v in pairs(game:GetService("ReplicatedStorage").Remotes["CommF_"]:InvokeServer("getInventoryFruits")) do
		if v.Price >= 1000000 then
		    table.insert(RareFruit, v.Name:match("%-(.+)"))
		end
    end

    if #RareFruit == 0  then
        table.insert(RareFruit, "None")
    end
    table.sort(RareFruit)
    return RareFruit
end

function fruit()
    local fruit = getFruit()

    if fruit["Fruit"] == "None" then
        fruit = "None"
    elseif (fruit["Awake"] == "None") then
        fruit = fruit["Fruit"].." ( M:"..fruit["Mastery"].." )"
    else
        fruit = fruit["Fruit"].." ( M: "..fruit["Mastery"].." | A: " .. #fruit["Awake"] .. " )"
    end

    return fruit
end

function Tagetlevel()
    local tagetlevel = Level()

    if tagetlevel >= 2450 then
        return "Max"
    else
        return FormatInt2(tagetlevel)
    end
end

function GetValuable()
    local Valuable = {}
    for i,v in pairs({"MouseButton1Click", "MouseButton1Down", "Activated"}) do
        for i,v in pairs(getconnections(game:GetService("Players").LocalPlayer.PlayerGui.Main.InventoryContainer.Right.Content.Sort.Dropdown.Valuable[v])) do
            v.Function()
        end
    end
    
    local item = game:GetService("Players").LocalPlayer.PlayerGui.Main.InventoryContainer.Right.Content.ScrollingFrame.Frame:GetChildren()
    
    for i,v in pairs(item) do
        for i1, v2 in pairs(v:GetChildren()) do
            if v2.Name == "ItemName" then
                table.insert(Valuable, v2.Text)
            end
        end
    end

    return Valuable
end

function Main()
    local main = {}

    if table.find(_G.Main, "6 Melee") and #CheckMelee() == 6 then
        table.insert(main, "6 Melee")
    end
    if table.find(_G.Main, "Dough Awake") and (getFruit())["Fruit"] == "Dough" and #(getFruit())["Awake"] == 6 then
        table.insert(main, "Dough Awake")
    end
    if table.find(_G.Main, "Leophard") and (getFruit())["Fruit"] == "Leophard" then
        table.insert(main, "Leophard")
    end
    if table.find(_G.Main, "Dragon") and (getFruit())["Fruit"] == "Dragon" then
        table.insert(main, "Dragon")
    end 
    if table.find(_G.Main, "Cursed Dual Katana") then
        table.insert(main, "CDK")
    end
    if table.find(_G.Main, "Hallow Scythe") then
        table.insert(main, "HS")
    end
    if table.find(_G.Main, "Leaver") and game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("CommF_"):InvokeServer("CheckTempleDoor") then
        table.insert(main, "Leaver")
    end
    if table.find(_G.Main, "Mirror") and table.find(GetValuable(), "Mirror Fractal") then
        table.insert(main, "Mirror")
    end

    return main
end

function has_sheet()
    local has_bestsheet = false

    if not isfolder('Green Tool') then
        makefolder('Green Tool')
    end

    if not isfile(FileName) then
        writefile(FileName, game:GetService("HttpService"):JSONEncode({ sheet = false }))
    else
        has_bestsheet = game:GetService("HttpService"):JSONDecode(readfile(FileName))["sheet"]
    end

    return has_bestsheet
end

function Text(content)
    return content:gsub("{level}", Tagetlevel())
    :gsub("{world}", tostring(World()))
    :gsub("{inventory}", table.concat(CheckItem (), ", "))
    :gsub("{main}", table.concat(Main(), ", "))
    :gsub("{melee}", table.concat(CheckMelee(), ", "))
    :gsub("{melee_amount}", tostring(#CheckMelee()))
    :gsub("{rare_fruit}", table.concat(RareFuit(), ", "))
    :gsub("{fruit}", (getFruit())["Fruit"])
    :gsub("{fruit_awake}", (getFruit())["Awake"])
    :gsub("{fruit_mastery}", tostring((getFruit())["Mastery"]))
    :gsub("{race}",(Race()).Name)
    :gsub("{race_version}", (Race()).Version)
    :gsub("{money}", FormatInt2(Money()))
    :gsub("{money_format}", FormatInt(Money()))
    :gsub("{fragment}", FormatInt2(Fragment()))
    :gsub("{fragment_format}", FormatInt(Fragment()))
    :gsub("{name}", game.Players.LocalPlayer.Name)
    :gsub("{has_sheet}", tostring(has_sheet()));
end

function LogSheet()
    return request({
        Url = _G.SheetBest,
        Method = "POST",
        Headers = {
            ["Content-Type"] = "application/json"
        },
        Body = game:GetService("HttpService"):JSONEncode({
            ["Main"] = table.concat(Main(), ", "),
            ["World"] = World(),
            ["Level"] = Tagetlevel(),
            ["Inventory"] = table.concat(CheckItem (), ", "),
            ["Melee"] = table.concat(CheckMelee (), ", "),
            ["RareFruit"] = table.concat(RareFuit(), ", "),
            ["Fruit"] = fruit(),
            ["Race"] = (Race()).Text,
            ["Money"] = FormatInt(Money()),
            ["Fragment"] = FormatInt(Fragment()),
            ["Account"] = game.Players.LocalPlayer.Name,
        })
    })
end

function SetDescription(username, content)
    return request({
        Url = "http://localhost:".._G.WebServer["WebServerPort"].."/SetDescription?Account=".. username,
        Method = "POST",
        Body = content
    })
end

function SetAlias(username, content)
    return request({
        Url = "http://localhost:".._G.WebServer["WebServerPort"].."/SetAlias?Account=".. username,
        Method = "POST",
        Body = content
    })
end

function tosheet() 
    if not _G.SheetBest then
        return Notify("Invalid sheet best URL.")
    end

    local res = LogSheet()

    request({
        Url = "http://localhost:"..tostring(_G.WebServer["WebServerPort"]).."/SetAlias?Account=".. game.Players.LocalPlayer.Name,
        Method = "POST",
        Body = "Sheet: "..tostring(res.Success)
    })

    if res.StatusCode ~= 200 then
        return Notify("Sheet Best Error Code: ".. res.StatusCode)
    else
        writefile(FileName, game:GetService("HttpService"):JSONEncode({ sheet = true })) 
        SetAlias(game.Players.LocalPlayer.Name, "Log success.")
    end
end
Nexus:CreateLabel('GreenLabel', '=== Green Tool ===')
Nexus:NewLine()
Nexus:CreateButton('Rejoin', 'REJOIN', { 125, 25 }, { 3, 3, 3, 3 })
Nexus:CreateButton('Sheetbest', 'SHEET BEST', { 125, 25 }, { 3, 3, 3, 3 })
Nexus:OnButtonClick('Sheetbest', function() tosheet() end)
Nexus:OnButtonClick('Rejoin', function() game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, game.JobId) end)

spawn(function()
    pcall(function()

        if _G.WebServer["AutoAlias"] then
            while task.wait(_G.WebServer["Delay"]) do
                local res = SetAlias(game.Players.LocalPlayer.Name, Text(_G.WebServer["Alias Content"]))

                if res.StatusCode ~= 200 then
                    return Notify("Set Alias: ".. res.Body)
                end
            end
        end
    end)
end)

spawn(function()
    pcall(function()
        if _G.WebServer["AutoDescription"] then
            while task.wait(_G.WebServer["Delay"]) do
                local res = SetDescription(game.Players.LocalPlayer.Name, Text(_G.WebServer["Description Content"]))

                if res.StatusCode ~= 200 then
                    return Notify("Set Description: ".. res.Body)
                end
            end
        end
    end)
end)
