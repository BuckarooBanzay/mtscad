

minetest.register_chatcommand("scad", {
    func = function(name, modulename)
        local origin = mtscad.get_origin(name)
        if not origin then
            return false, "Set your origin point first with /origin"
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
        if not fn then
            return false, "No script loaded"
        end

        success, exec_err = pcall(function()
            if type(fn) == "function" then
                fn(ctx)
            end
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
            end
        end)
        ctx.job_context.process()
        return true, "Job dispatched"
    end
})