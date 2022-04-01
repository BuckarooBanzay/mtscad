
local path = minetest.get_worldpath() .. "/mtscad"
minetest.mkdir(path)

local function load_module(modulename)
    local env = {
        print = print,
        dump = dump,
        load = load_module,
        math = math,
        ipairs = ipairs,
        table = {
            insert = table.insert
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

local function merge_defaults(t, defaults)
    for k, v in pairs(defaults) do
        if not t[k] then
            t[k] = v
        end
    end
end

minetest.register_chatcommand("scad", {
    func = function(name, modulename)
        local origin = mtscad.get_origin(name)
        if not origin then
            return false, "Set your origin point first with /origin"
        end
        local start = minetest.get_us_time()
        local ctx = mtscad.create_context({
            pos = origin
        }, function()
            local ms_diff = minetest.get_us_time() - start
            minetest.chat_send_player(name, "File asynchronously executed in " .. math.floor(ms_diff/1000) .. " ms")
        end)

        local fn, options
        local success, exec_err = pcall(function()
            fn, options = load_module(modulename)
        end)
        if not success then
            return false, "Load failed with '" .. exec_err .. "'"
        end
        if not fn then
            return false, "No script loaded"
        end

        success, exec_err = pcall(function()
            local opts = {}
            if type(options) == "table" then
                if type(options.defaults) == "table" then
                    merge_defaults(opts, options.defaults)
                end
            end

            if type(fn) == "function" then
                fn(ctx, opts)
            end
        end)

        if not success then
            return false, "Execute failed with '" .. exec_err .. "'"
        end

        if ctx.job_context.count > 0 then
            return true, "Job dispatched"
        else
            local ms_diff = minetest.get_us_time() - start
            return true, "File synchronously executed in " .. math.floor(ms_diff/1000) .. " ms"
        end
    end
})