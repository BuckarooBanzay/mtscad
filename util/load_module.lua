
local path = minetest.get_worldpath() .. "/mtscad"
minetest.mkdir(path)

function mtscad.require_mod(name)
    if not minetest.get_modpath(name) then
        error("required mod not present: '" .. name .. "'")
    end
end

function mtscad.load_module(modulepath)
    local context_aware_load_module = function(name)
        local index = string.find(modulepath, "/[^/]*$")
        if index then
            -- prepend current directory to import path
            name = string.sub(modulepath, 1, index) .. name
        end

        return mtscad.load_module(name)
    end

    local env = {
        -- debug
        print = print,
        dump = dump,
        -- builtin / default
        math = math,
        vector = vector,
        ipairs = ipairs,
        assert = assert,
        table = {
            insert = table.insert
        },
        -- custom functions
        mtscad = {
            merge = mtscad.merge,
            require_mod = mtscad.require_mod,
            load_module = context_aware_load_module
        }
    }

    local fullpath = path .. "/" .. modulepath .. ".lua"
    local fn, err_msg = loadfile(fullpath)
    if not fn or err_msg then
        error(err_msg)
    end
    local def = setfenv(fn, env)

    if not def then
        error("Loading of '" .. fullpath .. "' failed")
    end

    return def()
end