
function mtscad.Context:grid(x, y, z)
    -- TODO: prevent negative sizes
    local pos1 = vector.copy(self.pos)
    local pos2 = vector.add(self.pos, {x=x-1, y=y-1, z=z-1})

    -- TODO: lines between outer positions
    for xi=pos1.x,pos2.x,x-1 do
        for yi=pos1.y,pos2.y,y-1 do
            for zi=pos1.z,pos2.z,z-1 do
                local ipos = { x=xi, y=yi, z=zi }
                local tpos = mtscad.transform_pos(pos1, ipos, self.rotation)
                local tnode = mtscad.transform_node(self.node, self.rotation)
                minetest.set_node(tpos, tnode)
            end
        end
    end
    return self
end

