
local path = minetest.get_worldpath() .. "/mtscad"
minetest.mkdir(path)

local function safe_load(modulename)
    local env = {
        print = print,
        dump = dump,
        load = safe_load
    }

    local def, load_err = setfenv(loadfile(path .. "/" .. modulename .. ".lua"), env)
    if not def then
        return nil, "Loading failed with '" .. load_err .. "'"
    end

    local fn
    local success, exec_err = pcall(function()
        fn = def()
    end)

    if not success then
        return nil, "Exec failed with: '" .. exec_err .. "'"
    end

    return fn
end

minetest.register_chatcommand("scad", {
    func = function(name, modulename)
        local player = minetest.get_player_by_name(name)
        local ppos = player:get_pos()
        local ctx = mtscad.create_context(vector.round(ppos))

        local fn, err_msg = safe_load(modulename)
        if not fn then
            return false, err_msg
        end

        local success, exec_err = pcall(function()
            fn(ctx)
        end)

        if not success then
            return false, "Execute failed with '" ..exec_err .. "'"
        end

        return true, "File successfully executed"
    end
})