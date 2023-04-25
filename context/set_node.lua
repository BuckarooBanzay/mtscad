function mtscad.Context:set_node()
    local node = { name="air" }

    if type(self.node_spec) == "string" then
        node = { name=self.node_spec }
    elseif type(self.node_spec) == "table" then
        node = self.node_spec
    elseif type(self.node_spec) == "function" then
        node = self.node_spec()
    end

    -- default param2
    node.param2 = node.param2 or 0

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

