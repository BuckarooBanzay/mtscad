
local path = minetest.get_worldpath() .. "/mtscad"
minetest.mkdir(path)

local function load_module(modulename)
    local env = {
        print = print,
        dump = dump,
        load = load_module
    }

    local fn, err_msg = loadfile(path .. "/" .. modulename .. ".lua")
    if not fn or err_msg then
        error(err_msg)
    end
    local def = setfenv(fn, env)

    if not def then
        error("Loading of '" .. modulename .. "' failed")
    end

    return def()
end

local function merge_defaults(t, defaults)
    for k, v in pairs(defaults) do
        if not t[k] then
            t[k] = v
        end
    end
end

minetest.register_chatcommand("scad", {
    func = function(name, modulename)
        local player = minetest.get_player_by_name(name)
        local ppos = player:get_pos()
        local ctx = mtscad.create_context(vector.round(ppos))

        local mod
        local success, exec_err = pcall(function()
            mod = load_module(modulename)
        end)
        if not success then
            return false, "Load failed with '" .. exec_err .. "'"
        end
        if not mod then
            return false, "No script loaded"
        end

        success, exec_err = pcall(function()
            if type(mod) == "function" then
                mod(ctx)
            elseif type(mod) == "table" then
                local opts = {}
                if type(mod.defaults) == "table" then
                    merge_defaults(opts, mod.defaults)
                end

                mod.main(ctx, opts)
            end
        end)

        if not success then
            return false, "Execute failed with '" .. exec_err .. "'"
        end

        return true, "File successfully executed"
    end
})