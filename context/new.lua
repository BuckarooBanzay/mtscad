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
        mirror_pos = opts.mirror_pos and vector.copy(opts.mirror_pos) or vector.new(1,1,1),
        rotation = opts.rotation or mtscad.rotation_matrix_x(0),
        node_spec = opts.node_spec or { name = "air" },
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
