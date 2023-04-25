function mtscad.Context:set_node()
    -- get node name and param2
    local node = self.nodefactory and self.nodefactory(self.param2) or { name="air" }
    if not node.node_param2 and self.node_param2 then
        node.param2 = self.node_param2
    end

    -- rotate param2
    local tnode = mtscad.transform_node(node, self.rotation)
    if self.mirror_pos.x == -1 or self.mirror_pos.z == -1 then
        tnode.param2 = mtscad.rotate_facedir(2, "y-", tnode.param2)
    end
    if self.mirror_pos.y == -1 then
        tnode.param2 = mtscad.rotate_facedir(2, "x-", tnode.param2)
    end

    minetest.set_node(self.pos, tnode)

    -- update extents
    mtscad.extents(self.session.min, self.session.max, self.pos)
    return self
end

