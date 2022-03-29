mtscad.Context = {}
local Context_mt = { __index = mtscad.Context }

-- copy the current context
function mtscad.Context:clone()
    return mtscad.create_context(self.pos, self.rotation, self.nodefactory, self.param2)
end

-- create a new context with given (optional) params
function mtscad.create_context(pos, rotation, nodefactory, param2)
    local self = {
        pos = pos and vector.copy(pos) or vector.zero(),
        rotation = rotation and vector.copy(rotation) or vector.zero(),
        nodefactory = nodefactory,
        param2 = param2 or 0
    }
    return setmetatable(self, Context_mt)
end
