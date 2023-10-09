local gmt = getrawmetatable(game)
local old_call = gmt.__namecall
setreadonly(gmt, false)

gmt.__namecall = function(...)
    local args = {...}
    local method = getnamecallmethod()

    if method == "Kick" then
        print("Stop kick me...")
        return
    end
    return old_call(unpack(args))
end
