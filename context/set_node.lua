function mtscad.Context:set_node()
    local node = self.nodefactory and self.nodefactory(self.param2) or { name="air" }
    if not node.param2 and self.param2 then
        node.param2 = self.param2
    end
    local tnode = mtscad.transform_node(node, self.rotation)

    if self.pos_factor.x == -1 or self.pos_factor.z == -1 then
        tnode.param2 = mtscad.rotate_facedir(2, "y-", tnode.param2)
    end
    if self.pos_factor.y == -1 then
        tnode.param2 = mtscad.rotate_facedir(2, "x-", tnode.param2)
    end

    minetest.set_node(self.pos, tnode)
    mtscad.extents(self.session.min, self.session.max, self.pos)
    return self
end

