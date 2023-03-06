
function mtscad.Context:scale(x, y, z)
    local ctx = self:clone()
    ctx.scale_pos.x = ctx.scale_pos.x * x
    ctx.scale_pos.y = ctx.scale_pos.y * y
    ctx.scale_pos.z = ctx.scale_pos.z * z
    return ctx
end

function mtscad.Context:reset_scale()
    local ctx = self:clone()
    ctx.scale_pos = vector.new(1,1,1)
    return ctx
end