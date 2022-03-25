local Context = {}
local Context_mt = { __index = Context }

function Context:setpos(p)
    self.pos = p
end

function Context:translate(o)
    o.x = o.x or 0
    o.y = o.y or 0
    o.z = o.z or 0
    self.pos = vector.add(self.pos, o)
end

function Context:set_nodename(nn)
    self.nodename = nn
end

function Context:setnode(name, param2)
    minetest.set_node(self.pos, {
        name = name or self.nodename,
        param2 = param2
    })
end

function Context:line(axis, length)
    local old_pos = vector.copy(self.pos)
    for _=0,length do
        self:setnode()
        self:translate({ [axis] = 1 })
        self:setnode()
    end
    self:setpos(old_pos)
end

function Context:draw(compiled, transform)
    -- TODO
end

function mtscad.create_context(origin)
    local self = {
        origin = origin,
        pos = vector.copy(origin),
        nodename = "air"
    }
    return setmetatable(self, Context_mt)
end

function mtscad.compile(fn)
    -- TODO
end