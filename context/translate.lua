
function mtscad.Context:translate(x, y, z)
    -- offset position
    local opos = {
        x = x or 0,
        y = y or 0,
        z = z or 0
    }
    local ctx = self:clone()

    -- rotate
    local m = mtscad.multiply_matrix(self.rotation, mtscad.pos_to_matrix(opos))
    local rel_pos = mtscad.matrix_to_pos(m)

    -- apply mirror factor
    rel_pos = vector.multiply(self.mirror_pos, rel_pos)

    -- apply scale factor
    rel_pos = vector.multiply(rel_pos, self.scale_pos)

    ctx.pos = vector.add(self.pos, rel_pos)
    return ctx
end
