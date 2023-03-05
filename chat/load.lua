
local has_worldedit = minetest.get_modpath("worldedit")

-- playername -> opts
local player_opts = {}

minetest.register_chatcommand("scad_opts", {
    func = function(name, params)
        if params ~= "" then
            local opts = minetest.deserialize("return " .. params)
            if opts then
                player_opts[name] = opts
                return true, "Options set"
            else
                return true, "Invalid options"
            end
        else
            player_opts[name] = nil
            return true, "Options cleared"
        end
    end
})

minetest.register_chatcommand("scad", {
    func = function(name, modulename)
        local origin = mtscad.get_origin(name)
        if not origin then
            return false, "Set your origin point first with /scad_origin"
        end
        local start = minetest.get_us_time()
        local ctx = mtscad.create_context({ pos = origin })

        local fn
        local success, exec_err = pcall(function()
            fn = mtscad.load_module(modulename)
        end)
        if not success then
            return false, "Load failed with '" .. exec_err .. "'"
        end
        if type(fn) ~= "function" then
            return false, "No script loaded"
        end

        success, exec_err = pcall(function()
            fn(ctx, player_opts[name])
        end)

        if not success then
            return false, "Execute failed with '" .. exec_err .. "'"
        end


        ctx.job_context.register_on_done(function(job_count, err_msg)
            if err_msg then
                minetest.chat_send_player(name, "Execution failed with '" .. err_msg .. "'")
            else
                local ms_diff = math.floor((minetest.get_us_time() - start) / 1000)
                minetest.chat_send_player(name, "File executed in " .. ms_diff .. " ms with " .. job_count .. " jobs")
                if has_worldedit then
                    -- update we positions
                    worldedit.pos1[name] = ctx.session.min
                    worldedit.pos2[name] = ctx.session.max
                    worldedit.mark_pos1(name)
                    worldedit.mark_pos2(name)
                end
            end
        end)
        ctx.job_context.process()
        return true, "Job dispatched"
    end
})