
function mtscad.Context:with(node)
    local ctx = self:clone()
    ctx.node = node
    return ctx
end

function mtscad.Context:set_node()
    local tnode = mtscad.transform_node(self.node, self.rotation)
    minetest.set_node(self.pos, tnode)
    return self
end

