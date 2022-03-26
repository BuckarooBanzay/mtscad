local Context = {}
local Context_mt = { __index = Context }

function Context:translate(x, y, z)
    local newpos = vector.add(self.pos, {
        x = x or 0,
        y = y or 0,
        z = z or 0
    })
    local ctx = self:clone()
    ctx.pos = newpos
    return ctx
end

function Context:with(node)
    self.node = node
    return self
end

function Context:set()
    minetest.set_node(self.pos, self.node)
    return self
end

function Context:cube(x, y, z)
    local pos2 = vector.add(self.pos, {x=x, y=y, z=z})
    for xi=self.pos.x,pos2.x do
        for yi=self.pos.y,pos2.y do
            for zi=self.pos.z,pos2.z do
                minetest.set_node({ x=xi, y=yi, z=zi }, self.node)
            end
        end
    end
    return self
end

function Context:clone()
    return mtscad.create_context(self.pos, self.rotation, self.node)
end

function mtscad.create_context(pos, rotation, node)
    local self = {
        pos = pos and vector.copy(pos) or vector.zero(),
        rotation = rotation and vector.copy(rotation) or vector.zero(),
        node = node or { name="air" }
    }
    return setmetatable(self, Context_mt)
end
