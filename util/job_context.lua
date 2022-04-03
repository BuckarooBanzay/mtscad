

function mtscad.create_job_context()
    local queue = {}
    local queue_pos = 1
    local done_callbacks = {}

    local function worker()
        local job = queue[queue_pos]
        if not job then
            -- all done
            for _, fn in ipairs(done_callbacks) do
                fn(#queue)
            end
            return
        end

        local success, exec_err = pcall(job)
        if not success then
            for _, fn in ipairs(done_callbacks) do
                fn(nil, exec_err)
            end
            return
        end

        -- increment queue-pos
        queue_pos = queue_pos + 1

        -- re-schedule
        minetest.after(0.1, worker)
    end

    return {
        queue = queue,
        enqueue = function(fn)
            table.insert(queue, fn)
        end,
        register_on_done = function(fn)
            table.insert(done_callbacks, fn)
        end,
        process = function()
            minetest.after(0.1, worker)
        end
    }
end