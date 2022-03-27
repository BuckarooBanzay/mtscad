
function mtscad.Context:with(node_or_nodename)
    local ctx = self:clone()
    ctx.node = type(node_or_nodename) == "string" and {name=node_or_nodename} or node_or_nodename
    return ctx
end

function mtscad.Context:set_node()
    local tnode = mtscad.transform_node(self.node, self.rotation)
    minetest.set_node(self.pos, tnode)
    return self
end

