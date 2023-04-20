

local function create_nodefactory(def)
    if type(def) == "string" then
        -- string
        return function(param2)
            return { name=def, param2=param2 }
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
        return function(param2)
            return { name=nodes[math.random(#nodes)], param2=param2 }
        end
    end
end

function mtscad.Context:with(def)
    local ctx = self:clone()
    ctx.nodefactory = create_nodefactory(def, self.node_param2)
    return ctx
end

