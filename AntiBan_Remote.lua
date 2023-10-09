local gmt = getrawmetatable(game)
local old_call = gmt.__namecall
setreadonly(gmt, false)

gmt.__namecall = function(...)
    local args = {...}
    local method = getnamecallmethod()

    if method == "FireServer" and args[1].Name == "BanFlySpeed" then
        print("Don't try bannnnnn")
        return
    end
    return old_call(unpack(args))
end
