mtscad.Context = {}
local Context_mt = { __index = mtscad.Context }

-- copy the current context
function mtscad.Context:clone()
    return mtscad.create_context(self)
end

local function create_job_context()
    local queue = {}
    local queue_pos = 1
    local done_callbacks = {}

    local function worker()
        if queue_pos > #queue then
            -- all done
            for _, fn in ipairs(done_callbacks) do
                fn(#queue)
            end
            return
        end

        local job = queue[queue_pos]
        queue_pos = queue_pos + 1
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

-- create a new context with given (optional) params
function mtscad.create_context(opts)
    local job_context = opts.job_context or create_job_context()

    local self = {
        pos = opts.pos and vector.copy(opts.pos) or vector.zero(),
        rotation = opts.rotation and vector.copy(opts.rotation) or vector.zero(),
        nodefactory = opts.nodefactory,
        param2 = opts.param2 or 0,
        job_context = job_context
    }
    return setmetatable(self, Context_mt)
end
