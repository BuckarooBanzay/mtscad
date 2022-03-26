
function mtscad.Context:translate(x, y, z)
    -- offset position
    local opos = {
        x = x or 0,
        y = y or 0,
        z = z or 0
    }
    -- transformed position
    local tpos = mtscad.transform_pos(self.pos, vector.add(opos, self.pos), self.rotation)
    local ctx = self:clone()
    ctx.pos = tpos
    return ctx
end
