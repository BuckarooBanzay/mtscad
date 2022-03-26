function mtscad.Context:cube(x, y, z)
    local pos2 = vector.add(self.pos, {x=x-1, y=y-1, z=z-1})
    for xi=self.pos.x,pos2.x do
        for yi=self.pos.y,pos2.y do
            for zi=self.pos.z,pos2.z do
                local ipos = { x=xi, y=yi, z=zi }
                local tpos = mtscad.transform_pos(self.pos, ipos, self.rotation)
                local tnode = mtscad.transform_node(self.node, self.rotation)
                minetest.set_node(tpos, tnode)
            end
        end
    end
    return self
end

