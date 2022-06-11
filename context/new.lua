mtscad.Context = {}
local Context_mt = { __index = mtscad.Context }

-- copy the current context
function mtscad.Context:clone()
    return mtscad.create_context(self)
end


-- create a new context with given (optional) params
function mtscad.create_context(opts)
    local job_context = opts.job_context or mtscad.create_job_context()

    local self = {
        pos = opts.pos and vector.copy(opts.pos) or vector.zero(),
        rotation = opts.rotation or mtscad.rotation_matrix_x(0),
        nodefactory = opts.nodefactory,
        param2 = opts.param2 or 0,
        job_context = job_context,
        -- global session info
        session = opts.session or {
            -- max/min extents
            max = vector.copy(opts.pos),
            min = vector.copy(opts.pos)
        }
    }
    return setmetatable(self, Context_mt)
end
