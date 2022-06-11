function mtscad.Context:set_node()
    local node = self.nodefactory and self.nodefactory(self.param2) or { name="air" }
    if not node.param2 and self.param2 then
        node.param2 = self.param2
    end
    local tnode = mtscad.transform_node(node, self.rotation)
    minetest.set_node(self.pos, tnode)
    mtscad.extents(self.session.min, self.session.max, self.pos)
    return self
end

