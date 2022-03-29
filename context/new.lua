mtscad.Context = {}
local Context_mt = { __index = mtscad.Context }

-- copy the current context
function mtscad.Context:clone()
    return mtscad.create_context(self)
end

-- create a new context with given (optional) params
function mtscad.create_context(opts)
    local self = {
        pos = opts.pos and vector.copy(opts.pos) or vector.zero(),
        rotation = opts.rotation and vector.copy(opts.rotation) or vector.zero(),
        nodefactory = opts.nodefactory,
        param2 = opts.param2 or 0
    }
    return setmetatable(self, Context_mt)
end
