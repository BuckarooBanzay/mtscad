

local function create_nodefactory(def)
    if type(def) == "string" then
        -- string
        return function()
            return { name=def }
        end
    elseif type(def) == "table" and def.nodefactory then
        -- other context with nodefactory
        return def.nodefactory

    elseif type(def) == "table" and def.name then
        -- node table
        return function()
            return def
        end

    elseif type(def) == "table" then
        -- multiple nodes with chance value
        local nodes = {}
        for nn, ch in pairs(def) do
            for _=1,ch do
                table.insert(nodes, nn)
            end
        end
        return function()
            return { name=nodes[math.random(#nodes)], param2=0 }
        end
    end
end

function mtscad.Context:with(def)
    local ctx = self:clone()
    ctx.nodefactory = create_nodefactory(def)
    return ctx
end

function mtscad.Context:set_node()
    local node = self.nodefactory and self.nodefactory() or { name="air" }
    if not node.param2 and self.param2 then
        node.param2 = self.param2
    end
    local tnode = mtscad.transform_node(node, self.rotation)
    minetest.set_node(self.pos, tnode)
    return self
end

