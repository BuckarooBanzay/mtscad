
function mtscad.Context:with(node)
    self.node = node
    return self
end

function mtscad.Context:execute(fn)
    fn(self)
    return self
end

function mtscad.Context:set_node()
    local tnode = mtscad.transform_node(self.node, self.rotation)
    minetest.set_node(self.pos, tnode)
    return self
end

