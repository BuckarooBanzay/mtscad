
local path = minetest.get_worldpath() .. "/mtscad"
minetest.mkdir(path)

function mtscad.require_mod(name)
    if not minetest.get_modpath(name) then
        error("required mod not present: '" .. name .. "'")
    end
end

function mtscad.load_module(modulename)
    local env = {
        -- debug
        print = print,
        dump = dump,
        -- builtin / default
        math = math,
        ipairs = ipairs,
        table = {
            insert = table.insert
        },
        -- custom functions
        mtscad = {
            merge = mtscad.merge,
            require_mod = mtscad.require_mod,
            load_module = mtscad.load_module
        }
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