local Context = {}
local Context_mt = { __index = Context }

function Context:translate(x, y, z)
    -- offset position
    local opos = {
        x = x or 0,
        y = y or 0,
        z = z or 0
    }
    -- transformed position
    local tpos = mtscad.transform_pos(self.pos, opos, self.rotation)
    local ctx = self:clone()
    ctx.pos = tpos
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

function Context:execute(fn)
    fn(self)
    return self
end

function Context:cube(x, y, z)
    local pos2 = vector.add(self.pos, {x=x, y=y, z=z})
    for xi=self.pos.x,pos2.x do
        for yi=self.pos.y,pos2.y do
            for zi=self.pos.z,pos2.z do
                local ipos = { x=xi, y=yi, z=zi }
                local tpos = mtscad.transform_pos(self.pos, ipos, self.rotation)
                minetest.set_node(tpos, self.node)
            end
        end
    end
    return self
end

local function add_rotation(a, b)
    -- TODO: only 90°-increments allowed
    a = a or 0
    b = b or 0
    local sum = a + b
    while sum >= 360 do
        sum = sum - 360
    end
    return sum
end

function Context:rotate(x, y, z)
    local ctx = self:clone()
    ctx.rotation.x = add_rotation(ctx.rotation.x, x)
    ctx.rotation.y = add_rotation(ctx.rotation.y, y)
    ctx.rotation.z = add_rotation(ctx.rotation.z, z)
    return ctx
end

-- copy the current context
function Context:clone()
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

local function flip_pos(rel_pos, max, axis)
	rel_pos[axis] = max[axis] - rel_pos[axis]
end

local function transpose_pos(rel_pos, axis1, axis2)
	rel_pos[axis1], rel_pos[axis2] = rel_pos[axis2], rel_pos[axis1]
end

function mtscad.transform_pos(origin, pos, rotation)
    -- TODO: verify max-pos
    local rel_pos = vector.subtract(pos, origin)
    if rotation.y == 90 then
        flip_pos(rel_pos, rel_pos, "z")
		transpose_pos(rel_pos, "x", "z")
    elseif rotation.y == 180 then
        flip_pos(rel_pos, rel_pos, "x")
        flip_pos(rel_pos, rel_pos, "z")
    elseif rotation.y == 270 then
        flip_pos(rel_pos, rel_pos, "x")
        transpose_pos(rel_pos, "x", "z")
    end
    -- TODO
    return pos
end