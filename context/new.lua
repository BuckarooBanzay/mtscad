mtscad.Context = {}
local Context_mt = { __index = mtscad.Context }

-- copy the current context
function mtscad.Context:clone()
    return mtscad.create_context(self.pos, self.rotation, self.node)
end

-- create a new context with given (optional) params
function mtscad.create_context(pos, rotation, node)
    local self = {
        pos = pos and vector.copy(pos) or vector.zero(),
        rotation = rotation and vector.copy(rotation) or vector.zero(),
        node = node or { name="air" }
    }
    return setmetatable(self, Context_mt)
end
