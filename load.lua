
local path = minetest.get_worldpath() .. "/mtscad"
minetest.mkdir(path)

-- TODO: proper error-handling
local function safe_load(modulename)
    local env = {
        print = print,
        dump = dump,
        load = safe_load
    }

    local def, load_err
    local success, exec_err = pcall(function()
        def, load_err = setfenv(loadfile(path .. "/" .. modulename .. ".lua"), env)
    end)
    if not success then
        return nil, "Load of '" .. modulename .. "' failed with: '" .. exec_err .. "'"
    elseif not def then
        return nil, "Module '" .. modulename .. "' returned no function on load"
    end

    if not def then
        return nil, "Loading of '" .. modulename .. "' failed with '" .. load_err .. "'"
    end

    local fn
    success, exec_err = pcall(function()
        fn = def()
    end)

    if not success then
        return nil, "Exec of '" .. modulename .. "' failed with: '" .. exec_err .. "'"
    elseif not fn then
        return nil, "Module '" .. modulename .. "' returned no function"
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
            return false, "Execute failed with '" .. exec_err .. "'"
        end

        return true, "File successfully executed"
    end
})