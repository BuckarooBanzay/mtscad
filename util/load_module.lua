
local path = minetest.get_worldpath() .. "/mtscad"
minetest.mkdir(path)

function mtscad.load_module(modulename)
    local env = {
        -- debug
        print = print,
        dump = dump,
        -- module loading
        load = mtscad.load_module,
        -- builtin / default
        math = math,
        ipairs = ipairs,
        table = {
            insert = table.insert
        },
        -- custom functions
        merge_table = mtscad.merge
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