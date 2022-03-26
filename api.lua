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
    local tpos = mtscad.transform_pos(self.pos, vector.add(opos, self.pos), self.rotation)
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

local slope_param2 = {
    ["1,1,0"] = 3,
    ["1,-1,0"] = 21,
    ["0,1,1"] = 2,
    ["0,-1,1"] = 22,
    ["-1,1,0"] = 1,
    ["-1,-1,0"] = 23,
    ["0,1,-1"] = 0,
    ["0,-1,-1"] = 20
}

local function format_pos(p)
    return p.x .. "," .. p.y .. "," .. p.z
end

local function get_stairsplus_nodename(name, stairtype)
    --[[
    "moreblocks:slope_stone"
    "moreblocks:stair_stone"
    "default:stone"
    --]]
end

function Context:slope(dir)
    local ctx = self:clone()
    ctx.node.param2 = slope_param2[format_pos(dir)]
    return ctx
end

function Context:set_node()
    print("set_node", dump(self))
    local tnode = mtscad.transform_node(self.node, self.rotation)
    minetest.set_node(self.pos, tnode)
    return self
end

function Context:cube(x, y, z)
    local pos2 = vector.add(self.pos, {x=x-1, y=y-1, z=z-1})
    for xi=self.pos.x,pos2.x do
        for yi=self.pos.y,pos2.y do
            for zi=self.pos.z,pos2.z do
                local ipos = { x=xi, y=yi, z=zi }
                local tpos = mtscad.transform_pos(self.pos, ipos, self.rotation)
                local tnode = mtscad.transform_node(self.node, self.rotation)
                minetest.set_node(tpos, tnode)
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
