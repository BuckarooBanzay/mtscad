
function mtscad.Context:translate(x, y, z)
    -- offset position
    local opos = {
        x = x or 0,
        y = y or 0,
        z = z or 0
    }
    local ctx = self:clone()
    local m = mtscad.multiply_matrix(self.rotation, mtscad.pos_to_matrix(opos))
    ctx.pos = vector.add(self.pos, mtscad.matrix_to_pos(m))
    return ctx
end
