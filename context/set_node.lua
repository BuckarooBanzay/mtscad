function mtscad.Context:set_node()
    -- get node name and param2
    local node = self.nodefactory and self.nodefactory(self.param2) or { name="air" }
    if not node.param2 and self.param2 then
        node.param2 = self.param2
    end

    -- rotate param2
    local tnode = mtscad.transform_node(node, self.rotation)
    if self.mirror_pos.x == -1 or self.mirror_pos.z == -1 then
        tnode.param2 = mtscad.rotate_facedir(2, "y-", tnode.param2)
    end
    if self.mirror_pos.y == -1 then
        tnode.param2 = mtscad.rotate_facedir(2, "x-", tnode.param2)
    end

    -- scale region
    if self.scale_pos.x > 1 or self.scale_pos.y > 1 or self.scale_pos.z > 1 then
        self
        :reset_scale()
        :cube(self.scale_pos.x, self.scale_pos.y, self.scale_pos.z)
    else
        minetest.set_node(self.pos, tnode)
    end

    -- update extents
    mtscad.extents(self.session.min, self.session.max, self.pos)
    return self
end

