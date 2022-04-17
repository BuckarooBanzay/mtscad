local function add_rotation(a, b)
    return ((a or 0) + (b or 0)) % 360
end

function mtscad.Context:rotate(x, y, z)
    local ctx = self:clone()
    ctx.rotation.x = add_rotation(ctx.rotation.x, x)
    ctx.rotation.y = add_rotation(ctx.rotation.y, y)
    ctx.rotation.z = add_rotation(ctx.rotation.z, z)
    return ctx
end

